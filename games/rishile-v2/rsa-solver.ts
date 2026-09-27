import { decodeBase64 } from "jsr:@std/encoding/base64";

// ============================================================
// ARGUMENTS
// ============================================================

if (Deno.args.length !== 4) {
  console.error(
    "Usage:\n" +
    "  deno run -A rsa-solver.ts <n> <e> <iv_base64> <ciphertext_base64> < encrypted.txt\n\n" +
    "Example:\n" +
    "  deno run -A rsa-solver.ts " +
    '"1000000016000000063" "65537" "BASE64_IV" "BASE64_CIPHERTEXT" < encrypted.txt',
  );

  Deno.exit(1);
}

const [nArg, eArg, ivB64, encryptedFlagB64] =
  Deno.args;

const n = BigInt(nArg);
const e = BigInt(eArg);

// ============================================================
// READ RSA BLOCK FROM STDIN UNTIL EOF
// ============================================================

const input = await new Response(
  Deno.stdin.readable,
).text();

const match = input.match(
  /-----BEGIN COMPRESSED RSA ENCRYPTED MESSAGE-----[\s\S]*?-----END COMPRESSED RSA ENCRYPTED MESSAGE-----/,
);

if (!match) {
  throw new Error(
    "Could not find BEGIN/END RSA encrypted message in stdin",
  );
}

const rsaBlock = match[0];

// ============================================================
// EXTRACT RSA BASE64
// ============================================================

const rsaMatch = rsaBlock.match(
  /Scheme:\s*Crypt::RSA::ES::OAEP\s*\n\s*\n([A-Za-z0-9+/=]+)/,
);

if (!rsaMatch) {
  throw new Error(
    "Could not find RSA ciphertext inside encrypted message",
  );
}

const encryptedSecretB64 =
  rsaMatch[1].trim();

console.error("[+] RSA block found");
console.error(`[+] n = ${n}`);
console.error(`[+] e = ${e}`);

// ============================================================
// BIGINT MATH
// ============================================================

function gcd(a: bigint, b: bigint): bigint {
  while (b !== 0n) {
    [a, b] = [b, a % b];
  }

  return a;
}

function extendedGcd(
  a: bigint,
  b: bigint,
): [bigint, bigint, bigint] {
  if (b === 0n) {
    return [a, 1n, 0n];
  }

  const [g, x1, y1] =
    extendedGcd(b, a % b);

  return [
    g,
    y1,
    x1 - (a / b) * y1,
  ];
}

function modInverse(
  a: bigint,
  m: bigint,
): bigint {
  const [g, x] =
    extendedGcd(a, m);

  if (g !== 1n) {
    throw new Error(
      "Could not calculate modular inverse",
    );
  }

  return ((x % m) + m) % m;
}

function modPow(
  base: bigint,
  exponent: bigint,
  modulus: bigint,
): bigint {
  let result = 1n;

  base %= modulus;

  while (exponent > 0n) {
    if (exponent & 1n) {
      result =
        (result * base) % modulus;
    }

    base =
      (base * base) % modulus;

    exponent >>= 1n;
  }

  return result;
}

// ============================================================
// BYTES <-> BIGINT
// ============================================================

function bytesToBigInt(
  bytes: Uint8Array,
): bigint {
  let result = 0n;

  for (const byte of bytes) {
    result =
      (result << 8n) | BigInt(byte);
  }

  return result;
}

function bigIntToBytes(
  value: bigint,
): Uint8Array {
  if (value === 0n) {
    return new Uint8Array([0]);
  }

  const bytes: number[] = [];

  while (value > 0n) {
    bytes.push(
      Number(value & 0xffn),
    );

    value >>= 8n;
  }

  bytes.reverse();

  return new Uint8Array(bytes);
}

// ============================================================
// FACTOR N
// ============================================================

function factor(
  value: bigint,
): [bigint, bigint] {
  console.error("[+] Factoring n...");

  if (value % 2n === 0n) {
    return [2n, value / 2n];
  }

  let p = 3n;

  while (p * p <= value) {
    if (value % p === 0n) {
      return [p, value / p];
    }

    p += 2n;
  }

  throw new Error(
    "Could not factor n",
  );
}

const [p, q] = factor(n);

console.error(`[+] p = ${p}`);
console.error(`[+] q = ${q}`);

// ============================================================
// CALCULATE PRIVATE KEY
// ============================================================

const phi =
  (p - 1n) * (q - 1n);

const d =
  modInverse(e, phi);

console.error(`[+] phi = ${phi}`);
console.error(`[+] d = ${d}`);

// ============================================================
// RSA DECRYPT
// ============================================================

const encryptedSecret =
  decodeBase64(
    encryptedSecretB64,
  );

const encryptedSecretInt =
  bytesToBigInt(
    encryptedSecret,
  );

const secretInt =
  modPow(
    encryptedSecretInt,
    d,
    n,
  );

const secret =
  bigIntToBytes(secretInt);

console.error(
  `[+] secret = ${Array.from(secret)
    .map((x) =>
      x.toString(16).padStart(2, "0")
    )
    .join("")}`,
);

// ============================================================
// SHA-256 -> AES-256
// ============================================================

const aesKeyMaterial =
  new Uint8Array(
    await crypto.subtle.digest(
      "SHA-256",
      secret,
    ),
  );

console.error("[+] AES key derived");

// ============================================================
// AES-GCM DECRYPT
// ============================================================

const aesKey =
  await crypto.subtle.importKey(
    "raw",
    aesKeyMaterial,
    {
      name: "AES-GCM",
    },
    false,
    ["decrypt"],
  );

const iv =
  decodeBase64(ivB64);

const encryptedFlag =
  decodeBase64(
    encryptedFlagB64,
  );

const plaintext =
  await crypto.subtle.decrypt(
    {
      name: "AES-GCM",
      iv,
    },
    aesKey,
    encryptedFlag,
  );

// ============================================================
// FLAG
// ============================================================

const flag =
  new TextDecoder().decode(
    plaintext,
  );

console.log(flag);

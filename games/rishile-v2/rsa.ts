import { encodeBase64 } from "jsr:@std/encoding/base64";

// ============================================================
// CONFIG
// ============================================================

const FLAG = "the secret key is the thing to get for part 2 of url";

const P = 1000000007n;
const Q = 1000000009n;
const E = 65537n;

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

  const [g, x1, y1] = extendedGcd(b, a % b);

  return [
    g,
    y1,
    x1 - (a / b) * y1,
  ];
}

function modInverse(a: bigint, m: bigint): bigint {
  const [g, x] = extendedGcd(a, m);

  if (g !== 1n) {
    throw new Error("Modular inverse does not exist");
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
      result = (result * base) % modulus;
    }

    base = (base * base) % modulus;
    exponent >>= 1n;
  }

  return result;
}

// ============================================================
// BYTE <-> BIGINT
// ============================================================

function bytesToBigInt(bytes: Uint8Array): bigint {
  let result = 0n;

  for (const byte of bytes) {
    result = (result << 8n) | BigInt(byte);
  }

  return result;
}

function bigIntToBytes(value: bigint): Uint8Array {
  if (value === 0n) {
    return new Uint8Array([0]);
  }

  const bytes: number[] = [];

  while (value > 0n) {
    bytes.push(Number(value & 0xffn));
    value >>= 8n;
  }

  bytes.reverse();

  return new Uint8Array(bytes);
}

// ============================================================
// RSA PARAMETERS
// ============================================================

const n = P * Q;
const phi = (P - 1n) * (Q - 1n);

if (gcd(E, phi) !== 1n) {
  throw new Error("E is not coprime with phi");
}

const D = modInverse(E, phi);

// ============================================================
// GENERATE SMALL RSA SECRET
// ============================================================
//
// n is ~60 bits, so we cannot RSA-encrypt a 256-bit AES key.
//
// Instead:
//   random 6-byte secret
//       ↓
//   RSA encrypt
//       ↓
//   SHA-256(secret)
//       ↓
//   256-bit AES key
//

let secret: Uint8Array;
let secretInt: bigint;

do {
  secret = crypto.getRandomValues(new Uint8Array(6));
  secretInt = bytesToBigInt(secret);
} while (secretInt >= n || secretInt === 0n);

// Raw RSA encryption
const encryptedSecretInt = modPow(
  secretInt,
  E,
  n,
);

const encryptedSecret = bigIntToBytes(
  encryptedSecretInt,
);

// ============================================================
// DERIVE AES-256 KEY
// ============================================================

const aesKeyMaterial = new Uint8Array(
  await crypto.subtle.digest(
    "SHA-256",
    secret,
  ),
);

// ============================================================
// AES-256-GCM ENCRYPTION
// ============================================================

const aesKey = await crypto.subtle.importKey(
  "raw",
  aesKeyMaterial,
  {
    name: "AES-GCM",
  },
  false,
  ["encrypt"],
);

const iv = crypto.getRandomValues(
  new Uint8Array(12),
);

const plaintext = new TextEncoder().encode(FLAG);

const encryptedFlag = new Uint8Array(
  await crypto.subtle.encrypt(
    {
      name: "AES-GCM",
      iv,
    },
    aesKey,
    plaintext,
  ),
);

// ============================================================
// BASE64
// ============================================================

const encryptedSecretB64 =
  encodeBase64(encryptedSecret);

const ivB64 =
  encodeBase64(iv);

const encryptedFlagB64 =
  encodeBase64(encryptedFlag);

const secretB64 =
  encodeBase64(secret);

const aesKeyB64 =
  encodeBase64(aesKeyMaterial);

// ============================================================
// RSA MESSAGE FORMAT
// ============================================================

const rsaMessage = `-----BEGIN COMPRESSED RSA ENCRYPTED MESSAGE-----
Version: 1.99
Scheme: Crypt::RSA::ES::OAEP

${encryptedSecretB64}
-----END COMPRESSED RSA ENCRYPTED MESSAGE-----`;

// ============================================================
// CHALLENGE
// ============================================================

const challenge = `RSA FACTORIZATION CHALLENGE

You intercepted the following encrypted message.

Your task:
1. Factor n.
2. Recover p and q.
3. Calculate the RSA private exponent d.
4. Decrypt the RSA secret.
5. Derive the AES-256 key using SHA-256.
6. Decrypt the AES-GCM ciphertext.

Public RSA parameters:

n = ${n}
e = ${E}

Encrypted message:

${rsaMessage}

AES-GCM IV:

${ivB64}

AES-GCM ciphertext:

${encryptedFlagB64}
`;

// ============================================================
// SOLUTION
// ============================================================

const solution = `RSA CHALLENGE SOLUTION

p = ${P}
q = ${Q}

n = ${n}

phi = ${phi}

e = ${E}

d = ${D}

RSA secret (Base64) = ${secretB64}

RSA secret (integer) = ${secretInt}

AES-256 key (SHA-256(secret), Base64) = ${aesKeyB64}

IV (Base64) = ${ivB64}

AES-GCM ciphertext (Base64) = ${encryptedFlagB64}

FLAG = ${FLAG}
`;

// ============================================================
// STDOUT
// ============================================================
//
// stdout = challenge
// stderr = solution
//
// Dzięki temu:
//   deno run rsa.ts > challenge.txt
//
// zapisze tylko challenge do pliku.
// Rozwiązanie możesz podejrzeć na stderr.
//

console.log(challenge);

console.error(
  "\n========== SOLUTION ==========\n" +
    solution,
);

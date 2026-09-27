function encode(text: string): number[] {
    const ascii = [...text].map(c => c.charCodeAt(0));

    const result: number[] = [];
    let current = 1000;

    for (const value of ascii) {
        current += value;
        result.push(current);
    }

    return result;
}

function decode(numbers: number[]): string {
    let previous = 1000;

    return numbers
        .map(n => {
            const value = n - previous;
            previous = n;
            return String.fromCharCode(value);
        })
        .join("");
}

const message = "part 5: lkrt";

const numbers = encode(message);

console.log("=== PUZZLE ===");
console.log(numbers.join(" "));

console.log("\n=== SOLUTION CHECK ===");
console.log(decode(numbers));

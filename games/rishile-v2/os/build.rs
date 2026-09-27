use std::{env, path::PathBuf, process::Command};

fn do_asm_compilation(source: &str, out: &str) {
    let out_dir = PathBuf::from(env::var("OUT_DIR").unwrap());
    let output = out_dir.join(out);

    let status = Command::new("nasm")
        .args([
            "-f",
            "elf64",
            source,
            "-o",
            output.to_str().unwrap(),
        ])
        .status()
        .expect("failed to execute nasm");

    assert!(status.success(), "nasm failed");

    println!("cargo:rustc-link-arg={}", output.display());
    println!("cargo:rerun-if-changed={}", source); 
}

pub fn main() {
    do_asm_compilation("src/init/asm/idt.asm", "idt.o");
    do_asm_compilation("src/init/asm/gdt.asm", "gdt.o");
}

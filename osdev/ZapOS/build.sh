#!/usr/bin/env -S bash --posix

shopt -s globstar
set -e
set -o pipefail

if command -v zapup >/dev/null 2>&1; then
    echo "ZapUP installed!"
else
    echo "Installing Zap using ZapUP"

    if command -v zapc >/dev/null 2>&1; then
        echo "Zap is already installed on your system, but not using ZapUP."
        echo "ZapOS recommends using ZapUP instead."
        exit 1
    fi

    echo "Installing ZapUP"
    curl -sS https://raw.githubusercontent.com/Maqi-x/zapup/refs/heads/main/quick-install.sh | bash

    echo "Installing LLVM version 21 for Arch Linux"
    if command -v pacman >/dev/null 2>&1; then
        pacman -S --needed llvm21
    else
        echo "Skipping; no \`pacman\` or not Arch Linux."
    fi

    echo "Installing latest version of Zap"
    /usr/local/bin/zapup install -j$(nproc) latest
    /usr/local/bin/zapup switch latest
fi

alias zapc='$(/usr/local/bin/zapup which zapc)'

find src -type f -name "*.zp" | while read -r file; do
    rel="${file#src/}"
    out="obj/${rel%.zp}.o"
    mkdir -p "$(dirname "$out")"
    zapc --allow-unsafe -nostdlib -c "$file" -o "$out"
done

mkdir -p obj/low-level/

nasm -f elf64 ./src/low-level/multiboot.asm -o obj/low-level/multiboot.o
gcc -m64 -nostdlib -c ./src/low-level/print_char.c -o ./obj/low-level/print_char.o

echo "Linking kernel..."

mkdir -p iso/boot

OBJ_FILES=$(find obj -type f -wholename "**/*.o")

ld -nostdlib -m elf_x86_64 -T ./src/low-level/linker.ld -o iso/boot/kernel.bin $OBJ_FILES

echo "Preparing ISO..."

mkdir -p iso/boot/grub

cat > iso/boot/grub/grub.cfg <<EOF
set timeout=5
set default=0

menuentry "ZapOS" {
    multiboot2 /boot/kernel.bin
    boot
}
EOF

echo "Building ISO..."

grub-mkrescue -o ZapOS.iso iso

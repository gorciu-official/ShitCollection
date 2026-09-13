BITS 64

section .multiboot
align 8

; minimalny nagłówek Multiboot2
dd 0xE85250D6       ; magic
dd 0                 ; flags
dd -(0xE85250D6 + 0) ; checksum

section .text

global _start
extern zap$src$mai$start$

_start:
    cli
    call zap$src$mai$start$
    hlt

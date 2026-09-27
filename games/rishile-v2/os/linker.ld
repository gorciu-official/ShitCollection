ENTRY(kmain)

PHDRS
{
    text PT_LOAD FLAGS(5); /* R + X */
    rodata PT_LOAD FLAGS(4); /* R */
    data PT_LOAD FLAGS(6); /* R + W */
}

SECTIONS
{
    . = 0xffffffff80000000;

    .text ALIGN(CONSTANT(MAXPAGESIZE)) :
    {
        *(.text .text.*)
    } :text

    .rodata ALIGN(CONSTANT(MAXPAGESIZE)) :
    {
        *(.rodata .rodata.*)

        . = ALIGN(8);
        KEEP(*(.limine_requests_start))
        KEEP(*(.limine_requests))
        KEEP(*(.limine_requests_end))
    } :rodata

    .data ALIGN(CONSTANT(MAXPAGESIZE)) :
    {
        *(.data .data.*)
    } :data

    .bss ALIGN(CONSTANT(MAXPAGESIZE)) :
    {
        *(COMMON)
        *(.bss .bss.*)
    } :data

    limine_requests : ALIGN(8)
    {
        KEEP(*(.limine_requests_start))
        KEEP(*(.limine_requests))
        KEEP(*(.limine_requests_end))
    } :data
}

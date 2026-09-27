#[inline(always)]
pub fn outb(port: u16, value: u8) {
unsafe {
    core::arch::asm!(
        "out dx, al",
        in("dx") port,
        in("al") value,
        options(nomem, nostack, preserves_flags)
    );
}
}

#[inline(always)]
pub fn inb(port: u16) -> u8 {
unsafe {
    let value: u8;

    core::arch::asm!(
        "in al, dx",
        in("dx") port,
        out("al") value,
        options(nomem, nostack, preserves_flags)
    );

    value
}
}

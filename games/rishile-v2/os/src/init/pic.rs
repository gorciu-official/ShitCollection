use crate::utils::ports::{outb, inb};

const PIC1_CMD: u16 = 0x20;
const PIC1_DATA: u16 = 0x21;
const PIC2_CMD: u16 = 0xA0;
const PIC2_DATA: u16 = 0xA1;

#[inline(always)]
fn io_wait() {
    outb(0x80, 0);
}

pub fn remap(offset1: u8, offset2: u8) {
    let a1 = inb(PIC1_DATA);
    let a2 = inb(PIC2_DATA);

    outb(PIC1_CMD, 0x11);
    io_wait();

    outb(PIC2_CMD, 0x11);
    io_wait();

    outb(PIC1_DATA, offset1);
    io_wait();

    outb(PIC2_DATA, offset2);
    io_wait();

    outb(PIC1_DATA, 4);
    io_wait();

    outb(PIC2_DATA, 2);
    io_wait();

    outb(PIC1_DATA, 0x01);
    io_wait();

    outb(PIC2_DATA, 0x01);
    io_wait();

    outb(PIC1_DATA, a1);
    outb(PIC2_DATA, a2);

    outb(PIC1_DATA, 0xFF);
    outb(PIC2_DATA, 0xFF);
}

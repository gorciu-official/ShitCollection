use core::mem::size_of;

use crate::init::pic;

#[repr(C, packed)]
#[derive(Clone, Copy)]
pub struct IdtEntry {
    pub offset_low: u16,
    pub selector: u16,
    pub ist: u8,
    pub type_attr: u8,
    pub offset_mid: u16,
    pub offset_high: u32,
    pub reserved: u32,
}

#[repr(C, packed)]
pub struct IdtPtr {
    pub limit: u16,
    pub base: u64,
}

static mut IDT_ENTRIES: [IdtEntry; 256] = [IdtEntry {
    offset_low: 0,
    selector: 0,
    ist: 0,
    type_attr: 0,
    offset_mid: 0,
    offset_high: 0,
    reserved: 0,
}; 256];

unsafe extern "C" {
    static isr_stub_table: [u64; 32];
    static irq_stub_table: [u64; 16];

    fn idt_load(idt_ptr: u64);
}

fn idt_set_gate(
    num: usize,
    base: u64,
    selector: u16,
    flags: u8,
) {
    let entry = unsafe { &mut IDT_ENTRIES[num] };

    entry.offset_low = (base & 0xFFFF) as u16;
    entry.selector = selector;
    entry.ist = 0;
    entry.type_attr = flags;
    entry.offset_mid = ((base >> 16) & 0xFFFF) as u16;
    entry.offset_high = ((base >> 32) & 0xFFFF_FFFF) as u32;
    entry.reserved = 0;
}

pub fn init() {
    pic::remap(0x20, 0x28);

    let idt_ptr = IdtPtr {
        limit: (size_of::<IdtEntry>() * 256 - 1) as u16,
        base: core::ptr::addr_of!(IDT_ENTRIES) as u64,
    };

    for i in 0..256 {
        idt_set_gate(i, 0, 0, 0);
    }

    for i in 0..32 {
        let handler = unsafe { isr_stub_table[i] };

        idt_set_gate(
            i,
            handler,
            0x08,
            0x8E,
        );
    }

    for i in 0..16 {
        let handler = unsafe { irq_stub_table[i] };

        idt_set_gate(
            32 + i,
            handler,
            0x08,
            0x8E,
        );
    }

    unsafe {
        idt_load(core::ptr::addr_of!(idt_ptr) as u64);
    }
}

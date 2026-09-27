#![no_std]
#![no_main]

mod utils;
mod init;

use core::panic::PanicInfo;

use crate::utils::screen;
use crate::utils::ports::outb;
use crate::init::{gdt, idt};

#[repr(C)]
pub struct Registers {
    pub r15: u64,
    pub r14: u64,
    pub r13: u64,
    pub r12: u64,
    pub r11: u64,
    pub r10: u64,
    pub r9: u64,
    pub r8: u64,

    pub rbp: u64,
    pub rdi: u64,
    pub rsi: u64,
    pub rdx: u64,
    pub rcx: u64,
    pub rbx: u64,
    pub rax: u64,

    pub int_no: u64,
    pub err_code: u64,

    pub rip: u64,
    pub cs: u64,
    pub rflags: u64,
    pub rsp: u64,
    pub ss: u64,
}

#[unsafe(no_mangle)]
pub extern "C" fn kmain() -> ! {
    gdt::init();
    idt::init();
    screen::init();    
    
    let x: i32 = 42;
    printk!("answer to everything in life is {}", x);
    printk!("leaving this easter egg, here is a message for u: zepd 4 mq vsuovakwcn rywi mp wmwi ayyldvw sr cevmzi");
    printk!("you'll need to bruteforce the final answer");

    loop {
        core::hint::spin_loop();
    }
}

pub fn cpu_exception_name(int_no: u64) -> &'static str {
    const EXCEPTIONS: [&str; 31] = [
        "Divide Error",
        "Debug",
        "Non Maskable Interrupt",
        "Breakpoint",
        "Overflow",
        "BOUND Range Exceeded",
        "Invalid Opcode",
        "Device Not Available",
        "Double Fault",
        "Coprocessor Segment Overrun (reserved)",
        "Invalid TSS",
        "Segment Not Present",
        "Stack-Segment Fault",
        "General Protection Fault",
        "Page Fault",
        "Reserved",
        "x87 Floating-Point Exception",
        "Alignment Check",
        "Machine Check",
        "SIMD Floating-Point Exception",
        "Virtualization Exception",
        "Control Protection Exception",
        "Reserved",
        "Reserved",
        "Reserved",
        "Reserved",
        "Reserved",
        "Hypervisor Injection Exception",
        "VMM Communication Exception",
        "Security Exception",
        "Reserved",
    ];

    EXCEPTIONS
        .get(int_no as usize)
        .copied()
        .unwrap_or("Unknown")
}

#[unsafe(no_mangle)]
pub extern "C" fn isr_handler(regs: &mut Registers) {
    if regs.int_no < 32 {
        panic!("CPU exception, vector={} ({}) with rip=0x{:x} err_code=0x{:x}", regs.int_no, cpu_exception_name(regs.int_no), regs.rip, regs.err_code);
    }

    if regs.int_no >= 32 && regs.int_no <= 47 {
        if regs.int_no >= 40 {
            outb(0xA0, 0x20);
        }

        outb(0x20, 0x20);
    }
}

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    // print info 
    printk!("\n\x1b[31mKernel panic\x1b[0m: {}", info.message());
    
    if let Some(location) = info.location() {
        printk!(
            "  at {}:{}:{}",
            location.file(),
            location.line(),
            location.column()
        );
    }

    loop {
        core::hint::spin_loop();
    }
}

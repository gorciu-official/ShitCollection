use core::mem::size_of;

#[repr(C, packed)]
#[derive(Clone, Copy)]
pub struct GdtEntry {
    pub limit_low: u16,
    pub base_low: u16,
    pub base_middle: u8,
    pub access: u8,
    pub granularity: u8,
    pub base_high: u8,
}

#[repr(C, packed)]
pub struct GdtPtr {
    pub limit: u16,
    pub base: u64,
}

impl GdtEntry {
    pub const fn new(base: u32, limit: u32, access: u8, gran: u8) -> Self {
        Self {
            limit_low: (limit & 0xffff) as u16,
            base_low: (base & 0xffff) as u16,
            base_middle: ((base >> 16) & 0xff) as u8,
            access,
            granularity: (((limit >> 16) & 0x0f) as u8) | (gran & 0xf0),
            base_high: ((base >> 24) & 0xff) as u8,
        }
    }

    pub const fn null() -> Self {
        Self::new(0, 0, 0, 0)
    }

    pub const fn code() -> Self {
        Self::new(0, 0x000f_ffff, 0x9a, 0xa0)
    }

    pub const fn data() -> Self {
        Self::new(0, 0x000f_ffff, 0x92, 0xa0)
    }
}

const GDT_ENTRIES: usize = 3;

static mut GDT: [GdtEntry; GDT_ENTRIES] = [
    GdtEntry::null(),
    GdtEntry::code(),
    GdtEntry::data(),
];

static mut GDT_PTR: GdtPtr = GdtPtr {
    limit: (size_of::<[GdtEntry; GDT_ENTRIES]>() - 1) as u16,
    base: 0,
};

unsafe extern "C" {
    fn gdt_load(ptr: *const GdtPtr);
}

pub fn init() {
    unsafe {
        GDT_PTR.base = core::ptr::addr_of!(GDT) as u64;
        gdt_load(core::ptr::addr_of!(GDT_PTR));
    }
}

use core::cell::UnsafeCell;

use limine::request::FramebufferRequest;
use segterm::{fb::Framebuffer, Terminal, TerminalConfig};

static FRAMEBUFFER_REQUEST: FramebufferRequest = FramebufferRequest::new();

struct Console {
    framebuffer: UnsafeCell<Option<Framebuffer<'static>>>,
    terminal: UnsafeCell<Option<Terminal<'static>>>,
}

unsafe impl Sync for Console {}

static CONSOLE: Console = Console {
    framebuffer: UnsafeCell::new(None),
    terminal: UnsafeCell::new(None),
};

pub fn init() {
    let framebuffer = FRAMEBUFFER_REQUEST
        .response()
        .expect("no framebuffer response")
        .framebuffers()
        .first()
        .copied()
        .expect("no framebuffer");

    segterm::init();

    unsafe {
        let fb = &mut *CONSOLE.framebuffer.get();
        *fb = Some(Framebuffer::new(framebuffer));

        let fb = (*CONSOLE.framebuffer.get())
            .as_mut()
            .expect("framebuffer not initialized");

        let config = TerminalConfig {
            fg: segterm::Color::WHITE,
            bg: segterm::Color::BLACK,
            ansi: true,
            ..TerminalConfig::default()
        };

        let terminal = Terminal::new(fb, config);

        let terminal: Terminal<'static> = core::mem::transmute(terminal);

        *CONSOLE.terminal.get() = Some(terminal);

        let terminal = (*CONSOLE.terminal.get())
            .as_mut()
            .expect("terminal not initialized");

        terminal.write("segterm initialized!!!\n");
    }
}

pub fn with_terminal<F>(f: F)
where
    F: FnOnce(&mut Terminal<'static>),
{
    // SAFETY: trust me this is safe ahh comment bc cargo clippy
    unsafe {
        let terminal = (*CONSOLE.terminal.get())
            .as_mut()
            .expect("terminal not initialized");

        f(terminal);
    }
}

#[macro_export]
macro_rules! print {
    ($($arg:tt)*) => {{
        use core::fmt::Write;
        use $crate::utils::screen::with_terminal;
        with_terminal(|term| {
            core::write!(term, $($arg)*).unwrap();
        });
    }};
}

#[macro_export]
macro_rules! printk {
    () => {
        $crate::print!("\n");
    };

    ($($arg:tt)*) => {
        $crate::print!("{}\n", format_args!($($arg)*));
    };
}

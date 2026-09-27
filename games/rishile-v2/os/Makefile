TARGET := x86_64-unknown-none
KERNEL := target/$(TARGET)/release/kolejnyahhkernel
ISO := randomos.iso

CARGO := cargo
LD := rust-lld

.PHONY: all build iso run clean

all: iso

build:
	RUSTFLAGS="-C link-arg=-Tlinker.ld -C relocation-model=static" $(CARGO) build --release --target $(TARGET)

iso: build
	rm -rf iso_root
	mkdir -p iso_root/boot
	mkdir -p iso_root/boot/limine

	cp $(KERNEL) iso_root/boot/kernel.img
	cp limine.conf iso_root/boot/limine.conf

	cp external/limine/limine-bios.sys iso_root/boot/limine/
	cp external/limine/limine-bios-cd.bin iso_root/boot/limine/
	cp external/limine/limine-uefi-cd.bin iso_root/boot/limine/

	xorriso -as mkisofs \
		-b boot/limine/limine-bios-cd.bin \
		-no-emul-boot \
		-boot-load-size 4 \
		-boot-info-table \
		--efi-boot boot/limine/limine-uefi-cd.bin \
		-efi-boot-part \
		--efi-boot-image \
		-isohybrid-gpt-basdat \
		-o $(ISO) \
		iso_root

run: iso
	qemu-system-x86_64 \
		-cdrom $(ISO) \
		-m 512M \
		-serial stdio

clean:
	$(CARGO) clean
	rm -rf iso_root $(ISO)

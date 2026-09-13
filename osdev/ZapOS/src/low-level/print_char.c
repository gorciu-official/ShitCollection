#define VGA_ADDR 0xB8000 
#define VGA_WIDTH 80

typedef unsigned short uint16_t;
typedef unsigned char  uint8_t;

void print_char(char ch) {
    volatile uint16_t* vga = (uint16_t*)VGA_ADDR;
    uint16_t value = ((uint16_t)15 << 8) | (uint8_t)ch;
    vga[0] = value;
}

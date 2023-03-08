const limine = @import("limine.zig");

const my_req = limine.limine_request(0);

export fn kmain() void {
    const uart: *volatile u8 = @intToPtr(*volatile u8, 0x1000_0000);

    uart.* = 'a';

    if (@ptrToInt(my_req.response) == 0x1) {
        uart.* = 'h';
        uart.* = 'h';
        uart.* = 'h';
        uart.* = 'h';
    } else {
        uart.* = '-';
        uart.* = 'o';
        uart.* = 'k';
    }

    while (true) {}
}

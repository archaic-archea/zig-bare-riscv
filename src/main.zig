const limine = @import("limine.zig");

const my_req = limine.limine_request(0);

export fn kmain() void {
    const uart: *u8 = @intToPtr(*u8, 0x1000_0000);

    uart.* = 'a';

    while (true) {}
}

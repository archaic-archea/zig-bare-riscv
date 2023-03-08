const limine = @import("limine");

pub export const boot_info: limine.BootloaderInfo.Request = .{};
const uart: *volatile u8 = @intToPtr(*volatile u8, 0x1000_0000);

export fn kmain() void {
    uart.* = 'a';

    uart.* = '\n';

    while (true) {}
}

fn print_hex(num: anytype) void {
    var num_cpy = num;

    uart.* = '0';
    uart.* = 'x';
    while (num_cpy != 0) {
        var cur_int: u8 = (@intCast(u8, num_cpy) & 0xf) + 0x30;

        uart.* = cur_int;
        num_cpy /= 10;
    }
}
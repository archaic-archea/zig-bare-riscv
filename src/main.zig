const limine = @import("limine.zig");
const std = @import("std");

const my_req = limine.limine_request(0);

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("response: 0x{x}\n", .{my_req.response});
}

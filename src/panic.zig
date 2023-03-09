const io = @import("writer.zig");

fn kpanic(string: []const u8) void {
    var uart = io.Uart{};
    var writer = uart.writer();

    if (writer.print("{s}", .{string})) |_| {
    } else {
        kpanic("Failed to write");
    }

    while (true) {}
}

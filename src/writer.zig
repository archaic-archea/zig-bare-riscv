const std = @import("std");

pub const Uart = struct {
    address: *volatile u8 = @intToPtr(*volatile u8, 0x1000_0000),

    const Writer = std.io.Writer(
        *Uart,
        error{Unknown},
        derefWrite,
    );

    fn derefWrite(
        self: *Uart,
        string: []const u8,
    ) error{Unknown}!usize {
        for (string) |char| {
            self.address.* = char;
        }

        return string.len;
    }

    pub fn writer(self: *Uart) Writer {
        return .{ .context = self };
    }
};
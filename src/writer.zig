const std = @import("std");

pub const Uart = struct {
    address: *volatile u8 = @intToPtr(*volatile u8, 0x1000_0000),

    const Writer = std.io.Writer(
        *Uart,
        error{stringTooLarge},
        derefWrite,
    );

    fn derefWrite(
        self: *Uart,
        string: []const u8,
    ) error{stringTooLarge}!usize {
        var index: u32 = 0;
        var cur_char = string[0];

        while (cur_char != 0) {
            if (index >= 0x40) {
                _ = try self.derefWrite("Cannot print strings larger than 0x40");
                return error.stringTooLarge;
            }
            self.address.* = cur_char;
            index += 1;
            cur_char = string[index];
        }

        return index + 1;
    }

    pub fn writer(self: *Uart) Writer {
        return .{ .context = self };
    }
};
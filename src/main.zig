const limine = @import("limine.zig");
const std = @import("std");
const io = @import("writer.zig");

pub export var boot_info: limine.BootloaderInfoRequest = .{};

export fn kmain() void {
    var uart = io.Uart{};
    var writer = uart.writer();

    if (boot_info.response) |result| {
        var info_response = result.*;

        if (writer.print("Boot info supplied: {s} version: {s}", .{info_response.name, info_response.version})) |_| {
        } else {
            kpanic("Failed to write");
        }
        //print_str("Boot info supplied");
        //print_str(std.mem.span(info_response.name));
        //print_str(std.mem.span(info_response.version));
    } else {
        kpanic("Failed to get response to boot info request");
    }

    if (writer.print("Kernel end reached", .{})) |_| {
    } else {
        kpanic("Failed to write");
    }

    while (true) {}
}

fn kpanic(string: []const u8) void {
    var uart = io.Uart{};
    var writer = uart.writer();

    if (writer.print("{s}", .{string})) |_| {
    } else {
        kpanic("Failed to write");
    }

    while (true) {}
}
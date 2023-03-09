//const limine = @import("limine.zig");
const std = @import("std");
const io = @import("writer.zig");
const panic = @import("panic.zig");
const interrupt = @import("interrupt.zig");

//pub export var boot_info: limine.BootloaderInfoRequest = .{};
//pub export var stack_req: limine.StackSizeRequest = .{
//    .stack_size = 0x80_0000
//};

export fn kmain(hart_id: c_long, fdt_ptr: c_long, physical_address: c_long) void {
    var uart = io.Uart{};
    var writer = uart.writer();

    if (writer.print("Booting:\n\tHartID: 0x{x}\n\tFDT Pointer: 0x{x}\n\tPhysical address: 0x{x}\n", .{hart_id, fdt_ptr, physical_address})) |_| {
    } else {
        panic.kpanic("Failed to write");
    }

    while (true) {}
}

const io = @import("writer.zig");
const panic = @import("panic.zig");

const Cause = packed struct {
    int_code: u63,
    exception: u1,
};

export fn trap_handler(cause: Cause) void {
    if (cause.int_code != 7) {
        panic.kpanic("Un-expected interrupt");
    }

    if (cause.exception == 1) {
        panic.kpanic("Exception occured");
    } else {
        panic.kpanic("Interrupt occured");
    }
}
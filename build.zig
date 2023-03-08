const std = @import("std");
const deps = @import("./deps.zig");

pub fn build(b: *std.build.Builder) void {
    var target: std.zig.CrossTarget = .{
        .cpu_arch = .riscv64,
        .os_tag = .freestanding,
    };

    const Features = std.Target.riscv.Feature;
    target.cpu_features_sub.addFeature(@enumToInt(Features.m));
    target.cpu_features_sub.addFeature(@enumToInt(Features.a));
    target.cpu_features_sub.addFeature(@enumToInt(Features.c));

    //const mode = b.standardReleaseOptions();

    //const exe = b.addExecutable("lsd-zig", "src/main.zig");
    //exe.setTarget(target);
    //exe.setBuildMode(mode);
    //deps.addAllTo(exe);
    //exe.install();

    const kernel = b.addExecutable("lsd-zig", "src/main.zig");
    kernel.setTarget(target);
    kernel.addAssemblyFile("src/entry.s");
    
    deps.addAllTo(kernel);
    kernel.setLinkerScriptPath(.{ .path = "conf/linker.ld" });
    kernel.install();
}
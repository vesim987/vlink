const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const upstream = b.dependency("upstream", .{});

    const vlink = b.addExecutable(.{
        .name = "vlink",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
        }),
    });
    vlink.root_module.link_libc = true;

    vlink.root_module.addCSourceFiles(.{
        .root = upstream.path("."),
        .files = &.{
            "ar.c",
            "dir.c",
            "elf.c",
            "errors.c",
            "expr.c",
            "ldscript.c",
            "linker.c",
            "main.c",
            "pmatch.c",
            "support.c",
            "t_amigahunk.c",
            "t_aout.c",
            "t_aouti386.c",
            "t_aoutm68k.c",
            "t_aoutmint.c",
            "t_aoutnull.c",
            "t_ataritos.c",
            "t_elf32.c",
            "t_elf32arm.c",
            "t_elf32i386.c",
            "t_elf32m68k.c",
            "t_elf32ppcbe.c",
            "t_elf64.c",
            "t_elf64x86.c",
            "t_rawbin.c",
            "t_rawseg.c",
            "t_vobj.c",
            "targets.c",
            "version.c",
        },
        .flags = &.{
            "-D__DATE__=\"nope\"",
            "-D__TIME__=\"nope\"",
        },
    });

    b.installArtifact(vlink);
}

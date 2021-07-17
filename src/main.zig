const std = @import("std");
const print = std.debug.print;

pub fn readAllFiles(allocator: *std.mem.Allocator, dir: std.fs.Dir) !std.ArrayList(std.fs.Dir.Entry) {
    var contents = std.ArrayList(std.fs.Dir.Entry).init(allocator);
    var it = dir.iterate();
    while (try it.next()) |entry| {
        const copy = std.fs.Dir.Entry{
            .kind = entry.kind,
            .name = try allocator.dupe(u8, entry.name),
        };
        try contents.append(copy);
    }
    return contents;
}

pub fn freeAllFiles(allocator: *std.mem.Allocator, files: *std.ArrayList(std.fs.Dir.Entry)) void {
    for (files.items) |c| allocator.free(c.name);
    files.deinit();
}

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const dir = try std.fs.cwd().openDir(
        ".",
        .{ .iterate = true },
    );
    const path = try dir.realpathAlloc(
        &gpa.allocator,
        ".",
    );
    defer gpa.allocator.free(path);
    var contents = try readAllFiles(&gpa.allocator, dir);
    defer freeAllFiles(&gpa.allocator, &contents);
    print("Cwd: {s}\n", .{path});
    for (contents.items) |entry| {
        if (entry.kind == .File) {
            print("File: {s}\n", .{entry.name});
        } else if (entry.kind == .Directory) {
            print("Directory: {s}\n", .{entry.name});
        } else {
            print("Unknown: {s}\n", .{entry.name});
        }
    }
}

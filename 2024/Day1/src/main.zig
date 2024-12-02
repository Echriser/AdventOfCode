const std = @import("std");
const data = @embedFile("./input.txt");
const ArrayList = std.ArrayList;

pub fn main() !void {
    // parse data
    var lines = std.mem.tokenize(u8, data, "\n");

    var inputs1 = ArrayList(u32).init(std.heap.page_allocator);
    defer inputs1.deinit();
    var inputs2 = ArrayList(u32).init(std.heap.page_allocator);
    defer inputs2.deinit();

    while (lines.next()) |line| {
        // Split whitespace
        var parts = std.mem.tokenize(u8, line, " ");

        // Parse integers before appending
        try inputs1.append(try std.fmt.parseInt(u32, parts.next() orelse "0", 10));
        try inputs2.append(try std.fmt.parseInt(u32, parts.next() orelse "0", 10));
    }

    std.mem.sort(u32, inputs1.items, {}, std.sort.asc(u32));
    std.mem.sort(u32, inputs2.items, {}, std.sort.asc(u32));

    var differences = ArrayList(u32).init(std.heap.page_allocator);
    defer differences.deinit();

    // absolute value of differences
    for (inputs1.items, 0..) |v, i| {
        // probably a better way but it's a new language be nice to me :(
        try differences.append(@abs(@as(i32, @intCast(inputs2.items[i])) - @as(i32, @intCast(v))));
    }

    var sum: u32 = 0;
    for (differences.items) |v| {
        sum += v;
    }

    std.debug.print("Part 1: {}\n", .{sum});

    // Part 2
    // Number of occurances
    var occurancesum: u32 = 0;
    for (inputs1.items) |i| {
        var thisoccurance: u32 = 0;
        for (inputs2.items) |j| {
            if (i == j) {
                thisoccurance += 1;
            }
        }
        occurancesum += i * thisoccurance;
    }

    std.debug.print("Part 2: {}\n", .{occurancesum});
}

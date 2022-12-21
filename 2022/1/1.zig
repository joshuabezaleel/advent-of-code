const std = @import("std");
const data = @embedFile("./input2.txt");
const ArrayList = std.ArrayList;

fn first(input_reader: anytype) !usize {
    var buf: [1024]u8 = undefined;
    var max: usize = 0;
    var sum: usize = 0;
    while (try input_reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        if (line.len == 0) {
            if (sum > max) {
                max = sum;
            }
            sum = 0;
            continue;
        } else {
            sum = sum + try std.fmt.parseInt(usize, line, 10);
        }
    }
    if (sum > max) {
        max = sum;
    }
    return max;
}

fn second(input_reader: anytype) !usize {
    var buf: [1024]u8 = undefined;
    var max: [3]usize = .{0, 0, 0};
    var sum: usize = 0;
    while (try input_reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        if (line.len == 0) {
            if (sum > max[2]) {
                max[2] = sum;
            }
            std.sort.sort(usize, &max, {}, comptime std.sort.desc(usize));
            std.debug.print("max = {any} \n", .{max});
            sum = 0;
            continue;
        } else {
            sum = sum + try std.fmt.parseInt(usize, line, 10);
            std.debug.print("max = {any} \n", .{max});
        }
    }
    if (sum > max[2]) {
        max[2] = sum;
    }
    std.sort.sort(usize, &max, {}, comptime std.sort.desc(usize));
    return max[0] + max[1] + max[2];
}

pub fn main() !void {
    var file = try std.fs.cwd().openFile("input2.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    const answer_second = try second(in_stream);
    std.debug.print("part two = {} \n", .{answer_second});

    const answer_first = try first(in_stream);
    std.debug.print("part one = {} \n", .{answer_first});

}
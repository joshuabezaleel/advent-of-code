const std = @import("std");
const data = @embedFile("./input2.txt");
const ArrayList = std.ArrayList;

pub fn main() !void {
    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;
    var max: usize = 0;
    var sum: usize = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        if (line.len == 0) {
            if (sum > max) {
                max = sum;
            }
            sum = 0;
            continue;
        } else {
            std.debug.print("{s} {} {}\n", .{line, sum, max});
            sum = sum + try std.fmt.parseInt(usize, line, 10);
        }
    }
    std.debug.print("{} \n", .{max});
}
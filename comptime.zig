const std = @import("std");
fn multiply(a: i64, b: i64) i64 {
    return a * b;
}
fn insensitive_eql(comptime uppr: []const u8, str: []const u8) bool {
    comptime {
        var i = 0;
        while (i < uppr.len) : (i += 1) {
            if (uppr[i] >= 'a' and uppr[i] <= 'z') {
                @compileError("`uppr` must be all uppercase");
            }
        }
    }
    var i = 0;
    while (i < uppr.len) : (i += 1) {
        const val = if (str[i] >= 'a' and str[i] <= 'z')
            str[i] - 32
        else
            str[i];
        if (val != uppr[i]) return false;
    }
    return true;
}
// compile time code elision
const builtin = @import("builtin");
const fmt = std.fmt;
const io = std.io;
const Op = enum {
    Sum,
    Mul,
    Sub,
};
fn ask_user() !i64 {
    var buf: [10]u8 = undefined;
    std.debug.warn("A number please: ");
    const user_input = try io.readLineSlice(buf[0..]);
    return fmt.parseInt(i64, user_input, 10);
}
fn apply_ops(comptime operations: []const Op, num: i64) i64 {
    var acc: i64 = 0;
    inline for (operations) |op| {
        switch (op) {
            .Sum => acc +%= num,
            .Mul => acc *%= num,
            .Sub => acc -%= num,
        }
    }
    return acc;
}
// Generic functions
pub fn eql(comptime T: type, a: []const T, b: []const T) bool {
    if (a.len != b.len) return false;
    for (a) |item, index| {
        if (b[index] != item) return false;}
    return true;
}
pub fn main() void {
    const len = comptime multiply(4, 5);
    const my_static_array: [len]u8 = undefined;
    std.debug.print("{s}\n", .{my_static_array});
    const x = insensitive_eql("HELLO", "hElLo");
    std.debug.print("{}\n", .{x});
    const user_num = try ask_user();
    const ops = [4]Op{ .Sum, .Mul, .Sub };
    const y = apply_ops(ops[0..], user_num);
    std.debug.warn("Result: {}\n", y);
}

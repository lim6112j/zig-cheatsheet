const std = @import("std");
fn multiply(a: i64, b: i64) i64 {
    return a * b;
}
pub fn main() void {
    const len = comptime multiply(4, 5);
    const my_static_array: [len]u8 = undefined;
    std.debug.print("{}", my_static_array);
}

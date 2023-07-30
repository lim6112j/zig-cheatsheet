const std = @import("std");
const expect = @import("std").testing.expect;
const constant: i32 = 5;
const variable: u32 = 5000;
//@as performs an explicit type coercion
const inferred_constant = @as(i32, 5);
var inferred_variable = @as(u32, 5000);

const a: i32 = undefined;
var b: u32 = undefined;
// const values are preferred over var variables

// arrays
const c = [5]u8{'h', 'e','l','l','o'};
const d = [_]u8{'w','o','r','l','d'};

const array = [_]u8{'h','e','l','l','o'};
const length = array.len;

// if
test "if statement" {
    const a_if = true;
    var x: u16 = 0;
    if (a_if) {
        x += 1;
    } else {
        x += 2;
    }
    try expect(x == 1);
}

test "if statement expression" {
    const aa = true;
    var x: u16 = 0;
    x += if (aa) 1 else 2;
    try expect(x == 1);
}
pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"World"});
}

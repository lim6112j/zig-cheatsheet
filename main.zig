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
const c = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
const d = [_]u8{ 'w', 'o', 'r', 'l', 'd' };

const array = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
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
//while
test "while" {
    var i: u8 = 2;
    while (i < 100) {
        i *= 2;
    }
    try expect(i == 128);
}
test "while with continue expression" {
    var sum: u8 = 0;
    var i: u8 = 1;
    while (i <= 10) : (i += 1) {
        sum += i;
    }
    try expect(sum == 55);
}
test "while with continue" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) continue;
        sum += i;
    }
    try expect(sum == 4);
}
test "while with break" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) break;
        sum += i;
    }
    try expect(sum == 1);
}
test "for" {
    const string = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
    for (string[0..], 0..) |character, index| {
        _ = character;
        _ = index;
    }
    for (string) |character| {
        _ = character;
    }
    for (string[0..], 0..) |_, index| {
        _ = index;
    }
    for (string) |_| {}
}
fn addFive(x: u32) u32 {
    return x + 5;
}
test "functions" {
    const y = addFive(0);
    try expect(@TypeOf(y) == u32);
    try expect(y == 5);
}

fn fibo(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibo(n - 1) + fibo(n - 2);
}

test "function recursion" {
    const x = fibo(10);
    try expect(x == 55);
}

test "defer" {
    var x: i16 = 5;
    {
        defer x += 2;
        try expect(x == 5);
    }
    try expect(x == 7);
}

test "multi defer" {
    var x: f32 = 5;
    {
        defer x += 2;
        defer x /= 2;
    }
    try expect(x == 4.5);
}
pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"World"});
}

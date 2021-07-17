const std = @import("std");
const testing = std.testing;
const fabs = std.math.fabs;

const Vec2 = struct {
    x: f32,
    y: f32,

    pub fn init(x: f32, y: f32) Vec2 {
        return .{
            .x = x,
            .y = y,
        };
    }

    pub fn add(self: Vec2, other: Vec2) Vec2 {
        return .{
            .x = self.x + other.x,
            .y = self.y + other.y,
        };
    }

    //pub fn sub(self: Vec2, other: Vec2) Vec2 {
    //return .{
    //.x = self.x - other.x,
    //.y = self.y - other.y,
    //};
    //}

    //pub fn eq(self: Vec2, other: Vec2) bool {
    //return self.x == other.x and self.y == other.y;
    //}

    //pub fn eqEpsilon(self: Vec2, other: Vec2, epsilon: f32) bool {
    //return fabs(self.x - other.x) < epsilon and fabs(self.y - other.y) < epsilon;
    //}
};

test "Vec2" {
    var v = Vec2.init(0, 0);
    v = v.add(Vec2.init(1, 1));
    try testing.expectEqual(v, Vec2.init(1, 1));
    //try testing.expectEqual(v, v);
    //v = v.sub(v);
    //try testing.expect(v.eq(Vec2.init(0, 0)));
    //try testing.expect(v.eqEpsilon(Vec2.init(0.01, 0.01), 0.1));
}

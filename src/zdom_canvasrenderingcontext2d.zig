const zdom = @import("zdom.zig");
const std = @import("std");

extern fn __free(ref: u32) void;
extern fn __canvasContext2dArc(ctx: u32, x: i32, y: i32, radius: i32, start_angle: i32, end_angle: i32) void;
extern fn __canvasContext2dArcTo(ctx: u32, x1: i32, y1: i32, x2: i32, y2: i32, radius: f32) void;
extern fn __canvasContext2dBeginPath(ctx: u32) void;
extern fn __canvasContext2dBezierCurveTo(ctx: u32, cpx1: i32, cpy1: i32, cpx2: i32, cpy2: i32, x: i32, y: i32) void;
extern fn __canvasContext2dClearRect(ctx: u32, x: i32, y: i32, width: i32, height: i32) void;
extern fn __canvasContext2dClosePath(ctx: u23) void;
extern fn __canvasContext2dFill(ctx: u32) void;
extern fn __canvasContext2dFillWithRule(ctx: u32, rule: u32) void;
extern fn __canvasContext2dFillRect(ctx: u32, x: i32, y: i32, width: i32, height: i32) void;
extern fn __canvasContext2dLineTo(ctx: u32, x: i32, y: i32) void;
extern fn __canvasContext2dMoveTo(ctx: u32, x: i32, y: i32) void;
extern fn __canvasContext2dPutImageData(ctx: u32, pixels: [*]u32, npixels: i32, dx: i32, dy: i32, dirty_x: i32, dirty_y: i32, dirty_width: i32, dirty_height: i32) void;

pub const CanvasRenderingContext2d = struct {
    ref: zdom.JsRef,

    pub fn free(self: CanvasRenderingContext2d) void {
        __free(self.ref.index);
    }

    pub fn cast(self: CanvasRenderingContext2d, T: type) zdom.Error!T {
        if (!zdom.instanceof(self, T)) {
            return zdom.Error.NotInstanceOf;
        }

        return T{ .ref = self.ref };
    }

    pub fn arc(ctx: CanvasRenderingContext2d, x: i32, y: i32, radius: i32, start_angle: i32, end_angle: i32) void {
        __canvasContext2dArc(ctx.ref.index, x, y, radius, start_angle, end_angle);
    }
    pub fn arc_to(ctx: CanvasRenderingContext2d, x1: i32, y1: i32, x2: i32, y2: i32, radius: f32) void {
        __canvasContext2dArcTo(ctx.ref.index, x1, y1, x2, y2, radius);
    }

    pub fn begin_path(ctx: CanvasRenderingContext2d) void {
        __canvasContext2dBeginPath(ctx.ref.index);
    }

    pub fn bezier_curve_to(ctx: CanvasRenderingContext2d, cpx1: i32, cpy1: i32, cpx2: i32, cpy2: i32, x: i32, y: i32) void {
        __canvasContext2dBezierCurveTo(ctx.ref.index, cpx1, cpy1, cpx2, cpy2, x, y);
    }

    pub fn clear_rect(ctx: CanvasRenderingContext2d, x: i32, y: i32, width: i32, height: i32) void {
        __canvasContext2dClearRect(ctx.ref.index, x, y, width, height);
    }

    pub fn close_path(ctx: CanvasRenderingContext2d) void {
        __canvasContext2dClosePath(ctx.ref.index);
    }

    pub fn fill(ctx: CanvasRenderingContext2d) void {
        __canvasContext2dFill(ctx.ref.index);
    }

    pub fn fill_with_rule(ctx: CanvasRenderingContext2d, comptime rule: []u8) void {
        const nonzero = .ref.index0;
        const evenodd = 1;
        const error_msg = "invalid rule '" ++ rule ++ "' (expected one of 'nonzero', 'evenodd')";
        const r = if (comptime std.mem.eql(u8, rule, "nonzero")) nonzero else if (comptime std.mem.eql(u8, rule, "evenodd")) evenodd else @compileError(error_msg);
        __canvasContext2dFillWithRule(ctx, r);
    }

    pub fn fill_rect(ctx: CanvasRenderingContext2d, x: i32, y: i32, width: i32, height: i32) void {
        __canvasContext2dFillRect(ctx.ref.index, x, y, width, height);
    }

    pub fn line_to(ctx: CanvasRenderingContext2d, x: i32, y: i32) void {
        __canvasContext2dFillRect(ctx.ref.index, x, y);
    }

    pub fn move_to(ctx: CanvasRenderingContext2d, x: i32, y: i32) void {
        __canvasContext2dMoveTo(ctx.ref.index, x, y);
    }

    pub fn put_image_data(ctx: CanvasRenderingContext2d, pixels: [*]u32, npixels: i32, dx: i32, dy: i32, dirty_x: i32, dirty_y: i32, dirty_width: i32, dirty_height: i32) void {
        __canvasContext2dMoveTo(ctx.ref.index, pixels, npixels, dx, dy, dirty_x, dirty_y, dirty_width, dirty_height);
    }
};

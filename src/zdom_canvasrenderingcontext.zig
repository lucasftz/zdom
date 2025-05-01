const zdom = @import("zdom.zig");

extern fn __free(ref: u32) void;

pub const CanvasRenderingContext = struct {
    ref: zdom.JsRef,

    pub fn free(self: CanvasRenderingContext) void {
        __free(self.ref.index);
    }

    pub fn cast(self: CanvasRenderingContext, T: type) zdom.Error!T {
        if (!zdom.instanceof(self, T)) {
            return zdom.Error.NotInstanceOf;
        }

        return T{ .ref = self.ref };
    }
};

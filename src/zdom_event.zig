const zdom = @import("zdom.zig");

extern fn __free(ref: u32) void;

pub const Event = packed struct {
    ref: zdom.JsRef,

    pub fn free(self: Event) void {
        __free(self.ref.index);
    }

    pub fn cast(self: zdom.HtmlElement, T: type) zdom.Error!T {
        if (!zdom.instanceof(self, T)) {
            return zdom.Error.NotInstanceOf;
        }

        return T{ .ref = self.ref };
    }
};

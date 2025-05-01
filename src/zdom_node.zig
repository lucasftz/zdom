const zdom = @import("zdom.zig");

pub const Node = packed struct {
    ref: zdom.JsRef,
};

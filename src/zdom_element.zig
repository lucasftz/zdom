const zdom = @import("zdom.zig");
const std = @import("std");

extern fn __free(ref: u32) void;
extern fn __element_append_node(element_ref: u32, node_ref: u32) void;

pub const HtmlElement = packed struct {
    ref: zdom.JsRef,

    pub fn free(self: HtmlElement) void {
        __free(self.ref.index);
    }

    pub fn cast(self: HtmlElement, T: type) zdom.Error!T {
        if (!zdom.instanceof(self, T)) {
            return zdom.Error.NotInstanceOf;
        }

        return T{ .ref = self.ref };
    }

    pub fn as_node(self: HtmlElement) zdom.Node {
        return zdom.Node{ .ref = self.ref };
    }

    pub fn append(self: HtmlElement, node: anytype) void {
        const T = @TypeOf(node);
        if (!@hasDecl(T, "as_node")) {
            @compileError("Type " ++ @typeName(T) ++ " does not implement node");
        }
        __element_append_node(self.ref.index, node.as_node().ref.index);
    }
};

pub const HtmlBodyElement = packed struct {
    ref: zdom.JsRef,

    pub fn free(self: HtmlBodyElement) void {
        __free(self.ref.index);
    }

    pub fn cast(self: HtmlBodyElement, T: type) zdom.Error!T {
        if (!zdom.instanceof(self, T)) {
            return zdom.Error.NotInstanceOf;
        }

        return T{ .ref = self.ref };
    }

    pub fn as_node(self: HtmlBodyElement) zdom.Node {
        return zdom.Node{ .ref = self.ref };
    }

    pub fn as_element(self: HtmlBodyElement) HtmlElement {
        return HtmlElement{ .ref = self.ref };
    }
};

pub const HtmlCanvasElement = packed struct {
    ref: zdom.JsRef,

    pub fn free(self: HtmlCanvasElement) void {
        __free(self.ref.index);
    }

    pub fn cast(self: HtmlCanvasElement, T: type) zdom.Error!T {
        if (!zdom.instanceof(self, T)) {
            return zdom.Error.NotInstanceOf;
        }

        return T{ .ref = self.ref };
    }

    pub fn as_node(self: HtmlCanvasElement) zdom.Node {
        return zdom.Node{ .ref = self.ref };
    }

    pub fn as_element(self: HtmlCanvasElement) HtmlElement {
        return HtmlElement{ .ref = self.ref };
    }

    pub fn set_fillstyle() void {
        //
    }

    pub fn get_context(self: HtmlCanvasElement, comptime context_type: []const u8) ?zdom.CanvasRenderingContext {
        const valid_contexts = .{ "2d", "webgl", "experimental-webgl", "webgl2", "webgpu", "bitmaprenderer" };
        const error_msg = "invalid context type '" ++ context_type ++ "' (expected one of '2d', 'webgl', 'experimental-webgl', 'webgl2', 'webgpu', 'bitmaprenderer')";

        comptime var is_valid_context = false;
        inline for (valid_contexts) |valid_context| {
            if (comptime std.mem.eql(u8, valid_context, context_type)) {
                is_valid_context = true;
                break;
            }
        }

        if (!is_valid_context) {
            @compileError(error_msg);
        }

        _ = self;
        return null;
    }
};

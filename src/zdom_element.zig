const zdom = @import("zdom.zig");
const std = @import("std");

extern fn __free(ref: u32) void;
extern fn __elementAppendNode(element_ref: u32, node_ref: u32) void;
extern fn __canvasGetContext2d(element_ref: u32) u32;

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
        __elementAppendNode(self.ref.index, node.as_node().ref.index);
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

    pub fn set_fillstyle() void {}

    pub fn get_context_2d(self: HtmlCanvasElement) ?zdom.CanvasRenderingContext2d {
        const index = __canvasGetContext2d(self.ref.index);
        return if (index == 0) null else zdom.CanvasRenderingContext2d{ .ref = zdom.JsRef{ .index = index } };
    }
};

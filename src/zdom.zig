extern fn __instanceof(ref: u32, constructor: [*]const u8, constructor_len: usize) u32;

const std = @import("std");

pub const window = Window{ .ref = JsRef{ .index = JsRef.WINDOW } };
pub const document = Document{ .ref = JsRef{ .index = JsRef.DOCUMENT } };
pub const console = Console{ .ref = JsRef{ .index = JsRef.CONSOLE } };

pub const Error = error{NotInstanceOf};

pub const CanvasRenderingContext = @import("zdom_canvasrenderingcontext.zig").CanvasRenderingContext;
pub const CanvasRenderingContext2d = @import("zdom_canvasrenderingcontext2d.zig").CanvasRenderingContext2d;
pub const Console = @import("zdom_console.zig").Console;
pub const Document = @import("zdom_document.zig").Document;
pub const Event = @import("zdom_event.zig").Event;
pub const HtmlElement = @import("zdom_element.zig").HtmlElement;
pub const HtmlBodyElement = @import("zdom_element.zig").HtmlBodyElement;
pub const HtmlCanvasElement = @import("zdom_element.zig").HtmlCanvasElement;
pub const JsRef = @import("zdom_jsref.zig").JsRef;
pub const Node = @import("zdom_node.zig").Node;
pub const Window = @import("zdom_window.zig").Window;

pub fn instanceof(object: anytype, T: type) bool {
    const i = comptime std.mem.lastIndexOf(u8, @typeName(T), ".") orelse 0;
    const baseTypeName = comptime @typeName(T)[(if (i == 0) i else i + 1)..]; // bar.foo.typeName -> typeName

    var constructor: [baseTypeName.len]u8 = undefined;
    _ = std.mem.replace(u8, baseTypeName, "Html", "HTML", &constructor);
    _ = std.mem.replace(u8, &constructor, "2d", "2D", &constructor);

    if (0 == __instanceof(object.ref.index, &constructor, constructor.len)) {
        return false;
    }

    return true;
}

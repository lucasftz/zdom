const zdom = @import("zdom.zig");

extern fn __getRef(ref: u32, property: [*]const u8, property_len: u32) u32;

extern fn __documentCreateElement(document_ref: u32, tag_ptr: [*]const u8, tag_len: u32) u32;

pub const Document = packed struct {
    ref: zdom.JsRef,

    pub fn body(self: Document) ?zdom.HtmlBodyElement {
        const property = "body";
        const index = __getRef(self.ref.index, property, property.len);
        return if (index == 0) null else zdom.HtmlBodyElement{ .ref = zdom.JsRef{ .index = index } };
    }

    pub fn createElement(self: Document, tag: []const u8) ?zdom.HtmlElement {
        const index = __documentCreateElement(self.ref.index, tag.ptr, tag.len);
        return if (index == 0) null else zdom.HtmlElement{ .ref = zdom.JsRef{ .index = index } };
    }
};

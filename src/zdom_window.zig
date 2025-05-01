const zdom = @import("zdom.zig");

extern fn __add_event_listener(event_target_ref: u32, event_name_ptr: [*]const u8, event_name_len: usize, event_listener: u32) void;

pub const Window = packed struct {
    ref: zdom.JsRef,

    pub fn add_event_listener(self: Window, event_name: []const u8, event_listener: *const fn (event: zdom.Event) void) void {
        __add_event_listener(self.ref.index, event_name.ptr, event_name.len, @intFromPtr(event_listener));
    }
};

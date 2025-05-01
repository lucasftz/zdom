const zdom = @import("zdom.zig");

extern fn __console_log(fmt: [*]const u8, fmt_len: usize, vargs_ptr: [*]u32) void;

fn toJsRef(zdomStruct: anytype) zdom.JsRef {
    const T = @TypeOf(zdomStruct);

    if (.@"struct" != @typeInfo(T)) {
        @compileError("expected tuple or struct argument, found " ++ @typeName(T));
    }

    // if (!std.mem.startsWith(u8, @typeName(T), "zdom.")) {
    //     @compileError("expected a zdom struct argument, found " ++ @typeName(T));
    // }

    return zdom.JsRef{ .index = zdomStruct.ref.index };
}

pub const Console = packed struct {
    const MAX_ARGS = 32;

    ref: zdom.JsRef,

    pub fn log(self: Console, comptime fmt: []const u8, args: anytype) void {
        _ = self;

        const Args = @TypeOf(args);
        if (.@"struct" != @typeInfo(Args)) {
            @compileError("expected tuple or struct argument, found " ++ @typeName(Args));
        }

        comptime var fmt_specifier_count = 0;
        comptime var fmt_index = 0;
        inline while (fmt_index < fmt.len) : (fmt_index += 1) {
            // TODO: handle \%
            if (fmt[fmt_index] == '%') {
                fmt_specifier_count += 1;
            }
        }

        const fields = @typeInfo(Args).@"struct".fields;
        comptime var arg_index = 0;
        var args_buffer: [fmt_specifier_count]u32 = undefined;

        inline while (arg_index < args.len) {
            const field = fields[arg_index];

            const value: u32 = switch (field.type) {
                comptime_int => args[arg_index],
                // NOTE: this makes it so floats are converted to ints...
                // obviously we want to be able to print floats, but
                // that'll be a problem for future Lucas
                comptime_float => @intCast(args[arg_index]),
                usize => args[arg_index],
                u32 => args[arg_index],
                else => toJsRef(args[arg_index]).index,
            };

            args_buffer[arg_index] = value;

            arg_index += 1;
        }

        __console_log(fmt.ptr, fmt.len, &args_buffer);
    }
};

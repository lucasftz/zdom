const zdom = @import("zdom.zig");

fn main() !void {
    const body = zdom.document.body().?;
    const canvas = try zdom.document.create_element("canvas").?.cast(zdom.HtmlCanvasElement);
    body.as_element().append(canvas);
    body.append(canvas);

    body.free();
    canvas.free();

    const ctx = try canvas.get_context("2d").?.cast(zdom.CanvasRenderingContext2d);
    ctx.fill_rect(0, 0, 10, 10);
}

export fn start() i32 {
    main() catch |err| switch (err) {
        zdom.Error.NotInstanceOf => return 1,
    };

    return 0;
}

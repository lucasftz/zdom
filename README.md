# zdom

`zdom` is a WebAssembly (WASM) binding for Zig, providing an idiomatic and efficient way to interact with the DOM directly from Zig code compiled to WebAssembly.

## Features

- Interact with the DOM using Zig
- Create and manipulate HTML elements
- Interface with the Canvas API
- Safe casting of elements

## Example Usage

```zig
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
```

## API Overview

### `document`
Provides access to the global DOM document.
- `document.body()` - Returns the `<body>` element.
- `document.create_element(tag_name: []const u8)` - Creates a new HTML element.

### `Element`
Represents a generic DOM element.
- `.append(child: Element)` - Appends a child element.
- `.as_element()` - Casts to a general element.
- `.free()` - Releases resources for the element.

### `HtmlCanvasElement`
Represents an HTML `<canvas>` element.
- `.get_context(context_type: []const u8)` - Retrieves a rendering context.

### `CanvasRenderingContext2d`
Provides methods to manipulate the canvas.
- `.fill_rect(x: f32, y: f32, width: f32, height: f32)` - Draws a filled rectangle.

## Error Handling

Errors are returned using Zig's error system. Example:
```zig
main() catch |err| switch (err) {
    zdom.Error.NotInstanceOf => return 1,
};
```

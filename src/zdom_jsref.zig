pub const JsRef = packed struct {
    pub const NULL: u32 = 0;
    pub const WINDOW: u32 = 1;
    pub const DOCUMENT: u32 = 2;
    pub const CONSOLE: u32 = 3;

    index: u32,
};

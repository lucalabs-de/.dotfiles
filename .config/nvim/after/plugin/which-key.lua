vim.o.timeout = true
vim.o.timeoutlen = 300

require'which-key'.setup {
  icons = {
    separator = "   ",
    rules = false,
    colors = false,
  },
  keys = {
    Up = "UP",
    Down = "DOWN",
    Left = "LEFT",
    Right = "RIGHT",
    C = "C",
    M = "M",
    S = "S",
    CR = "CR",
    Esc = "ESC",
    ScrollWheelDown = "SWD",
    ScrollWheelUp = "SWU",
    NL = "NL",
    BS = "BACKSPACE",
    Space = "SPC",
    Tab = "TAB",
    F1 = "F1",
    F2 = "F2",
    F3 = "F3",
    F4 = "F4",
    F5 = "F5",
    F6 = "F6",
    F7 = "F7",
    F8 = "F8",
    F9 = "F9",
    F10 = "F10",
    F11 = "F11",
    F12 = "F12",
  },
}

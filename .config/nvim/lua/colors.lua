require'everforest'.setup {
  on_highlights = function (hl, palette)
  hl.NormalFloat = { fg = palette.none, bg = palette.none, sp = palette.none }
  hl.FloatBorder = { fg = palette.none, bg = palette.none, sp = palette.none }
  hl.DiagnosticFloatingError = { fg = palette.red, bg = palette.none, sp = palette.none }
  hl.DiagnosticFloatingWarn = { fg = palette.yellow, bg = palette.none, sp = palette.none }
  end
}
require'everforest'.load()

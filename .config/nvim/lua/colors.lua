require('kanagawa').setup({
    undercurl = true,
    keywordStyle = { italic = false },
    theme = "lotus",
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none"
          }
        }
      }
    }
})

vim.cmd("colorscheme kanagawa")

-- require("solarized").setup({
--  -- variant = "light"
-- })
--
-- vim.cmd("colorscheme solarized")

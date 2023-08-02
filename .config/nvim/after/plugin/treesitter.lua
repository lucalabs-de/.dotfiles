require'nvim-treesitter.configs'.setup {
	ensure_installed = { 
		"c",
		"lua",
		"typescript",
		"javascript",
		"rust",
		"haskell",
		"kotlin"
	},

	sync_install = false,
	auto_install = true,

	highlight = {
		enable = true,
	},
}

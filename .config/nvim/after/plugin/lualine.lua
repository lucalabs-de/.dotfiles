require'lualine'.setup {
	options = {
		theme = "everforest",
		section_separators = '',
		component_separators = {
			left = '|',
			right = '|'
		}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff' },
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'filetype'},
		lualine_y = {},
		lualine_z = {'location'}
	}
}

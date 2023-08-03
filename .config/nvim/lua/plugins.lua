vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'neanias/everforest-nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use { 'NeogitOrg/neogit', requires = 'nvim-lua/plenary.nvim' }
	use 'windwp/nvim-autopairs'
	use 'folke/which-key.nvim'
	use 'nvim-lualine/lualine.nvim'
	use 'goolord/alpha-nvim'
end)

-- TODO
-- yanky (emacs-like killring)
-- LSP and autocomplete
-- LaTeX support

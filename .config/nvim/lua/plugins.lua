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
	use 'nvim-lualine/lualine.nvim'
	use 'goolord/alpha-nvim'

  -- Productivity
  use 'gbprod/yanky.nvim'
  use 'jeffkreeftmeijer/vim-numbertoggle'
  use 'folke/which-key.nvim'
  use 'windwp/nvim-autopairs'

  -- LaTeX
  use 'lervag/vimtex'
  use 'L3MON4D3/LuaSnip'

  -- LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip"
  }
end)

-- TODO
-- snippet setup
-- harpoon

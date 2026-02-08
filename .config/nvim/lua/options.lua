local options = {
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 1,
	conceallevel = 0,
	fileencoding = "utf-8",
	hlsearch = false,
	showmode = false,
	smartcase = true,
	ignorecase = true,
	swapfile = false,
	undofile = true,
	writebackup = false,
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	number = true,
	scrolloff = 8,
  signcolumn = "yes",
  relativenumber = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- This sets up line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.smartindent = true

-- Enable theme. This is the lightest dark mode
vim.cmd.colorscheme 'catppuccin-frappe'

vim.g.mapleader = " "

require("luasnip.loaders.from_vscode").lazy_load()

require("which-key").setup {}

-- Enable system clipboard
vim.cmd('set clipboard+=unnamedplus')

-- Pro tip: @ exists for running macros like
	-- @d - insert current date


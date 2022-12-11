-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

	-- Theme
	use 'catppuccin/nvim'

	-- Dependancies that are needed by stuff
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

	-- Snippet manager
	use({"L3MON4D3/LuaSnip", tag = "v1.*"})

	-- Because I am bad at remembering commands
	use "folke/which-key.nvim"

	-- LSP stuff
	use "williamboman/mason.nvim" 
	use "williamboman/mason-lspconfig.nvim"
	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
	use 'jose-elias-alvarez/null-ls.nvim' -- Null ls is used for code formatting and pylint analysis
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp' -- Autocompletion with LSPs
	use 'jay-babu/mason-null-ls.nvim'

	-- File tree :)
	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function ()
			require("neo-tree").setup({})

      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
		end
	}
end)

local luasnip = require('luasnip')

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗"
		}
	}
})

require("mason-lspconfig").setup({
	-- List of servers to automatically install
	ensure_installed = { 'pyright', 'tsserver', 'eslint', 'bashls', 'cssls', 'html', 'sumneko_lua', 'jsonls', 'clangd', 'lemminx', 'rust_analyzer', 'tailwindcss' },
	-- automatically detect which servers to install (based on which servers are set up via lspconfig)
	automatic_installation = true,
})

local lspconfig = require 'lspconfig'

require("mason-null-ls").setup({
	ensure_installed = { 'codespell' }
})

-- Common LSP On Attach function
local get_on_attach = function (server_name)
	local on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false

		local opts = { buffer = bufnr }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wl', function()
			vim.inspect(vim.lsp.buf.list_workspace_folders())
		end, opts)
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
	end

	return on_attach
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- LSPs with default setup: bashls (Bash), cssls (CSS), html (HTML), clangd (C/C++), jsonls (JSON)
for _, lsp in ipairs { 'bashls', 'cssls', 'html', 'clangd', 'jsonls', 'sumneko_lua', 'rust_analyzer', 'tailwindcss', 'tsserver' } do
	lspconfig[lsp].setup {
		on_attach = get_on_attach(lsp),
		capabilities = capabilities,
	}
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}

-- Null ls for automatic formatting and additional analysis
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
	sources = {
		null_ls.builtins.formatting.prettier.with({
			extra_filetypes = { "xml" }
		}),
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.pylint.with({
			extra_args = { "--load-plugins=pylint_odoo", "-e", "odoolint" } -- Load pylint_odoo plugin for pylint
		}),
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.diagnostics.codespell,
	},
})
-- Manually format buffer
vim.keymap.set('n', '<leader>bf', vim.lsp.buf.format, {})

-- GDScript config because pain
require 'lspconfig'.gdscript.setup {
	flags = {
		debounce_text_changes = 150, -- Reduces a lot of the editor lag
	},
	on_attach = function (client)
    local _notify = client.notify
    client.notify = function (method, params)
      if method == 'textDocument/didClose' then
          -- Godot doesn't implement didClose yet
          return
      end
      _notify(method, params)
    end
  end
}

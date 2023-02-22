local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")


local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
	vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup_format,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({ bufnr = bufnr })
		end,
	})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	--local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	--buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	--buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	--buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

protocol.CompletionItemKind = {
	'', -- Text
	'', -- Method
	'', -- Function
	'', -- Constructor
	'', -- Field
	'', -- Variable
	'', -- Class
	'ﰮ', -- Interface
	'', -- Module
	'', -- Property
	'', -- Unit
	'', -- Value
	'', -- Enum
	'', -- Keyword
	'﬌', -- Snippet
	'', -- Color
	'', -- File
	'', -- Reference
	'', -- Folder
	'', -- EnumMember
	'', -- Constant
	'', -- Struct
	'', -- Event
	'ﬦ', -- Operator
	'', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(
	vim.lsp.protocol.make_client_capabilities()
)

-- Typescript
nvim_lsp.tsserver.setup {
	on_attach = on_attach,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server.cmd", "--stdio" },
	capabilities = capabilities
}

-- Rust
nvim_lsp.rust_analyzer.setup {
	filetypes = { "rust" },
	cmd = { "rust-analyzer" },
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
}

-- Svelte
nvim_lsp.svelte.setup {
	on_attach = on_attach,
	cmd = { "svelteserver.cmd", "--stdio" },
	filetypes = { "svelte" }
}

--Python
nvim_lsp.jedi_language_server.setup{
    filetypes = { "python" },
    cmd = { "jedi-language-server" },
    on_attach = function(client, bufnr)
	    on_attach(client, bufnr)
	    enable_format_on_save(client, bufnr)
    end,
}
--toml
nvim_lsp.taplo.setup {
	on_attach = on_attach,
	cmd = { "taplo", "lsp", "stdio" },
	filetypes = { "toml" },
	root_dir = nvim_lsp.util.root_pattern("*.toml", ".git"),
}

--Bash
nvim_lsp.bashls.setup{
    on_attach = function(client, bufnr)
	    on_attach(client, bufnr)
	    enable_format_on_save(client, bufnr)
    end,
    cmd = { "bash-language-server", "start" },
    cmd_env = {
	GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"
    },
    filetypes = { "sh" }
}

-- Haskell
nvim_lsp.hls.setup {
    on_attach = function(client, bufnr)
	    on_attach(client, bufnr)
	    enable_format_on_save(client, bufnr)
	end,
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	filetypes = { "haskell", "lhaskell" }
}

--Elixir
nvim_lsp.elixirls.setup{
    on_attach = function(client, bufnr)
	    on_attach(client, bufnr)
	    enable_format_on_save(client, bufnr)
    end,
    cmd = { "D:/New folder/CA/elixir-ls-1.14-25.1/language_server.bat" },
    filetypes = { "elixir", "eelixir", "heex", "surface" },
    root_dir = nvim_lsp.util.root_pattern("mix.exs", ".git")
}

-- Go
nvim_lsp.gopls.setup {
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = nvim_lsp.util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}


nvim_lsp.lua_ls.setup {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	root_dir = nvim_lsp.util.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml",
		"selene.toml", "selene.yml", ".git"),
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},

			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false
			},
		},
	},
}

nvim_lsp.cssls.setup {
	on_attach = on_attach,
	capabilities = capabilities
}


nvim_lsp.ccls.setup {
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	cmd = { "ccls" },
	filetypes = { "c", "cpp", "objc", "objcpp" }
}

--Hanlders
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "●" },
	severity_sort = true,
}
)

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = '●'
	},
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
})

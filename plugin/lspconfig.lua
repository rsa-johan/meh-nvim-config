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

mason.setup()

mason_lsp.setup {
	ensure_installed = {}
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(
	vim.lsp.protocol.make_client_capabilities()
)

--[[
--Powershell
nvim_lsp.powershell_es.setup {
	on_attach = on_attach,
	bundle_path = 'c:/w/PowerShellEditorServices',
	filetypes = { 'ps1' },
}

--Deno
nvim_lsp.denols.setup {
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	cmd = { "deno", "lsp" },
	cmd_env = {
		NO_COLOR = true
	},
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", ".git")

}

--Emmet
nvim_lsp.emmet_ls.setup {
	on_attach = on_attach,
	cmd = { "emmet-ls", "--stdio" },
	filetypes = { "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss",
		"svelte", "typescriptreact", "vue" }
}

--TailwindCSS
nvim_lsp.tailwindcss.setup {
	on_attach = on_attach,
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge",
		"eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "heex",
		"jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig",
		"css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason",
		"rescript", "typescript", "typescriptreact", "vue", "svelte" },
	root_dir = nvim_lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js',
		'postcss.config.ts', 'package.json', 'node_modules', '.git'),
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "classList", "ngClass" },
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning"
			},
			validate = true
		}
	}
}

-- Typescript
nvim_lsp.tsserver.setup {
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server.cmd", "--stdio" },
	capabilities = capabilities
}

-- Svelte
nvim_lsp.svelte.setup {
	on_attach = on_attach,
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" }
}
--Bash
nvim_lsp.bashls.setup {
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

--Elixir
nvim_lsp.elixirls.setup {
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
--]]

-- Rust
nvim_lsp.rust_analyzer.setup {
	filetypes = { "rust" },
	cmd = { "rust-analyzer" },
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_sav(client, bufnr)
	end,
}

--Python
nvim_lsp.pyright.setup {
	filetypes = { "python" },
	cmd = { "pyright-langserver", "--stdio" },
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

--Markdown
nvim_lsp.marksman.setup {
	on_attach = on_attach,
	cmd = { "marksman", "server" },
	filetypes = { "markdown" }
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
		source = true, -- Or "if_many"
		scope = "line"
	},
})

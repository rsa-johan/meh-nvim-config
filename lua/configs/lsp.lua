local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

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

local capabilities = require('cmp_nvim_lsp').default_capabilities()

--JS/TS/JSX/TSX
nvim_lsp.denols.setup {
	capabilities = capabilities,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "deno", "lsp" },
	cmd_env = { NO_COLOR = true },
	on_attach = function(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	settings = {
		deno = {
			enable = true,
			suggest = {
				imports = {
					hosts = {
						["https://deno.land"] = true
					}
				}
			}
		}
	}
}

--Zig
nvim_lsp.zls.setup {
	capabilities = capabilities,
	filetypes = { "zig", "zir" },
	cmd = { "zls" },
	on_attach = function(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
}

--C/C++
nvim_lsp.clangd.setup {
	capabilities = capabilities,
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	on_attach = function(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
}

--Python
nvim_lsp.pyright.setup {
	capabilities = capabilities,
	filetypes = { "python" },
	cmd = { "pyright-langserver", "--stdio" },
	on_attach = function(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
}

--Rust
nvim_lsp.rust_analyzer.setup {
	capabilities = capabilities,
	filetypes = { "rust" },
	cmd = { "rust-analyzer" },
	on_attach = function(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
}

--MarkDown
nvim_lsp.marksman.setup {
	capabilities = capabilities,
	filetypes = { "markdown", "markdown.mdx" },
	cmd = { "marksman", "server" },
	on_attach = function(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
}

--Lua LSP for Neovim
nvim_lsp.lua_ls.setup {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	log_level = 2,
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				version = 'LuaJIT'
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
				}
			}
		})
	end,
	settings = {
		Lua = {}
	}
}

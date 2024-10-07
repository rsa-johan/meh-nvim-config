local mason = require('mason')
local mason_lsp = require('mason-lspconfig')

local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

--[[local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
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
}]]--

--[[local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.pyright.setup {
    filetypes = { "python" },
	cmd = { "pyright-langserver", "--stdio" },
	on_attach = function(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
}]]--

--Lua LSP for Neovim
nvim_lsp.lua_ls.setup {
    --capabilities = capabilities
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      log_level = 2,
      on_init = function(client)
	if client.workspace_folders then
	  local path = client.workspace_folders[1].name
	  if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
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

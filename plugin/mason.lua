local status, mason = pcall(require, "mason")
local status, mason_lsp = pcall(require, "mason-lspconfig")

mason.setup()
mason_lsp.setup()

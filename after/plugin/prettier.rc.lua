local status, formatter = pcall(require, "formatter")

if not status then
	return
end

formatter.setup({
	logging = false,
	filetype = {
		javascript = {
			-- prettierd
			function()
				return {
					exe = "prettierd",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true
				}
			end
		},
		typescript = {
			-- prettierd
			function()
				return {
					exe = "prettierd",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true
				}
			end
		},
		typescriptreact = {
			-- prettierd
			function()
				return {
					exe = "prettierd",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true
				}
			end
		},
		-- other formatters ...
	}
})

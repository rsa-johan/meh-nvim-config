local cmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup

local hijackgroup = group("MyHijackGroup", {
	clear = true
})

cmd({ "VimEnter" }, {
	pattern = { "*" },
	callback = function(_ev)
		local s = vim.fn.expand('%:p')
		if vim.fn.isdirectory(s) == 1 then
			require('telescope.builtin').find_files({ cwd = s })
		end
	end,
	group = hijackgroup
})

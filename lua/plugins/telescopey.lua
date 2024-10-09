return {
	{
		"nvim-telescope/telescope-file-browser.nvim",
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
			"nvim-telescope/telescope-file-browser.nvim",
		},
		keys = {
			{ "ff", require('telescope.builtin').find_files, desc = "Telescope find files" },
			{ "fg", require('telescope.builtin').live_grep,  desc = "Telescope live grep" },
			{ "fb", require('telescope.builtin').buffers,    desc = "Telescope buffers" },
			{ "fh", require('telescope.builtin').help_tags,  desc = "Telescope help tags" },
			{
				";s",
				function()
					local builtin = require("telescope.builtin")
					builtin.treesitter()
				end,
				desc = "Lists Function names, variables, from Treesitter",
			},
		},
	},
}

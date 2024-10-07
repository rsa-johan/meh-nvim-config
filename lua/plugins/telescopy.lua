return {
    {
	"nvim-telescope/telescope-file-browser.nvim",
    },
    {
	'nvim-telescope/telescope.nvim',
	 tag = '0.1.8',
	dependencies = {
	    "nvim-lua/plenary.nvim",
	    {
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-file-browser.nvim",
	},
	 opts = {
	     defaults = {
		 mappings = {
		     n = {
			["q"] = require('telescope.actions').close,
			["<C-2>"] = require('telescope.builtin').git_status
		     },
		 }
	     },
	     extensions = {
		 file_browser = {
		     theme = "dropdown",
		     hijack_netrw = true,
		     --[[mappings = {
			 ["n"] = {
			    ["N"]=require('telescope').extensions.file_browser.actions.create,
			    ["D"]=require('telescope').extensions.file_browser.actions.delete,
			    ["r"]=require('telescope').extensions.file_browser.actions.rename,
			    ["C"]=require('telescope').extensions.file_browser.actions.copy,
			    ["M"]=require('telescope').extensions.file_browser.actions.move,
			    ["h"]=require('telescope').extensions.file_browser.actions.goto_parent_dir,
			 }
		     }]]--
		 }
	     }
	 },
	 keys = {
	     { "ff", require('telescope.builtin').find_files, desc="Telescope find files" },
	     { "fg", require('telescope.builtin').live_grep, desc="Telescope live grep" },
	     { "fb", require('telescope.builtin').buffers, desc="Telescope buffers" },
	     { "fh", require('telescope.builtin').help_tags, desc="Telescope help tags" },
	     { ";s", function()
			 local builtin = require("telescope.builtin")
			 builtin.treesitter()
		     end,
		     desc = "Lists Function names, variables, from Treesitter",
	    },
	 },
	config = function()
	    require('telescope').load_extension('file_browser')
	end
    },
}

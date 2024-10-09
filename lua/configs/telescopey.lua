local telescope = require("telescope")
local conf = require("telescope.config").values
local harpoon = require('harpoon')

-- Load necessary extensions
telescope.load_extension('file_browser')
--telescope.load_extension('fzf')

-- Telescope Setup
telescope.setup {
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
			mappings = {
				["n"] = {
					["N"] = telescope.extensions.file_browser.actions.create,
					--["D"] = telescope.extensions.file_browser.actions.delete,
					["r"] = telescope.extensions.file_browser.actions.rename,
					["C"] = telescope.extensions.file_browser.actions.copy,
					["M"] = telescope.extensions.file_browser.actions.move,
					["h"] = telescope.extensions.file_browser.actions.goto_parent_dir,
				}
			}
		},
		--fzf = {
		--	fuzzy = true,          -- false will only do exact matching
		--	override_generic_sorter = true, -- override the generic sorter
		--	override_file_sorter = true, -- override the file sorter
		--	case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		--	-- the default case_mode is "smart_case"
		--}
	}
}

local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers").new({}, {
		prompt_title = "Harpoon",
		finder = require("telescope.finders").new_table({
			results = file_paths,
		}),
		previewer = conf.file_previewer({}),
		sorter = conf.generic_sorter({}),
	}):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
	{ desc = "Open harpoon window" })

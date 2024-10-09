return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		opts = {},
		keys = {
			{ "<leader>a", function() require('harpoon'):list():add() end },
			{ "<C-h>",     function() require('harpoon'):list():select(1) end },
			{ "<C-t>",     function() require('harpoon'):list():select(2) end },
			{ "<C-n>",     function() require('harpoon'):list():select(3) end },
			{ "<C-s>",     function() require('harpoon'):list():select(4) end },
			{ "<C-S-P>",   function() require('harpoon'):list():prev() end },
			{ "<C-S-N>",   function() require('harpoon'):list():next() end }
		}
	}
}

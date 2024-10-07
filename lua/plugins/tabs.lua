return {
    'romgrk/barbar.nvim',
    dependencies = {
	'lewis6991/gitsigns.nvim',
	'nvim-tree/nvim-web-devicons'
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
	preset = 'powerline',
	animation = true,
	icons = {
	    gitsigns = {
		added = { enabled = true, icon = '+' },
		changed = { enabled = true, icon = '~' },
		deleted = { enabled = true, icon = '-' },
	    }
	}
    },
    --[[keys = {
	{ '<A-c>', '<Cmd>BufferClose<CR>', desc="Close buffer" },
	{ '<A-.>', '<Cmd>BufferNext<CR>' , desc="Move to Next buffer"},
	{ '<A-,>', '<Cmd>BufferPrevious<CR>' , desc="Move to Previous buffer"},
	{ '<A-1>', '<Cmd>BufferGoto 1<CR>' ,desc="Go to Buffer 1"},
	{ '<A-2>', '<Cmd>BufferGoto 2<CR>' ,desc="Go to Buffer 2"},
	{ '<A-3>', '<Cmd>BufferGoto 3<CR>' ,desc="Go to Buffer 3"},
	{ '<A-4>', '<Cmd>BufferGoto 4<CR>' ,desc="Go to Buffer 4"},
	{ '<A-5>', '<Cmd>BufferGoto 5<CR>' ,desc="Go to Buffer 5"},
	{ '<A-6>', '<Cmd>BufferGoto 6<CR>' ,desc="Go to Buffer 6"},
	{ '<Space>bn', '<Cmd>BufferOrderByName<CR>' ,desc="Order buffers by name"},
    }]]--
}

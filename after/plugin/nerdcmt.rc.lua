vim.api.nvim_command('filetype plugin on')

local status, nerd = pcall(require, 'nerdcommentor')
if (not status) then return end

nerd.setup {}

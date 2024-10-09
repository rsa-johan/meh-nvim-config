local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--scroll through file while cursor is centered
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)

--easy term close
map('t', '<Esc>', '<C-\\><C-n>:q', opts)
map('t', '<C-l>', '<C-\\><C-n>', opts)

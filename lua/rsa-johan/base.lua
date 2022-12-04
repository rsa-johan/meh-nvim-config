vim.cmd('autocmd!')

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.hlsearch = true
vim.opt.laststatus = 2
vim.opt.shell = 'C:\\Program Files\\PowerShell\\7\\pwsh.exe'
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.path:append { '**' }
vim.opt.wildignore:append { '*/node_modules/*', '*/target/*' }
vim.opt.ch = 0

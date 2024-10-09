--for lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--encoding
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

--line numbering relative
vim.wo.relativenumber = true

--scrolling off
vim.opt.mousescroll = 'ver:0,hor:0'

--term/vim shell
vim.opt.shell = 'cmd'

--tab settings
vim.opt.smarttab = true
vim.opt.shiftwidth = 4

--indent settings
vim.opt.breakindent = true
vim.opt.smartindent = true

vim.opt.wildignore:append { '*/node_modules/*', '*/target/*' }

--netrw-noload
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true

--deno codefencing
vim.g.markdown_fenced_languages = {
	"ts=typescript"
}

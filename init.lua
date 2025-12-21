--------------------------------------------------------------------------------
-- Brief:	setting for neovim
-- Create:	2024/09/20
-- Update:	2025/12/18
-- Author:	KORYUOH
-- github:	KORYUOH/nvimrc
--------------------------------------------------------------------------------
vim.scriptencoding = 'utf-8'
vim.env.BASE_DIR = vim.fn.expand("<sfile>:h:p")
require('basic')
require('usercommand')
require('keymap')
require('plugins')

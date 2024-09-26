--------------------------------------------------------------------------------
-- Brief:	setting auto command group for neovim
-- Create:	2024/09/25
-- Update:	2024/09/25
-- Author:	KORYUOH
-- github:	KORYUOH/nvimrc
--------------------------------------------------------------------------------

local batfilefenc = vim.api.nvim_create_augroup('BatFileFenc', {clear = true})
vim.api.nvim_create_autocmd(
	{"BufRead","WinEnter","VimEnter"},
	{ pattern = "*.bat",
	--command = "set fileencoding=cp932",
	  callback = function()
		  vim.api.nvim_buf_set_option(0, 'fileencoding' , 'cp932')
	  end,
	  group = batfilefenc,
	  desc = "batch file is file encoding is cp932(jp sjis)"
	}
)

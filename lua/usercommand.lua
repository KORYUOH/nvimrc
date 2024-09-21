--------------------------------------------------------------------------------
-- Brief:	setting user command for neovim
-- Create:	2024/09/21
-- Update:	2024/09/21
-- Author:	KORYUOH
-- github:	KORYUOH/nvimrc
--------------------------------------------------------------------------------

vim.api.nvim_create_user_command("OpenInit" , function(opts)
	vim.cmd( "tabnew " .. "~/AppData/Local/nvim/init.lua")
end,{})



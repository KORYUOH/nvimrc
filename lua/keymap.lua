--------------------------------------------------------------------------------
-- Brief:	keymap setting for neovim
-- Create:	2024/09/21
-- Update:	2024/09/21
-- Author:	KORYUOH
-- github:	KORYUOH/nvimrc
--------------------------------------------------------------------------------
local opt = {silent = true , noremap = false}
local term_opt = {silent = true}


local keymap = vim.api.nvim_set_keymap

-- <leader> is \
vim.g.mapleader = "\\"

--------------------------------------------------------------------------------
-- normal mode : "n"
-- insert mode : "i"
-- visual mode : "v"
-- visual block mode : "x"
-- term mode : "t"
-- command mode : "c"
--------------------------------------------------------------------------------

--------------------------- 
--- Normal Mode Keymapping
--------------------------- 

keymap("n" , ";" , ":" , opt)

-- Ctrl + [lh] move tab
keymap("n" , "<C-h>" , "gT" , opt)
keymap("n" , "<C-l>" , "gt" , opt)

-- tp is close tab
keymap("n" , "tq" , ":tabclose<CR>",opt)

--- Window Operation
keymap("n" , "<C-Right>" , "<C-w>>" , opt )
keymap("n" , "<C-Left>" , "<C-w><" , opt )
keymap("n" , "<C-Up>" , "<C-w>+" , opt )
keymap("n" , "<C-Down>" , "<C-w>-" , opt )

--- Jump Pair ()
keymap("n" , "<C-[>" , "%" , opt)

--- Esc DoubleTouch is NoHilights
keymap("n" , "<Esc><Esc>" , ":nohlsearch<CR>" , opt)




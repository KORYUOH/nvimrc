local map = vim.api.nvim_set_keymap
local noremap  = { noremap = true }

map( "i" , "<C-j>" , "<Plug>(skkeleton-toggle)", noremap )
map( "c" , "<C-j>" , "<Plug>(skkeleton-toggle)", noremap )
map( "t" , "<C-j>" , "<Plug>(skkeleton-toggle)", noremap )
map( "n" , "<C-j>" , "i<Plug>(skkeleton-toggle)", noremap )

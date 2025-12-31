
vim.fn["ddc#custom#load_config"](vim.fn.expand("$BASE_DIR/configs/ddc.ts"))

local map = vim.opt.nvim_set_keymap
local opt = {noremap = true}

map( "i" , "<S-TAB>" , "<Cmd>call pum#map#insert_relative( -1 , 'empty' )<CR>" , opt )
map( "i" , "<C-n>" , "<Cmd>call pum#map#select_relative( +1 )<CR>" , opt )
map( "i" , "<C-p>" , "<Cmd>call pum#map#select_relative( -1 )<CR>" , opt )
map( "i" , "<C-y>" , "<Cmd>call pum#map#confirm_suffix()<CR>" , opt )
map( "i" , "<C-o>" , "<Cmd>call pum#map#confirm_matched_pattern('^\S\+')<CR>" , opt )
map( "i" , "<Home>" , "<Cmd>call pum#map#insert_relative( -9999 , 'ignore' )<CR>" , opt )
map( "i" , "<End>" , "<Cmd>call pum#map#insert_relative( +9999 , 'ignore' )<CR>" , opt )
map( "i" , "<C-g>" , "<Cmd>call pum#map#toggle_preview()<CR>" , opt )
map( "i" , "<C-t>" , "<C-v><Tab>" , opt )

map("i" , "<C-g>" , "ddc#map#insert_item(0)" , {expr = true} )
map("c" , "<C-g>" , "ddc#map#insert_item(0)" , {expr = true} )

map("c" , "<Tab>" , function()
			if vim.fn["ddc#ui#inline#visible"]() == 1 then
				return vim.fn["ddc#map#insert_item"](0)
			end
			if vim.fn["pum#visible"]() == 1 then
				return "<Cmd>call pum#map#insert_relative( +1, 'empty' )<CR>"
			end
			local col = vim.fn.col(".")
			if col <= 1 then
				return "<Tab>"
			end

			local line = vim.fn.getline(".")
			local prev_char = line:sub(col - 1 , col - 1)
			if prev_char:match("%s") then
				return "<Tab>"
			end

			return vim.fn["ddc#map#manual_complete"]()

		end, {noremap = true , expr = true})

map( "c" , "<C-e>" , function()
			if vim.fn["ddc#ui#inline#visible"]() then
				return vim.fn["ddc#map#insert_item"](0)
			end
			if vim.fn["pum#visible"]() then
				return "<Cmd>call pum#map#cancel()<CR>"
			end

			return "<End>"
		end,{noremap = true , expr = true})

map( "x" , "<Tab>" , "_R<Cmd>call ddc#map#manual_complete()<CR>" , { noremap = true } )
map( "s" , "<Tab>" , '<C-o>"_di<Cmd>call ddc#map#manual_complete()<CR>' , { noremap = true })

vim.fn["ddc#enable_terminal_completion"]()
vim.fn["ddc#enable"]({"treesitter"})

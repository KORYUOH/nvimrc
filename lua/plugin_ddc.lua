vim.notify("loaded ddc.lua")

local keymap = vim.api.nvim_set_keymap
local opt = { }

keymap( "n" , ":" , "<Cmd>call CommandlinePre(':')<CR>:" , opt)
keymap( "n" , "?" , "<Cmd>call CommandlinePre('/')<CR>?" , opt)
keymap( "x" , ":" , "<Cmd>call CommandlinePre(':')<CR>:" , opt)
keymap( "n" , ";;" , "<Cmd>call cmdline#enable()<CR><Cmd>CommandlinePre(':')<CR>:" , opt)

vim.api.nvim_create_user_command("CommandlinePre" , function(mode) abort
			if vim.b.prev_buffer_config ~= nil then
				return 
			end
			
			-- 現在のバッファを保存
			vim.b.prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()

			if mode == ":" then
				-- sourceOption の上書き
				vim.fn["ddc#custom#patch_buffer"]("sourceOptions" , {
					_ = { 
						keywordPattern = "[0-9a-zA-Z_:#*/.-]*",
					},
					})

				-- bang の時だけcmdlineSouecesを切り替える

				vim.fn["ddc#custom#set_context_buffer"](function()
					return vim.fn.getcmdline():find("^!") and {
					cmdlineSources = {
							"cmdline",
							"around"
						},
					} or {}
					end)
			end

			vim.api.nvim_create_autocmd( "user" , {
					group = vim.api.nvim_create_augroup("MyAutoCmd" , {clear = false}),
					pattern = "DDCCmdlineLeave",
					once = true,
					callback = function()
						CommandlinePost()
					end
					}  )
		end
		)

function CommandlinePost()
	-- b:prev_buffer_config が有るなら元に戻す
	if vim.b.prev_buffer_config ~= nil then
		vim.fn["ddc#custom#set_buffer"](vim.b.prev_buffer_config)
		vim.b.prev_buffer_config = nil
	end
end


-- skkeleton-enable-pre
vim.api.nvim_create_autocmd( "User" , {
		group = vim.api.nvim_create_augroup( "MyAutoCmd" , { clear = false }),
		pattern = "skkeleton-enable-pre",
		callback = function()
			skkeleton_pre_ddc()
		end,
		})

function ekkelton_pre_ddc()
	-- b:prev_buffer_skkeleton_config が保存されてるなら終り
	if vim.b.prev_buffer_skkeleton_config ~= nil then
		return
	end

	-- 現在のバッファ設定を保存
	vim.b.prev_buffer_skkeleton_config = vim.fn["ddc#custom#get_buffer"]()

	-- ddc を 上書き
	vim.fn["ddc#custom#patch_buffer"]({
			cmdlineSources = {
				"skkeleton",
				"skkeleton_okuri",
			},
			sources = {
				"around",
				"skkeleton",
				"skkeleton_okuri",
				"line",
			},
			sourceOptions = {
				_ = {
					keywordPattern = "[ァ-ヮア-ンー]+",
				},
			},

			})
end


-- skkeleton-disbale-post
vim.api.nvim_create_autocmd( "User" , {
		group = vim.api.nvim_create_augroup( "MyAutoCmd" , {clear = false} ),
		pattern = "skkeleton-disable-post",
		callback = function()
			skkeleton_post_ddc()
		end
		})

function skkeleton_post_ddc()
	if vim.b.prev_buffer_skkeleton_config ~= nil then
		vim.fn["ddc#custom#set_buffer"](vim.b.prev_buffer_skkeleton_config)
		vim.b.prev_buffer_skkeleton_config = nil
	end
end

--- skkeleton_handle_dot
function skkeleton_handle_dot()
	if vim.fn["ddc#map#can_complete"]() == 1 then
		vim.fn.feedkeys( vim.fn, "nt" )
	else
		vim.fn["skkeleton#handle"]("handleKay" , { key = "." })
	end
end



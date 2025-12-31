
local skkeleton_config = {
			databasePath = vim.fn.expand('~/.neovim_cache/skkeleton.db'),
			eggLikeNewline= true,
			globalDictionaries = {vim.fn.expand('~/dict/SKK-JISYO.L')},
			markerHenkan = '',
			markerHenkanSelect = '',
			registerConvertResult = true,
			-- sources = {"deno_kv" , "google_japanese_input"},
			sources = {"google_japanese_input"},
}

vim.fn["skkeleton#config"](skkeleton_config)

vim.fn["skkeleton#register_keymap"]( 'input' , '<C-q>' , 'katakana')

local kanatable = {
		jj = {"escape"},
		l =  false,
		la = { "ぁ" },
		li = { "ぃ" },
		lu = { "ぅ" },
		le = { "ぇ" },
		lo = { "ぉ" },
		lya = { "ゃ" },
		lyu = { "ゅ" },
		lyo = { "ょ" },
		kwa = { "くぁ" },
		kwi = { "くぃ" },
		kwu = { "くぅ" },
		kwe = { "くぇ" },
		kwo = { "くぉ" },
		q = false,
		qa = { "くぁ" },
		qi = { "くぃ" },
		qu = { "くぅ" },
		qe = { "くぇ" },
		qo = { "くぉ" },
		["~"] = { "～" , "" },
}

vim.fn["skkeleton#register_kanatable"] ('rom', kanatable )

vim.api.nvim_create_autocmd( "User" , {
		group = vim.api.nvim_create_augroup( "MyAutoCmd" , {clear = false}),
		pattern = "skkeleton-enable-pre",
		callback = function()
			skkeleton_pre()
		end,
		})

function skkeleton_pre()
	if ( (vim.fn.has("nvim") == 0) or (vim.env.DISPLAY ~= "") ) and vim.fn.has("clipbpard") then
	vim.api.nvim_create_autocmd( "ModeChanged" , {
			pattern = "*:n",
			once = true,
			callback = function()
				local line = vim.fn.getline(".")
				vim.fn.setreg("*" , line)
				vim.fn.setreg("+" , line)
			end,
			} )
end

	local is_cmdline = vim.fn.exists("*cmdline#_get") == 1 and not vim.fn["cmdline#_get"]().pos:isempty()

	local hl_name = is_cmdline and "CmdlineCursor" or "Cursor"

	-- ハイライトの取得
	_G.hl_cursor = vim.api.nvim_get_hl(0 , { name = hl_name })
end

vim.api.nvim_create_autocmd( "User" , {
			pattern = "skkeleton-mode-changed",
			callback = function()
				skkeleton_changed()
			end,
		})

function skkeleton_changed()
	local hl_cursor

	-- s:hl_cursor を ディープコピー
	if type(_G.hl_cursor) == "table" then
		hl_cursor = vim.deepcopy(_G.hl_cursor)
	else
		hl_cursor = _G.hl_cursor
	end

	-- skkeletonのモードで色を変更
	local mode = vim.g["skkeleton#mode"]
	local color

	if mode == "hira" then
		color = "#80403f"
	elseif mode == "kata" then
		color = "#f06060"
	elseif mode == "hankata" then
		color = "#60a060"
	elseif mode == "zenkaku" then
		color = "#60c060"
	elseif mode == "addrev" then
		color = "#60f060"
	else
		color = "#606060"
	end

	-- Neovim
	hl_cursor.bg = color

	highlight_cursor(hl_cursor)
end

vim.api.nvim_create_autocmd( "User" , {
		pattern = "skkeleton^handled",
		callback = function() 
			skkeleton_handled()
		end,
		})

function skkeleton_handled()
	if vim.g["skkeleton#mode"] == "" then
		return
	end

	local hl_cursor

	local phase = vim.g["skkeleton#state"].phase
	if phase == "henkan"
	or phase == "input:okurinasi"
	or phase == "input:okuriari"
	then
		hl_cursor = vim.deepcopy( _G.hl_cursor )

		local color = "#a0f0a0"

		hl_cursor.bg = color
		highlight_cursor(hl_cursor)
	else
		skkeleton_changed()
	end
end

function highlight_cursor(highlight) 
	local is_cmdline = vim.fn.exists("*cmdline#_get") == 1
	and not vim.fn["cmdline#_get"]().pos:isempty()

	local highlight_name = is_cmdline and "CmdlineCursor" or "Cursor"

	vim.api.nvim_set_hl( 0 , highlight_name , highlight )
	vim.cmd("redraw")
end

local state_popup_config = {
	labels = {
		 input =  {
			hira = "あ",
			kata = "ア",
			hankata = "ｶﾀ",
			zenkaku =  "Ａ",
		 },
		 ["input:okurinasi"] = {
			 hira = "▽",
			 kata = "▽",
			 hankata = "▽",
			 addrev = "ab",
		 },
		 ["input:okuriari"] = {
			 hira = "▽",
			 kata = "▽",
			 hankata = "▽",
			 addrev = "ab",
		 },
		 henkan = {
			 hira = "▼",
			 kata = "▼",
			 hankata = "▼",
			 addrev = "ab",
		 },
	},
	opts = {
		relative = "cursor",
		col = 0,
		row = 1,
		anchor = "NW",
		style = "minimal",
	},
}

vim.fn["skkeleton_state_popup#config"](state_popup_config)

vim.fn["skkeleton_state_popup#enable"]()
vim.fn["skkeleton#initialize"]()



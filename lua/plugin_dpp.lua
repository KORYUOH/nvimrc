--------------------------------------------------------------------------------
-- Brief:	dpp setting for neovim
-- Create:	2025/12/17
-- Update:	2025/12/20
-- Author:	KORYUOH
-- github:	KORYUOH/nvimrc
--------------------------------------------------------------------------------


local cache_dir = vim.fn.expand("~/.neovim_cache")
if vim.fn.isdirectory(cache_dir) == 0 then
	vim.fn.mkdir(cache_dir)
end

local plugin_dir = cache_dir .. "/dpp/repos/github.com/"
local dpp_src = plugin_dir .. "Shougo/dpp.vim"
local denops_src =  plugin_dir .. "vim-denops/denops.vim"
local dpp_config = vim.fs.normalize("$BASE_DIR/configs/dpp.ts")

------------------------------------------------------------------------------------------------------------------------
-- ツール
------------------------------------------------------------------------------------------------------------------------

-- ファイルが無いならcloneしてくる
local CheckPlugin = function( pluginName )
	local dir = plugin_dir .. pluginName
	if string.len(pluginName) == 0 then
		vim.notify("Empty Plugin")
		return
	end

	if vim.fn.isdirectory(dir) == 0 then
		vim.notify("Install : " .. pluginName)
		vim.fn.system({
			"git",
			"clone",
			"https://github.com/" .. pluginName,
			dir
		})
	end
end

--- プラグインの設定をロード
-- pluginName : プラグイン名
-- append : 後ろに追加するか
local InitPlugin = function ( pluginName  , append )
	local pluginpath = vim.fn.fnamemodify(plugin_dir .. pluginName , ":p"):gsub("[/\\]$" , "")
	if not vim.fn.isdirectory(pluginpath) then
		vim.notify("plugin : " .. pluginName .. " is not found")
		return
	end
	if not append then
		vim.opt.runtimepath:prepend(pluginpath)
	else
		vim.opt.runtimepath:append(pluginpath)
	end
end

-- ロードパスを後ろに追加
local InitPluginAppend = function ( pluginName )
	vim.notify("Append plugin: " .. pluginName)
	InitPlugin( pluginName , true )
end

-- ロードパスを前に追加
local InitPluginPre = function ( pluginName )
	vim.notify("Prepend plugin: " .. pluginName)
	InitPlugin( pluginName , false )
end


------------------------------------------------------------------------------------------------------------------------
-- denopsの初期化および読み込み
------------------------------------------------------------------------------------------------------------------------
local Denops = "vim-denops/denops.vim"
CheckPlugin(Denops)
InitPlugin(Denops)

------------------------------------------------------------------------------------------------------------------------
-- dppの初期化
------------------------------------------------------------------------------------------------------------------------

CheckPlugin("Shougo/dpp.vim" )
InitPluginPre("Shougo/dpp.vim")

------------------------------------------------------------------------------------------------------------------------
-- dpp の luaモジュールをロード
------------------------------------------------------------------------------------------------------------------------

local dpp = require("dpp")

------------------------------------------------------------------------------------------------------------------------
-- 拡張プラグインのロード
------------------------------------------------------------------------------------------------------------------------
local plugins = {
	"Shougo/dpp-ext-toml",
	"Shougo/dpp-ext-lazy",
	"Shougo/dpp-ext-installer",
	"Shougo/dpp-protocol-git",
}

for _,plugin in ipairs( plugins ) do
	CheckPlugin(plugin)
	InitPlugin(plugin)
end

------------------------------------------------------------------------------------------------------------------------
-- dpp_stateの ロード
------------------------------------------------------------------------------------------------------------------------
local dpp_base = cache_dir .. "/dpp"

local loadstate = dpp.load_state(dpp_base)
vim.print(loadstate)
if  loadstate then
	vim.notify("dpp make state")
	dpp.make_state( dpp_base , dpp_config )
else
	 vim.notify("dpp loadstate is failed")
end




vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")

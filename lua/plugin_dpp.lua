--------------------------------------------------------------------------------
-- Brief:	dpp setting for neovim
-- Create:	2025/12/17
-- Update:	2025/12/20
-- Author:	KORYUOH
-- github:	KORYUOH/nvimrc
--------------------------------------------------------------------------------

local cache_dir = vim.fs.normalize("~/.neovim_cache")
local plugin_dir = cache_dir .. "/dpp/repos/github.com/"
local dpp_src = plugin_dir .. "Shougo/dpp.vim"

-- フォルダがなければインストール
if vim.fn.isdirectory(plugin_dir) == 0 then
	vim.notify("install dpp files...")
	local denopsWares = {
		"denops.vim"
	};
	local ShougoWares = {
		"dpp.vim",
		"dpp-ext-installer",
		"dpp-protocol-git",
		"dpp-ext-lazy",
		"dpp-ext-toml"
	};

	for _, denops_ware in ipairs (denopsWares ) do
		local pluginName = "vim-denops/" .. denops_ware
		vim.fn.system({
				"git" , 
				"clone" ,
				"https://github.com/".. pluginName,
				plugin_dir .. pluginName
				})
	end

	for _, shougoware in ipairs(ShougoWares) do
		local pluginName = "Shougo/"..shougoware
		vim.fn.system({
				"git",
				"clone",
				"https://github.com/" .. pluginName,
				plugin_dir .. pluginName
				})
	end

end

-- プラグイン内のモジュールを読み込むため、先にruntimepathに追加する
vim.opt.runtimepath:prepend(dpp_src)
local dpp = require("dpp")

--------------
local dpp_base = cache_dir .. "/dpp"
local dpp_config = vim.fs.normalize("~/appdata/local/nvim/configs/dpp.ts")
local denops_src = cache_dir .. "/dpp/repos/github.com/vim-denops/denops.vim"
--
local ext_toml = cache_dir .. "/dpp/repos/github.com/Shougo/dpp-ext-toml"
local ext_lazy = cache_dir .. "/dpp/repos/github.com/Shougo/dpp-ext-lazy"
local ext_installer = cache_dir .. "/dpp/repos/github.com/Shougo/dpp-ext-installer"
local ext_git = cache_dir .. "/dpp/repos/github.com/Shougo/dpp-protocol-git"


vim.opt.runtimepath:append(ext_toml) 
vim.opt.runtimepath:append(ext_lazy) 
vim.opt.runtimepath:append(ext_installer ) 
vim.opt.runtimepath:append(ext_git) 

if dpp.load_state(dpp_base) then
vim.opt.runtimepath:prepend(denops_src)
vim.api.nvim_create_autocmd("User",{
		pattern = "DenopsReady",
		callback = function()
			vim.notify("vim loadstate is failed")
			dpp.make_state(dpp_base , dpp_config)
		end
		})
end

vim.api.nvim_create_user_command("DppInstall" , function(opts)
	vim.cmd("call dpp#async_ext_action('installer' , 'install')")
end, {})
vim.api.nvim_create_user_command("DppUpdate" , function(opts)
	vim.cmd("call dpp#async_ext_action('installer' , 'update')")
end, {})
vim.api.nvim_create_user_command("DppCheckUpdate" , function(opts)
	vim.cmd("call dpp#async_ext_action('installer' , 'checkNotUpdated')")
end, {})
vim.api.nvim_create_user_command("DppCheckInstall" , function(opts)
	vim.cmd("call dpp#async_ext_action('installer' , 'getNotInstalled')")
end, {})




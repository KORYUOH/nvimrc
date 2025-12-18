--------------------------------------------------------------------------------
-- Brief:	dpp setting for neovim
-- Create:	2025/12/17
-- Update:	2025/12/17
-- Author:	KORYUOH
-- github:	KORYUOH/nvimrc
--------------------------------------------------------------------------------

local cache_dir = vim.fs.normalize("~/.neovim_cache")
local dpp_src = cache_dir .. "/dpp/repos/github.com/Shougo/dpp.vim"

-- プラグイン内のモジュールを読み込むため、先にruntimepathに追加する
vim.opt.runtimepath:prepend(dpp_src)
local dpp = require("dpp")

--------------
local dpp_base = cache_dir .. "/dpp"
local dpp_config = vim.fs.normalize("~/appdata/local/nvim/configs/dpp.ts")
local denops_src = cache_dir .. "/dpp/repos/github.com/vim-denops/denops.vim"

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




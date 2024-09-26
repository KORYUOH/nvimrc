--------------------------------------------------------------------------------
-- Brief:	plugin setting for neovim
-- Create:	2024/09/26
-- Update:	2024/09/26
-- Author:	KORYUOH
-- github:	KORYUOH/nvimrc
--------------------------------------------------------------------------------

-- dpp source dir
local denopsSrc	= vim.fs.normalize("~/.neovim_cache/dpp/repos/github.com/vim-denops/denops.vim")

local ShougoDir	= vim.fs.normalize("~/.neovim_cache/dpp/repos/github.com/Shougo")
local dppSrc		= ShougoDir .. "/dpp.vim"
local extInstaller	= ShougoDir .. "/dpp-ext-installer"
local extLocal		= ShougoDir .. "/dpp-ext-local"
local extToml		= ShougoDir .. "/dpp-ext-toml"
local extLazy		= ShougoDir .. "/dpp-ext-lazy"
local extGit		= ShougoDir .. "/dpp-protocol-git"
local dppConfig	= vim.fs.normalize("~/nvimrc/configs/dpp.ts")

vim.opt.runtimepath:prepend(dppSrc)
vim.opt.runtimepath:prepend(extInstaller)
vim.opt.runtimepath:prepend(extGit)
vim.opt.runtimepath:prepend(extToml)
vim.opt.runtimepath:prepend(extLazy)
vim.opt.runtimepath:prepend(extLocal)

vim.g.denops_server_addr = "127.0.0.1:34141"
vim.g["denops#debug"]=1

local dpp = require("dpp")

local dppBase = vim.fs.normalize("~/.neovim_cache/dpp")

if dpp.load_state(dppBase) then
	vim.opt.runtimepath:prepend(denopsSrc)

	vim.api.nvim_create_autocmd( "User" , {
		pattern = "DenopsReady",
		callback = function()
			vim.notify("dpp load_state() is failed.")
			dpp.make_state(dppBase , dppConfig )
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

vim.cmd("filetype indent plugin on");
vim.cmd("syntax on")


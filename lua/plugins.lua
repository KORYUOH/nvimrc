--------------------------------------------------------------------------------
-- Brief:	plugin setting for neovim
-- Create:	2024/09/26
-- Update:	2024/09/26
-- Author:	KORYUOH
-- github:	KORYUOH/nvimrc
--------------------------------------------------------------------------------


-- local cachedir	= vim.fs.normalize("~/.neovim_cache")
-- local dppDir	= cachedir .. "/dpp/repos/github.com"
-- local denopsSrc	= dppDir .. "/vim-denops/denops.vim"
--
-- -- dpp source dir
-- local ShougoDir		= dppDir .. "/Shougo"
-- local dppSrc		= ShougoDir .. "/dpp.vim"
-- local extInstaller	= ShougoDir .. "/dpp-ext-installer"
-- local extLocal		= ShougoDir .. "/dpp-ext-local"
-- local extToml		= ShougoDir .. "/dpp-ext-toml"
-- local extLazy		= ShougoDir .. "/dpp-ext-lazy"
-- local extGit		= ShougoDir .. "/dpp-protocol-git"
-- local dppConfig	= vim.fs.normalize("~/nvimrc/configs/dpp.ts")
--
-- vim.opt.runtimepath:append(dppSrc)
-- vim.opt.runtimepath:append(extInstaller)
-- vim.opt.runtimepath:append(extGit)
-- vim.opt.runtimepath:append(extToml)
-- vim.opt.runtimepath:append(extLazy)
-- vim.opt.runtimepath:append(extLocal)
--
-- -- vim.g.denops_server_addr = "127.0.0.1:34141"
-- -- vim.g["denops#debug"]=1
--
-- local dpp = require("dpp")
--
-- local dpp_base = vim.fs.normalize("~/.neovim_cache/dpp")
--
-- if dpp.load_state(dpp_base) then
-- 	vim.opt.runtimepath:prepend(denopsSrc)
-- 	vim.api.nvim_create_autocmd( "User" , {
-- 		pattern = "DenopsReady",
-- 		callback = function()
-- 			vim.notify("dpp load_state() is failed.")
-- 			dpp.make_state(dpp_base, dppConfig )
-- 		end
-- 	})
-- end
--
-- vim.api.nvim_create_user_command("DppInstall" , function(opts)
-- 	vim.cmd("call dpp#async_ext_action('installer' , 'install')")
-- end, {})
-- vim.api.nvim_create_user_command("DppUpdate" , function(opts)
-- 	vim.cmd("call dpp#async_ext_action('installer' , 'update')")
-- end, {})
-- vim.api.nvim_create_user_command("DppCheckUpdate" , function(opts)
-- 	vim.cmd("call dpp#async_ext_action('installer' , 'checkNotUpdated')")
-- end, {})
-- vim.api.nvim_create_user_command("DppCheckInstall" , function(opts)
-- 	vim.cmd("call dpp#async_ext_action('installer' , 'getNotInstalled')")
-- end, {})
--
require("plugin_dpp")


vim.cmd("filetype indent plugin on");
vim.cmd("syntax on")


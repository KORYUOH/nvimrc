--------------------------------------------------------------------------------
-- Brief:	basic setting for neovim
-- Create:	2024/09/20
-- Update:	2024/09/20
-- Author:	KORYUOH
-- github:	KORYUOH/nvimrc
--------------------------------------------------------------------------------

local options = {
	encoding = 'utf-8',
	fileencoding = 'utf-8',
	number = true,
	numberwidth = 4,
	relativenumber = false,
	title = true,
	splitbelow = true,
	splitright = true,
	tabstop = 4,
	shiftwidth = 4,
	scrolloff = 8,
	sidescroll = 1,
	sidescrolloff = 16,
	expandtab = false,
	wrap = false,
	textwidth = 0,
	cmdheight = 2,
	laststatus = 2,
	imsearch = 0,
	autoindent = true,
	buflisted = false,
	showmatch = true,
	ruler = true,
	showcmd = true,
	wildmenu = true,
	spell = true,
	guifont = "Cascedia_Code:h10:cShiftJIS:qDraft",
	guifontwide = "MeiryoKe_Console:h10:cDEFAULT",
	wildoptions = "pum",
	signcolumn = "auto",
	cursorilne = true,
	swapfile = false,
	undofile = true,
	undodir = "~/.nvimundo",
}

for k,v in options do
	vim.opt[k] = v
end

vim.opt.nrformats = ''
vim.opt.spelllang:append({c=true,j=true,k=true})
vim.opt.lsitchars = {tab:'>-'}


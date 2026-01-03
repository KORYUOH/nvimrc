local kmap = vim.api.nvim_keymap
local opt = { noremap = true }

kmap( 'n' , 's<Space>' , '<Cmd>Ddu -name=files file -source-option-file-path=`$BASE_DIR`->expand() -ui-param-ff-split=`floating` -resume<CR>' , opt)
kmap( 'n' , 'sf' , '<Cmd>Ddu -name=files-`win_getid()` filepoint -ui-param-ff-displaySourceName=short --ui-param-ff-split=`floating`<CR>', opt)
vim.keymap.set( "n" , "ss" , function()
	local winid = vim.fn.win_getid()
	local has_git = vim.fn.finddir(".git" , ";") ~= ""

	local sources = { "file_old", }

	if has_git then
		table.insert(sources, "file_git")
	end

	local cmd = {
		"Ddu",
		"-name=files-" .. winid,
		umpack(sources),
		"file" , 
		"-source-option-file-volatile",
		"file",
		"-source-option-file-volatiile",
		"-source-param-file-new",
		"-unique",
		"-expandInput",
		"-resume",
		"-ui-param-ff-displaySourceName=short",
		"-ui-param-ff-split=floating",
	}

	vim.cmd(table.concat(cmd, " "))
end)

kmap()

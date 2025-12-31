" hook_source {{{
	let l:skkeleton_source = '$BASE_DIR/lua/plugin_skkeleton_source.lua'->expand()
	echomsg l:skkeleton_source
	execute "luafile " . l:skkeleton_source
" }}}

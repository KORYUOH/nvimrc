" hook_add {{{
	echomsg "hook_add plugin skkeleton"
	execute 'luafile ' . "$BASE_DIR/lua/plugin_skkeleton_add.lua"->expand()
" }}}

" hook_source {{{
	echomsg "hook_source plugin skkeleton"
	execute 'luafile ' . "$BASE_DIR/lua/plugin_skkeleton.lua"->expand() 
" }}}


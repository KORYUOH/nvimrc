" hook_add {{{
execute 'luafile ' ."$BASE_DIR/lua/plugin_ddc.lua"->expand() 
"}}}
" hook_source {{{
execute 'luafile ' .  "$BASE_DIR/lua/plugin_ddc_source.lua"->expand()
"}}}

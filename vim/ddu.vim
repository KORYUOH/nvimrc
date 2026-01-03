" hook_add {{{
execute 'luafile ' . '$BASE_DIR/lua/plugin_ddu_add.lua'->expand()
" }}}
" hook_source {{{
call ddu#custom#load_config('$BASE_DIR/configs/ddu.ts'->expand())
" }}}


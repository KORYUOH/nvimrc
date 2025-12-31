" hook_source {{{
call pum#set_option(#{
		\	auto_confirm_time : 0,
		\	auto_select : v:false,
		\	border: 'none',
		\	commit_characters: ['.'],
		\	highlight_scrollbar: 'none',
		\	insert_preview: v:true,
		\	max_height: 5,
		\	max_width: 80,
		\	offset_cmdcol: 0,
		\	padding: v:false,
		\	preview: v:true,
		\	preview_remains: v:true,
		\	preview_width: 80,
		\	reversed: v:false,
		\	use_setline: v:false,
		\ })

"NOTE: For Horizontal menu
call pum#set_option(#{
		\	follow_cursor: v:false,
		\	horizontal_menu: v:false,
		\	max_horizontal_items: 2,
		\})
" }}}

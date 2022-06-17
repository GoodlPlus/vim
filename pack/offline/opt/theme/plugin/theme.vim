let g:gruvbox_material_background = 'dark'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

" ------------------------------------------------------------------------------
" Theme Command
" ------------------------------------------------------------------------------
call theme#set_highlight_group()

" ------------------------------------------------------------------------------
" TabLine Command
" ------------------------------------------------------------------------------
call theme#tabeline()

" ------------------------------------------------------------------------------
" StatusLine Command
" ------------------------------------------------------------------------------
augroup auto_update_statusline
	autocmd!
	autocmd BufEnter,WinEnter * call theme#statusline()
augroup END

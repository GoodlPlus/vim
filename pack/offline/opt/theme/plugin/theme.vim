let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = "hard"
" let g:gruvbox_bold=0
colorscheme gruvbox

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

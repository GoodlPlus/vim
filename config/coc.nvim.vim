" ------------------------------------------------------------------------------
" coc.nvim
" ------------------------------------------------------------------------------
let g:coc_global_extensions =
\ [
	\ "coc-clangd",
	\ "coc-pyright",
	\ "coc-snippets",
	\ "coc-vimtex",
	\ "coc-json",
	\ "coc-vimlsp",
	\ "coc-sh",
	\ "coc-leetcode",
\ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr><TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
function s:check_back_space() abort
	let s:col = col('.') - 1
	return !s:col || getline('.')[s:col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
" 			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
function s:go_to_definition(error, response) abort
	if !a:response
		" silent execute 'Leaderf! gtags --auto-jump -d '.expand('<cword>')
	endif
endfunction

function s:go_to_reference(error, response) abort
	if !a:response
		" silent execute 'Leaderf! gtags --auto-jump -r '.expand('<cword>')
	endif
endfunction

function s:go_to_global(error, response) abort
	if !a:response
		" silent execute 'Leaderf! gtags --auto-jump -g '.expand('<cword>')
	endif
endfunction

" nnoremap gd :call <SID>coc_go()<CR>
nnoremap <silent>gd :call CocActionAsync('jumpDefinition', function('<SID>go_to_definition'))<CR>
nnoremap gy <Plug>(coc-type-definition)
nnoremap gi <Plug>(coc-implementation)
nnoremap <silent>gr :call CocActionAsync('jumpReference', function('<SID>go_to_reference'))<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function s:show_documentation() abort
	if (index(['vim','help'], &filetype) >= 0)
		execute 'help '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!'.&keywordprg." ".expand('<cword>')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * call CocActionAsync('highlight')

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)

nmap <Leader>qf  <Plug>(coc-fix-current)

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

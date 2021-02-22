" ------------------------------------------------------------------------------
" Personal auto indent
" ------------------------------------------------------------------------------
function s:auto_parantheses() abort
	if col('.') >= 2 && getline('.')[col('.') - 2] == '{' && getline('.')[col('.') - 1] == '}'
		return "\<CR>\<Tab>\<CR>\<Up>\<Right>"
	else
		return "\<CR>"
	endif
endfunction

inoremap <expr><buffer> <CR> <SID>auto_parantheses()

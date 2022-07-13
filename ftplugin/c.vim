setlocal cinoptions+=g0

" ------------------------------------------------------------------------------
" Personal auto indent
" ------------------------------------------------------------------------------
function s:auto_parantheses() abort
    if col('.') >= 2 && getline('.')[col('.') - 2] == '{' && getline('.')[col('.') - 1] == '}'
        return "\<CR>\<Tab>\<CR>\<Up>\<End>"
"     elseif col('.') >= 2 && getline('.')[col('.') - 2] == '{' " && getline('.')[col('.') - 1] == '}'
"         return "\<CR>\<Tab>\<CR>\}\<Up>\<End>\<BS>"
    else
        return "\<CR>"
    endif
endfunction

inoremap <expr><buffer> <CR> <SID>auto_parantheses()

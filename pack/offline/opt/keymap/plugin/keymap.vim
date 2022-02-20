" ------------------------------------------------------------------------------
" Keymap
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Personal alt keymaps
" ------------------------------------------------------------------------------
call keymap#init_meta()
delfunction keymap#init_meta

" ------------------------------------------------------------------------------
" Personal tab keymaps
" ------------------------------------------------------------------------------
" nnoremap <Tab>H <C-w>H
" nnoremap <Tab>J <C-w>J
" nnoremap <Tab>K <C-w>K
" nnoremap <Tab>L <C-w>L
"
" nnoremap <Tab>w <C-w>w
" nnoremap <Tab>c <C-w>c
"
" nnoremap <Tab>s <C-w>s
" nnoremap <Tab>v <C-w>v

nnoremap <M-,> <C-w><
nnoremap <M-.> <C-w>>

noremap <M-h> <C-w>h
noremap <M-j> <C-w>j
noremap <M-k> <C-w>k
noremap <M-l> <C-w>l

noremap <M-n> <Cmd>bnext<CR>
noremap <M-p> <Cmd>bprevious<CR>

tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l

tnoremap <Esc> <C-\><C-n>

" ------------------------------------------------------------------------------
" Zoom Unzoom
" ------------------------------------------------------------------------------
nnoremap <M-z> :MaximizerToggle<CR>

command! -bang -nargs=0 -range MaximizerToggle :call keymap#toggle(<bang>0)

" ------------------------------------------------------------------------------
" Turn the word to upper or lower case
" ------------------------------------------------------------------------------
"  Turn the word under cursor to upper case
"inoremap <silent> <c-u> <Esc>viwUea
"
"" Turn the current word into title case
"inoremap <silent> <c-t> <Esc>b~lea


" ------------------------------------------------------------------------------
" Indent in visual mode
" ------------------------------------------------------------------------------
vnoremap < <gv
vnoremap > >gv


" ------------------------------------------------------------------------------
" Modify but don't save to register
" ------------------------------------------------------------------------------
" noremap c "_c
" noremap C "_C
" noremap cc "_cc

noremap s "_s
noremap S "_S

noremap x "_x
noremap X "_X

" ------------------------------------------------------------------------------
" Personal search
" ------------------------------------------------------------------------------
" Visual mode pressing * or # searches for the current selection
nnoremap # <Cmd>call keymap#visual_secetion_search('') \| let v:hlsearch = 1 \| let v:searchforward = 0<CR>
nnoremap * <Cmd>call keymap#visual_secetion_search('') \| let v:hlsearch = 1 \| let v:searchforward = 1<CR>
vnoremap <silent> # :<C-u>call keymap#visual_secetion_search(visualmode()) \| let v:hlsearch = 1\| let v:searchforward = 0<CR>
vnoremap <silent> * :<C-u>call keymap#visual_secetion_search(visualmode()) \| let v:hlsearch = 1\| let v:searchforward = 1<CR>

" Search in selected region
vnoremap / <Esc>/\%V
vnoremap ? <Esc>?\%V

nnoremap <Esc> <Cmd>nohlsearch<CR>
nnoremap <Esc><Esc> <Cmd>nohlsearch<CR>

" ------------------------------------------------------------------------------
" Personal compile and run
" ------------------------------------------------------------------------------
nnoremap <M-5> <Cmd>call keymap#compile_run()<CR>

" ------------------------------------------------------------------------------
" Personal comment
" ------------------------------------------------------------------------------
noremap <C-_> :call keymap#comment()<CR>
noremap <C-?> :call keymap#comment()<CR>

" ------------------------------------------------------------------------------
" smooth_scroll
" ------------------------------------------------------------------------------
" noremap <C-u> <Cmd>call keymap#smooth_scroll_up(&scroll * 1)<CR>
" noremap <C-d> <Cmd>call keymap#smooth_scroll_down(&scroll * 1)<CR>
" noremap <C-b> <Cmd>call keymap#smooth_scroll_up(&scroll * 2)<CR>
" noremap <C-f> <Cmd>call keymap#smooth_scroll_down(&scroll * 2)<CR>

" ------------------------------------------------------------------------------
" Enhancement f F t T
" ------------------------------------------------------------------------------
" nnoremap <silent> f :call keymap#forward('f')<CR>
" nnoremap <silent> F :call keymap#forward('F')<CR>
" nnoremap <silent> ; :call keymap#forward_repeat(';')<CR>
" nnoremap <silent> , :call keymap#forward_repeat(',')<CR>
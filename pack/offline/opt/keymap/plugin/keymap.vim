" ------------------------------------------------------------------------------
" Keymap
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Personal alt keymaps
" ------------------------------------------------------------------------------
if !has('nvim') && !has('gui_running')
    call keymap#init_meta(1)
    delfunction keymap#init_meta
endif

" ------------------------------------------------------------------------------
" Personal tab keymaps
" ------------------------------------------------------------------------------
nnoremap <Tab>h <C-w>h
nnoremap <Tab>j <C-w>j
nnoremap <Tab>k <C-w>k
nnoremap <Tab>l <C-w>l
nnoremap <Tab>w <C-w>w
nnoremap <Tab>c <C-w>c
nnoremap <Tab>+ <C-w>+
nnoremap <Tab>- <C-w>-
nnoremap <Tab>, <C-w><
nnoremap <Tab>. <C-w>>
nnoremap <Tab>= <C-w>=
nnoremap <Tab>s <C-w>s
nnoremap <Tab>v <C-w>v
nnoremap <Tab>o <C-w>o
nnoremap <Tab>p <C-w>p

nnoremap <Tab>H <C-w>H
nnoremap <Tab>J <C-w>J
nnoremap <Tab>K <C-w>K
nnoremap <Tab>L <C-w>L

" modify the key value of <C-i>
noremap <Esc>^i <C-i>

nnoremap <Tab> <Nop>

tnoremap <Tab>h <C-\><C-n><C-w>h
tnoremap <Tab>j <C-\><C-n><C-w>j
tnoremap <Tab>k <C-\><C-n><C-w>k
tnoremap <Tab>l <C-\><C-n><C-w>l

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
" make j and k better
" ------------------------------------------------------------------------------
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk
nnoremap J <C-d>
nnoremap K <C-u>
xnoremap J <C-d>
xnoremap K <C-u>
nnoremap H <Cmd>bprevious<CR>
nnoremap L <Cmd>bnext<CR>

" ------------------------------------------------------------------------------
" Indent in visual mode
" ------------------------------------------------------------------------------
xnoremap < <gv
xnoremap > >gv


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
xnoremap <silent> # :<C-u>call keymap#visual_secetion_search(visualmode()) \| let v:hlsearch = 1\| let v:searchforward = 0<CR>
xnoremap <silent> * :<C-u>call keymap#visual_secetion_search(visualmode()) \| let v:hlsearch = 1\| let v:searchforward = 1<CR>

" search in very magic mode
nnoremap / /\v
nnoremap ? ?\v

" Search in selected region
xnoremap / <Esc>/\%V
xnoremap ? <Esc>?\%V

nnoremap <Esc> <Cmd>nohlsearch<CR>
nnoremap <Esc><Esc> <Cmd>nohlsearch<CR>


" ------------------------------------------------------------------------------
" Paste to the system clip
" ------------------------------------------------------------------------------
" xnoremap <Leader>y "+y

" ------------------------------------------------------------------------------
" Personal compile and run
" ------------------------------------------------------------------------------
" nnoremap <Leader-5> <Cmd>call keymap#compile_run()<CR>
nnoremap <Leader>5 <Cmd>call keymap#compile_run()<CR>

" ------------------------------------------------------------------------------
" Personal comment
" ------------------------------------------------------------------------------
noremap <Leader>c :call keymap#comment()<CR>

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

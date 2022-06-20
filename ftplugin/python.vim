let s:has_black = executable('black')
let s:has_yapf = executable('yapf')
let s:has_autopep8 = executable('autopep8')

if s:has_yapf
    setlocal formatprg=yapf
elseif s:has_black
    setlocal formatprg=black\ -q\ -
elseif s:has_autopep8
    setlocal formatprg=autopep8\ --select\ E,W\ -
endif

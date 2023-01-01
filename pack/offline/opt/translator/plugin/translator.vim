if exists('g:loaded_translator')
    finish
else
    let g:loaded_translator = 1
endif

command -nargs=+ Translate call translator#start(<q-args>)

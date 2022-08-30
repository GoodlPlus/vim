vim9script

const type_plugin_root = join([fnameescape(expand('<sfile>:p:h')), '..'], '/')

def ReadFile(file_name: string)
    var lines = readfile(file_name)
    echomsg lines
enddef

echomsg type_plugin_root
ReadFile(join([type_plugin_root, "utils/1.txt"], '/'))

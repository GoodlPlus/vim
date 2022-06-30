vim9script

# https://hzhu212.github.io/posts/2c63bd16/
const style = join([fnameescape(expand('<sfile>:p:h')), '../utils/.clang-format'], '/')

def Pos2Byte(s: string): number
    return line2byte(line(s)) + col(s) - 1
enddef

def StartJob(cmd: list<string>, lines: string)
    var callback =
    {
        'out_cb': OutCallback,
        'err_cb': ErrCallback,
        'exit_cb': ExitCallback,
    }
    echomsg "hello"
    echomsg cmd
    # let l:cmd =
    # \ [
    #     \ 'python3',
    #     \ s:translator_file,
    #     \ l:text,
    # \ ]
    # let l:cmd += l:args
    # let s:info = ''
    var job = job_start(cmd, callback)
    var channel = job_getchannel(job)
    ch_sendraw(channel, lines)
    ch_close_in(channel)
    echomsg cmd
enddef

def OutCallback(channel: channel, message: string)
    echomsg message
    return
enddef

def ErrCallback(channel: channel, message: string)
    echomsg message
    return
enddef

def ExitCallback(job: job, ret: number)
    var job_info = job_info(job)
#      echomsg job_info
#      echomsg ret
    return
enddef

# export def ClangFormat()
#     var mode = mode()
#     var start_line = 1
#     var end_line = line('$')
#     var visual_mode = {'V': 0}
#     if has_key(visual_mode, mode)
#         start_line = min([line('v'), line('.')])
#         end_line = max([line('v'), line('.')])
#     elseif mode != 'n'
#         return
#     endif
#     var original_pos = Pos2Byte('.')
#     var cursor = original_pos
#     var buffer_name = shellescape(bufname('%'))
#     var original_lines = getline(1, line('$'))
#
# #     cmd ..= ' -style=file:' .. style .. ' --lines=' .. start_line .. ':' .. end_line .. ' --cursor=' .. cursor .. ' --assume-filename=' .. buffer_name
#     var cmd =
#     [
#         'clang-format',
#         '-',
# #         '-style=file:' .. style,
# #         '--lines=' .. start_line .. ':' .. end_line,
# #         '--cursor=' .. cursor,
# #         '--assume-filename=' .. buffer_name,
#         # '"' .. join(original_lines, "\n") .. '"',
#     ]
#     # var ret = system(cmd, join(original_lines, "\n"))
#     # var ret = system(cmd, join(original_lines, "\n"))
#     # var splitted_ret = split(ret, "\n")
#     StartJob(cmd, join(original_lines, "\n"))
#
#     # var header = splitted_ret[0]
#     # var formatted_lines = splitted_ret[1 :]
#     # var header_dict = json_decode(header)
#     # var current_pos = header_dict["Cursor"]
#
#     # # Add or replace modified lines
#     # var original_length = len(original_lines)
#     # var formatted_length = len(formatted_lines)
#
#     # # Search start of the line and end of the line
#     # var start = 0
#     # var i = 0
#     # while i < end_line && original_lines[i] == formatted_lines[start]
#     #     ++i
#     #     ++start
#     # endwhile
#     # var end = formatted_length - 1
#     # i = original_length - 1
#     # while i >= start_line - 1 && original_lines[i] == formatted_lines[end]
#     #     --i
#     #     --end
#     # endwhile
#     # var original_end = i
#
#     # if start > end
#     #     return
#     # endif
#
#     # for j in range(start, end)
#     #     if j > original_end
#     #         append(j, formatted_lines[j])
#     #     else
#     #         setline(j + 1, formatted_lines[j])
#     #     endif
#     # endfor
#
#     # if end + 2 <= original_end + 1
#     #     deletebufline('%', end + 2, original_end + 1)
#     # endif
#
#     # execute 'goto' current_pos
# enddef

# export def ClangFormat()
#     var mode = mode()
#     var start_line = 1
#     var end_line = line('$')
#     var visual_mode = {'V': 0}
#     if has_key(visual_mode, mode)
#         start_line = min([line('v'), line('.')])
#         end_line = max([line('v'), line('.')])
#     elseif mode != 'n'
#         return
#     endif
#     var original_pos = Pos2Byte('.')
#     var cursor = original_pos
#     var buffer_name = shellescape(bufname('%'))
#
#     var cmd =
#     [
#         'clang-format',
#         '-style=file:' .. style,
#         '--lines' .. start_line .. ':' .. end_line,
#         '--cursor=' .. cursor,
#         '--assume-filename=' .. buffer_name,
#     ]
# #     cmd ..= ' -style=file:' .. style .. ' --lines=' .. start_line .. ':' .. end_line .. ' --cursor=' .. cursor .. ' --assume-filename=' .. buffer_name
#
#     var original_lines = getline(1, line('$'))
# "     var ret = system(cmd, join(original_lines, "\n"))
#     var ret = system(cmd, join(original_lines, "\n"))
#     var splitted_ret = split(ret, "\n")
#
#     var header = splitted_ret[0]
#     var formatted_lines = splitted_ret[1 :]
#     var header_dict = json_decode(header)
#     var current_pos = header_dict["Cursor"]
#
#     # Add or replace modified lines
#     var original_length = len(original_lines)
#     var formatted_length = len(formatted_lines)
#
#     # Search start of the line and end of the line
#     var start = 0
#     var i = 0
#     while i < end_line && original_lines[i] == formatted_lines[start]
#         ++i
#         ++start
#     endwhile
#     var end = formatted_length - 1
#     i = original_length - 1
#     while i >= start_line - 1 && original_lines[i] == formatted_lines[end]
#         --i
#         --end
#     endwhile
#     var original_end = i
#
#     if start > end
#         return
#     endif
#
#     for j in range(start, end)
#         if j > original_end
#             append(j, formatted_lines[j])
#         else
#             setline(j + 1, formatted_lines[j])
#         endif
#     endfor
#
#     if end + 2 <= original_end + 1
#         deletebufline('%', end + 2, original_end + 1)
#     endif
#
#     execute 'goto' current_pos
# enddef

export def BlackFormat()
    var cmd = 'black'
    var mode = mode()
    var start_line = 1
    var end_line = line('$')
    var visual_mode = {'V': 0}
    if has_key(visual_mode, mode)
        start_line = min([line('v'), line('.')])
        end_line = max([line('v'), line('.')])
    elseif mode != 'n'
        return
    endif
    var original_pos = Pos2Byte('.')
    var cursor = original_pos
    var buffer_name = shellescape(bufname('%'))

    cmd ..= ' --line-length=' .. '88' .. ' --quiet' .. ' < '
    echomsg cmd

    var original_lines = getline(1, line('$'))
    var ret = system(cmd, join(original_lines, "\n"))
    var splitted_ret = split(ret, "\n")

    var header = splitted_ret[0]
    var formatted_lines = splitted_ret[1 :]
    var header_dict = json_decode(header)
    var current_pos = header_dict["Cursor"]

    # Add or replace modified lines
    var original_length = len(original_lines)
    var formatted_length = len(formatted_lines)

    # Search start of the line and end of the line
    var start = 0
    var i = 0
    while i < end_line && original_lines[i] == formatted_lines[start]
        ++i
        ++start
    endwhile
    var end = formatted_length - 1
    i = original_length - 1
    while i >= start_line - 1 && original_lines[i] == formatted_lines[end]
        --i
        --end
    endwhile
    var original_end = i

    if start > end
        return
    endif

    for j in range(start, end)
        if j > original_end
            append(j, formatted_lines[j])
        else
            setline(j + 1, formatted_lines[j])
        endif
    endfor

    if end + 2 <= original_end + 1
        deletebufline('%', end + 2, original_end + 1)
    endif

    execute 'goto' current_pos
enddef

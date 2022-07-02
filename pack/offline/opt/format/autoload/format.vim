vim9script

# https://hzhu212.github.io/posts/2c63bd16/
const style = join([fnameescape(expand('<sfile>:p:h')), '../utils/.clang-format'], '/')
const visual_mode = {'V': 0}
var format_info = {}
var channel_to_buffer = {}
var filetype_to_format =
{
    'c': 'clang-format',
    'cpp': 'clang-format',
    'h': 'clang-format',
    'hpp': 'clang-format',
    'python': ['black', 'isort'],
}

# Error!
def Pos2Byte(row: number, col: number): number
    return line2byte(row) + col - 1
enddef

def PositionToOffset(buffer_name: string, row: number, col: number): number
    var offset = col - 1 # 1-based to 0-based
    if row > 1
        for i in range(1, row - 1) # 1-based to 0-based, exclude current
            offset += len(getbufline(buffer_name, i)[0]) + 1 # +1 for newline
        endfor
    endif
    return offset
enddef

def StartJob(buffer_name: string, cmd: list<any>)
    var callback =
    {
        'out_cb': OutCallback,
        'err_cb': ErrCallback,
        'exit_cb': ExitCallback,
        'in_io': 'buffer',
        'in_name': buffer_name,
    }
    var job = job_start(cmd, callback)
    var job_info = job_info(job)
    var channel = job_getchannel(job)
    var channel_info = ch_info(channel)
    var channel_id = channel_info['id']
    channel_to_buffer[channel_id] = buffer_name
enddef

def OutCallback(channel: channel, message: string)
    var channel_info = ch_info(channel)
    var channel_id = channel_info['id']
    var buffer_name = channel_to_buffer[channel_id]
    var info = format_info[buffer_name][-1]

    OverwriteEachLine(info, message)
    ++info['index']
enddef

# Overwrite All Line
# def OutCallback(channel: channel, message: string)
#     var channel_info = ch_info(channel)
#     var channel_id = channel_info['id']
#     var buffer_name = channel_to_buffer[channel_id]
#
#     add(format_info[buffer_name]['formatted_lines'], message)
# enddef

def ErrCallback(channel: channel, message: string)
    echohl ErrorMsg | echomsg message
enddef

def ExitCallback(job: job, ret: number)
    var job_info = job_info(job)
    var channel = job_getchannel(job)
    var channel_info = ch_info(channel)
    var channel_id = channel_info['id']
    var buffer_name = channel_to_buffer[channel_id]
    var buffer_info = format_info[buffer_name]
    var info = buffer_info[-1]

    DeleteTrailingLines(info)

    var start_time = info['start_time']
    info['format_time'] = split(reltimestr(reltime(start_time)))[0]
    var full_file_name = fnamemodify(buffer_name, ':~')
    var formats = info['formats']
    var echo_message: string
    if ret == 0
        if len(formats) > 0
            GoFormat(buffer_name, formats)
            return
        else
            echo_message = 'Successfully Format ' .. full_file_name .. ' =>'
            for i in range(len(buffer_info))
                var _info = buffer_info[i]
                echo_message ..= ' ' .. _info['format'] .. ': ' .. _info['format_time'] .. 's'
            endfor
            echohl SuccessMsg | echo echo_message
        endif
    else
        echo_message ..= 'Failed to Format ' .. full_file_name .. ' =>'
        for i in range(len(buffer_info))
            var _info = buffer_info[i]
            echo_message ..= ' ' .. _info['format'] .. ': ' .. _info['format_time'] .. 's'
        endfor
        echohl ErrorMsg | echo echo_message
    endif

    SelectFormattedLines(info)
    Clean(channel_id, format_info, channel_to_buffer)
enddef

def SelectFormattedLines(info: dict<any>)
    if !has_key(visual_mode, info['mode'])
        return
    endif
    var buffer_name = info['buffer_name']
    var current_end_line: number
    var end_line = info['end_line']
    var last_line = info['last_line']
    var current_last_line = info['index'] - 1
    if end_line == last_line
        current_end_line = info['index'] - 1
    else
        var end_next_line = getbufline(buffer_name, end_line + 1)
        var max_offset = max([current_last_line - end_line, end_line - 1])
        if max_offset > 0
            for i in range(0, max_offset)
                if end_line + i <= current_last_line && end_next_line == getbufline(buffer_name, end_line + i)
                    current_end_line = end_line + i - 1
                    break
                elseif end_line - i >= 1 && end_next_line == getbufline(buffer_name, end_line - i)
                    current_end_line = end_line - i - 1
                    break
                endif
            endfor
        endif
    endif
    var current_buffer_id = bufnr('%')
    var buffer_id = bufnr(buffer_name)
    execute "normal! \<Esc>"
    execute 'buffer ' .. buffer_id
    cursor(info['start_line'], 0)
    normal! V
    cursor(current_end_line, v:maxcol)
    execute 'buffer ' .. current_buffer_id
enddef

# def ExitCallback(job: job, ret: number)
#     var job_info = job_info(job)
#     var channel = job_getchannel(job)
#     var channel_info = ch_info(channel)
#     var channel_id = channel_info['id']
#     var Buffer_name = channel_to_buffer[channel_id]
#     var info = format_info[buffer_name]
#
#     OverwriteAllLine(info)
#
#     var start_time = info['start_time']
#     var format_time = split(reltimestr(reltime(start_time)))[0]
#     var full_file_name = fnamemodify(buffer_name, ':~')
#     echohl WarningMsg | echo 'Successfully Format ' .. full_file_name .. ' => ' .. format_time .. 's'
#
#     Clean(channel_id, format_info, channel_to_buffer)
# enddef

export def Format()
    var buffer_name = bufname('%')
    var filetype = getbufvar(buffer_name, '&filetype')
    var mode = mode()

    if !has_key(filetype_to_format, filetype)
        return
    elseif has_key(format_info, buffer_name)
        return
    elseif mode != 'n' && !has_key(visual_mode, mode)
        return
    endif

    var format = deepcopy(filetype_to_format[filetype])
    var formats: any
    if type(format) == v:t_string
        formats = [format]
    elseif type(format) == v:t_list
        formats = format
    else
        return
    endif

    GoFormat(buffer_name, formats)
enddef

def GoFormat(buffer_name: string, formats: list<string>)
    var info: dict<any>
    var cmd: list<any>
    var format = remove(formats, 0)

    info['format'] = format
    info['formats'] = formats
    if has_key(format_info, buffer_name)
        add(format_info[buffer_name], info)
    else
        var current_buffer_id = bufnr('%')
        var buffer_id = bufnr(buffer_name)
        execute 'buffer ' .. buffer_id
        retab
        execute 'buffer ' .. current_buffer_id
        format_info[buffer_name] = [info]
    endif

    GetFormatInfo(buffer_name, info)
    if format == 'clang-format'
        GetClangFormatInfo(buffer_name, info)
        cmd = GetClangFormatCmd(info)
    elseif format == 'black'
        GetBlackFormatInfo(buffer_name, info)
        cmd = GetBlackFormatCmd(info)
    elseif format == 'isort'
        GetIsortFormatInfo(buffer_name, info)
        cmd = GetIsortFormatCmd(info)
    endif

    StartJob(buffer_name, cmd)
enddef

def GetFormatInfo(buffer_name: string, info: dict<any>)
    info['start_time'] = reltime()
    info['buffer_name'] = buffer_name
    info['file_name'] = fnamemodify(buffer_name, ':t')
    info['mode'] = mode()
    info['last_line'] = line('$')
    info['cursor'] = getpos('.')
    if info['mode'] == 'n'
        info['start_line'] = 1
        info['end_line'] = line('$')
    elseif has_key(visual_mode, info['mode'])
        if line('.') > line('v')
            info['reverse'] = v:false
        elseif line('.') < line('v')
            info['reverse'] = v:true
        elseif col('.') > col('v')
            info['reverse'] = v:false
        elseif col('.') < col('v')
            info['reverse'] = v:true
        else
            info['reverse'] = v:false
        endif
        info['start_line'] = min([line('v'), line('.')])
        info['end_line'] = max([line('v'), line('.')])
    endif
enddef

def GetClangFormatInfo(buffer_name: string, info: dict<any>)
    var current_pos = getcurpos(bufwinid(buffer_name))
    info['index'] = 0
    info['original_pos'] = Pos2Byte(current_pos[1], current_pos[2])
    # var original_pos = PositionToOffset(buffer_name, current_pos[1], current_pos[2])
enddef

def GetClangFormatCmd(info: dict<any>): list<any>
    var cmd =
    [
        'clang-format',
        '-style=file:' .. style,
        '--lines=' .. info['start_line'] .. ':' .. info['end_line'],
        '--cursor=' .. info['original_pos'],
        '--assume-filename=' .. info['file_name'],
    ]
    return cmd
enddef

def GetBlackFormatInfo(buffer_name: string, info: dict<any>)
    info['index'] = 1
enddef

def GetBlackFormatCmd(info: dict<any>): list<any>
    var cmd =
    [
        'black',
        '-',
        '--line-length=88',
        '--quiet',
    ]
    return cmd
enddef

def GetIsortFormatInfo(buffer_name: string, info: dict<any>)
    info['index'] = 1
enddef

def GetIsortFormatCmd(info: dict<any>): list<any>
    var cmd =
    [
        'isort',
        '-',
        '--profile=black',
        '--quiet',
    ]
    return cmd
enddef

def Clean(channel_id: number, _format_info: dict<any>, _channel_to_buffer: dict<any>)
    var buffer_name = _channel_to_buffer[channel_id]
    remove(_format_info, buffer_name)
    remove(_channel_to_buffer, channel_id)
enddef

def OverwriteEachLine(info: dict<any>, formatted_line: string)
    var index = info['index']
    var buffer_name = info['buffer_name']
    if index < info['start_line']
        return
    elseif index > info['last_line']
        appendbufline(buffer_name, index - 1, formatted_line)
    else
        setbufline(buffer_name, index, formatted_line)
    endif
enddef

def DeleteTrailingLines(info: dict<any>)
    var index = info['index']
    var last_line = info['last_line']
    var buffer_name = info['buffer_name']
    if index <= last_line
        deletebufline(buffer_name, index, last_line)
    endif
enddef

# def OverwriteAllLine(info: dict<any>)
#     var buffer_name = info['buffer_name']
#     var header = info['formatted_lines'][0]
#     var formatted_lines = info['formatted_lines'][1 :]
#     # var header_dict = json_decode(header)
#     # var current_pos = header_dict["Cursor"]
#     var start_line = info['start_line']
#     var end_line = info['end_line']
#
#     # Add or replace modified lines
#     var original_lines = getbufline(buffer_name, 1, '$')
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
#             appendbufline(buffer_name, j, formatted_lines[j])
#         else
#             setbufline(buffer_name, j + 1, formatted_lines[j])
#         endif
#     endfor
#
#     if end + 2 <= original_end + 1
#         deletebufline('%', end + 2, original_end + 1)
#     endif
#
#     # execute 'goto' current_pos
# enddef

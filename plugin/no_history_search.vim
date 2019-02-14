fun! no_history_search#(...)
  let s:last_search_index = histnr('search')
  call feedkeys(a:1.get(b:, 'no_history_search_prepend',
              \     get(g:, 'no_history_search_prepend', '')),
              \ 'n')
endfun

augroup no_history_search
  au!
  au CmdlineLeave * while exists('s:last_search_index')
        \                 && s:last_search_index < histnr('search')
        \         |   call histdel('search', -1)
        \         | endwhile
        \         | let @/ = histget('search', -1)
        \         | unlet! s:last_search_index
augroup END

nnoremap <Plug>(no-history-/)      :call no_history_search#('/')<CR>
vnoremap <Plug>(no-history-/) :<C-U>call no_history_search#('gv/')<CR>
onoremap <Plug>(no-history-/) <ESC>:call no_history_search#(v:operator.'/')<CR>
nnoremap <Plug>(no-history-?)      :call no_history_search#('?')<CR>
vnoremap <Plug>(no-history-?) :<C-U>call no_history_search#('gv?')<CR>
onoremap <Plug>(no-history-?) <ESC>:call no_history_search#(v:operator.'?')<CR>

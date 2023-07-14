map <Leader>, <C-^>
map <leader>h *N
" nnoremap <Leader>h :let @/ = '\V' . escape(expand('<cword>'), '\')<CR>:set hlsearch<CR>
" nnoremap <Leader>g :call TelescopeLiveGrep()<CR>
" 
" function! TelescopeLiveGrep()
"   let @/ = '\V' . escape(expand('<cword>'), '\')
"   Telescope live_grep
" endfunction

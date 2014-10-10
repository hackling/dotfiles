" fresh: vim/plugins/ack.vim
Bundle 'mileszs/ack.vim'
map <Leader>f :Ack!<Space>
map <Leader>F :AckFromSearch!<CR>

" Highlight word at cursor without changing position
map <Leader>h *<C-O>
" Highlight word at cursor and then Ack it.
map <Leader>H *<C-O>:AckFromSearch!<CR>

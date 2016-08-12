" fresh: vim/plugins/ack.vim
Bundle 'mileszs/ack.vim'

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

map <Leader>f :Ack!<Space>
map <Leader>F :AckFromSearch!<CR>

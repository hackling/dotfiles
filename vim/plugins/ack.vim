" " fresh: vim/plugins/ack.vim
" Bundle 'slashmili/alchemist.vim'
" Bundle 'mileszs/ack.vim'
"
" if executable('ag')
"   let g:ackprg = 'ag --vimgrep'
" endif
"
" map <Leader>f :Ack!<Space>
" map <Leader>F :AckFromSearch!<CR>
map <Leader>f :Grepper -query<Space>
map <Leader>F <Leader>h:Grepper -cword -noprompt<CR>

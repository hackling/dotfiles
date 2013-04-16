Bundle 'tpope/vim-dispatch'

"Run rspec for only the current line
map <Leader>r :exec 'Dispatch zeus rspec ' . bufname('%') . ':' . line('.')<CR>

Bundle 'tpope/vim-dispatch'

"Run rspec for only the current line
map <Leader>r <Leader>sd:exec 'Dispatch zeus rspec ' . bufname('%') . ':' . line('.')<CR>
map <Leader>pq <Leader>sd:Dispatch psql envision_development -f % <bar> cat <CR>

" nnoremap <leader>rt :w\|:!bin/rspec<cr>
nnoremap <leader>rc :w\|:!bin/cucumber -p rerun<cr>

"Run rspec test at current line
nnoremap <leader>rt :wa\|:execute('!$SHELL -l -c "rspec '.expand('%').':'.line('.').'"')<cr>

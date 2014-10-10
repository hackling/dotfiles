" Run test at current line
nnoremap <leader>rt :wa\|:execute('!$SHELL -l -c "rspec '.expand('%').':'.line('.').'"')<cr>

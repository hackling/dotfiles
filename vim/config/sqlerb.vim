autocmd Syntax sqlerb runtime! ~/.vim/syntax/sqlerb.vim
autocmd BufEnter,BufWinEnter,BufRead,BufNewFile *.sql.erb let b:eruby_subtype='sqlerb' | set ft=eruby

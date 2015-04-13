syn match  SQL              "[^--].\+" contains=ALL
syn region sqlComment       start="/\*"  end="\*/" contains=sqlTodo
syn match  sqlComment       "--.*$" contains=sqlTodo
syn match  sqlComment       "rem.*$" contains=sqlTodo

highlight link SQL        String
highlight link sqlComment Comment

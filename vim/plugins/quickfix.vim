Bundle 'tomtom/quickfixsigns_vim'
"Config
let g:quickfixsigns_classes = ['vcsdiff']

"Keybindings
" Jump between git diff hunks (quickfixsigns)
nmap [d :silent call quickfixsigns#MoveSigns(-1, '', 1)<CR>
nmap ]d :silent call quickfixsigns#MoveSigns(1, '', 1)<CR>

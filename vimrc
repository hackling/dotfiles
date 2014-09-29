" Required by Vundle
set nocompatible
filetype off
let mapleader = ","

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-surround'
Bundle 'nanotech/jellybeans.vim'

filetype plugin indent on " Required by Vundle

" Wildmenu
set wildmenu
set wildmode=longest,full

" Search
set ignorecase " Case insensitive search
set incsearch  " Makes search act like search in modern browsers
set hlsearch   " Highlight search results

" Whitespace
set listchars=tab:▸\ ,trail:· " Show tabs, trailing whitespace and end of lines
set nowrap                    " Do not wrap lines
set expandtab                 " Use spaces instead of tabs
set smarttab                  " Be smart when using tabs ;-)
set softtabstop=2             " 1 tab is 2 spaces
set shiftwidth=2
set tabstop=2
set foldmethod=indent         " Fold based on indentation.
set foldlevelstart=99         " Expand all folds by default.

" Disable backup. No swap files.
set nobackup
set nowb
set noswapfile

" Bindings
nnoremap <Leader>/ :noh<CR><ESC>|"                    Clear highlights
map <Leader>sw :w<Cr>

" Window
syntax enable       " Syntax highlighting
set hidden          " Allow hiding buffers with unsaved changes
set number          " Show line numbers
set ruler           " Show cursor position
set spelllang=en_au " Australian English

" Persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " Where to save histories
set undolevels=1000         " How many undos
set undoreload=10000        " Number of lines to save

colorscheme jellybeans

" fresh: vim/plugins/ack.vim
Bundle 'mileszs/ack.vim'
map <Leader>f :Ack!<Space>
map <Leader>F :AckFromSearch!<CR>

" Highlight word at cursor without changing position
map <Leader>h *<C-O>
" Highlight word at cursor and then Ack it.
map <Leader>H *<C-O>:AckFromSearch!<CR>


" Clear search
noremap <silent><Leader>/ :nohls<CR>

" Yank and put system pasteboard with <Leader>y/p
noremap <Leader>y "*y
nnoremap <Leader>yy "*yy
noremap <Leader>p "*p
noremap <Leader>P "*P

" Close quickfix window with a command
map <Leader>k :ccl<CR>

" Copy relative path to the system pasteboard
nnoremap <silent><Leader>cf :let @*=expand('%')<CR>

" Copy relative path and line number to the system pasteboard
nnoremap <silent><Leader>cl :let @*=expand('%').':'.line('.')<CR>

" Select all
map <Leader>a ggVG

Bundle 'nathanaelkane/vim-indent-guides'
filetype plugin indent on     " required!
let g:indent_guides_enable_on_vim_startup=1

" Run test at current line
nnoremap <leader>rt :wa\|:execute('!$SHELL -l -c "rspec '.expand('%').':'.line('.').'"')<cr>

" fresh: jasoncodes/dotfiles vim/config/completion.vim
Bundle 'ervandew/supertab'
Bundle 'szw/vim-kompleter'
let g:SuperTabDefaultCompletionType = '<C-x><C-u>' " use completion plugin
let g:kompleter_replace_standard_mappings = 0 " keep original <C-n> and <C-p>
let g:kompleter_case_sensitive = 3 " smartcase

runtime macros/matchit.vim
map <Leader>, <C-^>

" fresh: vim/plugins/nerdtree.vim

"NERD-Tree
Bundle 'scrooloose/nerdtree'

" Nerd Tree mapppings
noremap <Leader>. :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeFind<CR>

let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeHijackNetrw     = 0
let g:loaded_netrw            = 1 " Disable netrw
let g:loaded_netrwPlugin      = 1 " Disable netrw
let g:NERDTreeIgnore          = ['Icon$']
let g:NERDTreeWinPos          = 'right'
let g:NERDTreeMinimalUI       = 1
let g:NERDTreeDirArrows       = 1

" fresh: vim/keybindings/visualblockindent.vim

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" fresh: vim/keybindings/jump_to_start_or_end_of_line.vim

" Jump to start and end of line using the home row keys
noremap H ^
noremap L $

" fresh: vim/plugins/easycommenting.vim

"Keybindings
let g:tcommentMapLeaderOp1 = '<Leader>c'

" fresh: jasoncodes/dotfiles vim/config/tags.vim

if !has_key(g:bundle_names, 'vim-fugitive')
  Bundle 'tpope/vim-fugitive'
end

" dependencies:
"   brew install ctags
"   gem install CoffeeTags

function! UpdateTags()
  if exists('b:git_dir') && executable('ctags')
    call system('(cd "'.b:git_dir.'/.." && [ "$(pwd)" != /usr/local ] && rm -f .git/tags.new && PATH="/usr/local/bin:$PATH" nice ctags --tag-relative -R -f .git/tags.new --exclude=.git --langmap="ruby:+.rake.builder.rjs" . && (cd .git && find .. -name "*.coffee" | if which coffeetags &> /dev/null; then xargs coffeetags -f -; else true; fi) >> .git/tags.new && sort .git/tags.new > .git/tags && rm -f .git/tags.new) &')
  endif
endfunction

" Generate .git/tags (ctags) automatically on save
autocmd BufWritePost * call UpdateTags()

set tags+=.git/tags

" fresh: jasoncodes/dotfiles vim/plugins/ctrlp.vim

Bundle 'jasoncodes/ctrlp-modified.vim'
Bundle 'ivalkeen/vim-ctrlp-tjump'

let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_working_path_mode = 0 " Don't manage
let g:ctrlp_dotfiles = 0 " Ignore all dot/hidden files
let g:ctrlp_custom_ignore = {
 \ 'dir': '\.git$\|\.hg$\|\.svn$\|backups$\|logs$\|tmp$\|_site$',
 \ 'file': '',
 \ 'link': '',
 \ }
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_match_window = 'bottom,order:ttb,min:10,max:10'

" Kill buffers in Ctrl-P with Ctrl-@
" https://github.com/kien/ctrlp.vim/issues/280
let g:ctrlp_buffer_func = { 'enter': 'CtrlPEnter' }
func! CtrlPEnter()
  nnoremap <buffer> <silent> <C-@> :call <sid>CtrlPDeleteBuffer()<cr>
endfunc
func! s:CtrlPDeleteBuffer()
  let line = getline('.')
  let bufid = line =~ '\[\d\+\*No Name\]$' ?
    \ str2nr(matchstr(line, '\d\+')) :
    \ fnamemodify(line[2:], ':p')
  exec "bd" bufid
  exec "norm \<F5>"
endfunc

augroup ctrlp-tjump
  autocmd VimEnter * runtime autoload/ctrlp/tjump.vim
  autocmd VimEnter * let g:ctrlp_tjump_only_silent = 1
  autocmd VimEnter * augroup! ctrlp-tjump
augroup end

map <Leader>t :CtrlP<CR>
map <Leader>T :CtrlPClearAllCaches<CR>:CtrlP<CR>
map <Leader>l :CtrlPBuffer<CR>
map <Leader>m :CtrlPModified<CR>
map <Leader>M :CtrlPBranch<CR>
map <Leader>d :CtrlPCurFile<CR>
map <silent> <C-]> :CtrlPtjump<CR>

" fresh: jasoncodes/dotfiles vim/config/bubbling.vim

Bundle 'matze/vim-move'
Bundle 'AndrewRadev/sideways.vim'

let g:move_map_keys = 0

" Use option-J/K to bubble lines up and down
nmap <silent> ˚ <Plug>MoveLineUp
nmap <silent> ∆ <Plug>MoveLineDown
vmap <silent> ˚ <Plug>MoveBlockUp
vmap <silent> ∆ <Plug>MoveBlockDown

"allows opening of spec files
Bundle 'tpope/vim-rails'

Bundle 'bronson/vim-trailing-whitespace'
" trim & save

map <Leader>sw :FixWhitespace<CR>:up<CR>

"
" NICK
"
"  set nocompatible               " be iMproved
"   filetype off                   " required!
" set rtp+=~/.vim/bundle/vundle/
"  call vundle#rc()
"
" "let vundle manage vundle
" Bundle 'gmarik/vundle'
"
" " fresh: vim/leader.vim
"
" let mapleader = ","
"
" " fresh: vim/keybindings/clear_search.vim
"
" " Clear search
" noremap <silent><Leader>/ :nohls<CR>
"
" " fresh: vim/keybindings/clipboard.vim
"
" " Yank and put system pasteboard with <Leader>y/p
" noremap <Leader>y "*y
" nnoremap <Leader>yy "*yy
" noremap <Leader>p "*p
" noremap <Leader>P "*P
"
" " fresh: vim/keybindings/close-quickfix-window.vim
"
" " Close quickfix window with a command
" map <Leader>k :ccl<CR>
"
" " fresh: vim/keybindings/copyfilename.vim
"
" " Copy relative path to the system pasteboard
" nnoremap <silent><Leader>cf :let @*=expand('%')<CR>
"
" " Copy relative path and line number to the system pasteboard
" nnoremap <silent><Leader>cl :let @*=expand('%').':'.line('.')<CR>
"
" " fresh: vim/keybindings/ctrlA.vim
"
" " Select all
" map <Leader>a ggVG
"
" " fresh: vim/keybindings/highlight_line.vim
"
" "Highlight the current line you are on.
" hi CursorLineNr term=bold ctermfg=225 ctermbg=88 guifg=#ccc5c4
" set cursorline
"
" " fresh: vim/keybindings/highlight_word.vim
"
" " Highlight word at cursor without changing position
" nnoremap <Leader>h *<C-O>
"
" " fresh: vim/keybindings/jump_to_start_or_end_of_line.vim
"
" " Jump to start and end of line using the home row keys
" noremap H ^
" noremap L $
"
" " fresh: vim/keybindings/numpad.vim
"
" " make keypad work in vim with iTerm on OS X!
" map! <Esc>Oq 1
" map! <Esc>Or 2
" map! <Esc>Os 3
" map! <Esc>Ot 4
" map! <Esc>Ou 5
" map! <Esc>Ov 6
" map! <Esc>Ow 7
" map! <Esc>Ox 8
" map! <Esc>Oy 9
" map! <Esc>Op 0
" map! <Esc>On .
" map! <Esc>OQ /
" map! <Esc>OR *
" map! <kPlus> +
" map! <Esc>OS -
"
" " fresh: vim/keybindings/onebutton.vim
"
" " nnoremap <leader>rt :w\|:!bin/rspec<cr>
" nnoremap <leader>rc :w\|:!bin/cucumber -p rerun<cr>
"
" "Run rspec test at current line
" nnoremap <leader>rt :wa\|:execute('!$SHELL -l -c "rspec '.expand('%').':'.line('.').'"')<cr>
"
" " fresh: vim/keybindings/quick_change_buffer.vim
"
" map <Leader>, <C-^>
"
" " fresh: vim/keybindings/rubyshortcuts.vim
"
" "Insert a hash rocket with a keybinding
" imap <Leader>r =><Space>
" "Insert the start of map
" imap <Leader>a .map(&:
" "Insert binding.pry on the current line
" map <Leader>bi Obinding.pry<Esc>
"
" " fresh: vim/keybindings/save-all-and-reload.vim
"
" " Reload and Save all Buffers
" map <silent><Leader>sa :checktime<CR>:silent! wall<CR>:redraw!<CR>:call QuickfixsignsUpdate()<CR>
"
" " fresh: vim/keybindings/visualblockindent.vim
"
" " Reselect visual block after indent
" vnoremap < <gv
" vnoremap > >gv
"
" " fresh: vim/keybindings/window_navigation.vim
"
" " Easy window navigation
" noremap <C-h> <C-w>h
" noremap <C-j> <C-w>j
" noremap <C-k> <C-w>k
" noremap <C-l> <C-w>l
"
" " fresh: vim/keybindings/wrapping.vim
"
" " Wrap Text
" map <Leader>ee :set nowrap<CR>
" map <Leader>ww :set wrap<CR>
"
" " fresh: twe4ked/dotfiles vim/vundle_before.vim
"
" let run_bundle_install = 0
"
" if !isdirectory(expand("~/.vim/bundle/vundle/"))
"   silent !echo "Installing Vundle..."
"   silent !mkdir -p ~/.vim/bundle
"   silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
"   let run_bundle_install = 1
" endif
"
" " fresh: jasoncodes/dotfiles vim/config/statusline.vim
"
" Bundle 'itchyny/lightline.vim'
"
" set laststatus=2
"
" let g:lightline = {}
" let g:lightline.component = {}
" let g:lightline.component_visible_condition = {}
"
" if !has_key(g:bundle_names, 'vim-fugitive')
"   Bundle 'tpope/vim-fugitive'
" end
" let g:lightline.component.fugitive = '%{exists("*fugitive#head")?fugitive#head():""}'
" let g:lightline.component_visible_condition.fugitive = '(exists("*fugitive#head") && ""!=fugitive#head())'
" let g:lightline.component.modified = '%#ModifiedColor#%{LightlineModified()}'
"
" let g:lightline.active =
"   \ {
"   \   'left': [
"   \     [ 'mode', 'paste' ],
"   \     [ 'fugitive', 'readonly', 'relativepath', 'modified' ]
"   \   ],
"   \   'right': [
"   \     [ 'lineinfo' ],
"   \     [ 'percent' ],
"   \     [ 'fileformat', 'fileencoding', 'filetype' ]
"   \   ]
"   \ }
"
" let g:lightline.inactive =
"   \ {
"   \   'left': [
"   \     [ 'relativepath' ]
"   \   ],
"   \   'right': [
"   \     [ 'lineinfo' ],
"   \     [ 'percent' ]
"   \   ]
"   \ }
"
" function! LightlineRefresh()
"   call lightline#init()
"   call lightline#colorscheme()
"   call lightline#update()
" endfunction
"
" function! LightlineModified()
"   let map = { 'V': 'n', "\<C-v>": 'n', 's': 'n', 'v': 'n', "\<C-s>": 'n', 'c': 'n', 'R': 'n'}
"   let mode = get(map, mode()[0], mode()[0])
"   let bgcolor = {'n': [240, '#585858'], 'i': [31, '#0087af']}
"   let color = get(bgcolor, mode, bgcolor.n)
"   exe printf('hi ModifiedColor ctermfg=196 ctermbg=%d guifg=#ff0000 guibg=%s term=bold cterm=bold',
"         \ color[0], color[1])
"   return &modified ? '+' : &modifiable ? '' : '-'
" endfunction
"
" " fresh: jasoncodes/dotfiles vim/mappings/whitespace.vim
"
" Bundle 'bronson/vim-trailing-whitespace'
"
" " http://vim.wikia.com/wiki/Execute_commands_without_changing_the_search_register
" " Executes a command (across a given range) and restores the search register when done.
" function! SafeSearchCommand(line1, line2, theCommand)
"   let search = @/
"   execute a:line1 . "," . a:line2 . a:theCommand
"   let @/ = search
" endfunction
" command! -range -nargs=* SafeSubstitute call SafeSearchCommand(<line1>, <line2>, 's' . <q-args>)
"
" " trim & save
" map <Leader>sw :FixWhitespace<CR>:up<CR>
" map <Leader>sq :FixWhitespace<CR>:up<CR>:CommandW<CR>
"
" " normalize whitespace
" nmap <silent><Leader>ss :SafeSubstitute/\(\S\)\s\+/\1 /ge<CR>:SafeSubstitute/\s*$//e<CR>
" vmap <silent><Leader>ss :SafeSubstitute/\(\S\)\s\+/\1 /ge<CR>gv:SafeSubstitute/\s*$//e<CR>
"
" " fresh: vim/plugins/ack.vim
"
" Bundle 'mileszs/ack.vim'
"
" "Keybindings
" nnoremap <Leader>H *<C-O>:AckFromSearch!<CR>
" nmap <Leader>f :Ack!<Space>
" nmap <Leader>F :AckFromSearch!<CR>
"
" " fresh: vim/plugins/coffeescript.vim
"
" Bundle 'kchmck/vim-coffee-script'
"
" " fresh: vim/plugins/easycommenting.vim
"
" Bundle 'tomtom/tcomment_vim'
"
" "Keybindings
" let g:tcommentMapLeaderOp1 = '<Leader>c'
"
" " fresh: vim/plugins/file-line.vim
"
" Bundle 'bogado/file-line'
"
" " fresh: vim/plugins/indentguides.vim
"
" Bundle 'nathanaelkane/vim-indent-guides'
"
" filetype plugin indent on     " required!
" let g:indent_guides_enable_on_vim_startup=1
"
" " fresh: vim/plugins/jellybeans.vim
"
" "Ennova Colorscheme of choice
" Bundle 'nanotech/jellybeans.vim'
"
" " fresh: vim/plugins/nerdtree.vim
"
" "NERD-Tree
" Bundle 'scrooloose/nerdtree'
"
" " Nerd Tree mapppings
" noremap <Leader>. :NERDTreeToggle<CR>
" noremap <Leader>n :NERDTreeFind<CR>
"
" let g:NERDTreeShowLineNumbers = 0
" let g:NERDTreeHijackNetrw     = 0
" let g:loaded_netrw            = 1 " Disable netrw
" let g:loaded_netrwPlugin      = 1 " Disable netrw
" let g:NERDTreeIgnore          = ['Icon$']
" let g:NERDTreeWinPos          = 'right'
" let g:NERDTreeMinimalUI       = 1
" let g:NERDTreeDirArrows       = 1
"
" " fresh: vim/plugins/rubyblockselection.vim
"
" " Ruby block selection
" Bundle 'kana/vim-textobj-user'
" Bundle 'nelstrom/vim-textobj-rubyblock'
"
" " Required for textobjs
" runtime macros/matchit.vim
" " Use option-J/K to bubble lines up and down
" map <silent> ˚ <Plug>upAndDownUp
" nmap <silent> ∆ <Plug>upAndDownDown
" vmap <silent> ˚ <Plug>upAndDownVisualUp
" vmap <silent> ∆ <Plug>upAndDownVisualDown
" imap <silent> ˚ <Plug>upAndDownInsertUp
" imap <silent> ∆ <Plug>upAndDownInsertDown
"
" " fresh: vim/plugins/solarized.vim
"
" " Bundle 'altercation/vim-colors-solarized'
"
" " Colors
" set t_Co=256                  " I use 16-color solarized, but...
" " syntax enable
" " set background=dark
" "
" " let g:solarized_hitrail=1     " highlight trailing whitespace
" " call togglebg#map("<F5>")     " F5 toggles background dark/light
" " colorscheme solarized
" " hi CursorLineNr ctermfg=137   " highlght current line number
"
" " fresh: vim/plugins/surround.vim
"
" "Change surrounds
" if !has_key(g:bundle_names, 'vim-repeat')
"   Bundle 'tpope/vim-repeat'
" end
" Bundle 'tpope/vim-surround'
" let g:surround_113  = "#{\r}"   " v
" let g:surround_35   = "#{\r}"   " #
" let g:surround_40   = "(\r)"    " (
" let g:surround_41   = "(\r)"    " )
" let g:surround_123  = "{\r}"    " {
" let g:surround_125  = "{\r}"    " }
" let g:surround_91   = "[\r]"    " [
" let g:surround_93   = "[\r]"    " ]
" let g:surround_69   = "expect(\r).to"    " E
"
" " fresh: vim/plugins/tabular.vim
"
" Bundle 'godlygeek/tabular'
"
" " automatically align cucumber tables on |
" " https://gist.github.com/tpope/287147
" autocmd FileType cucumber inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
" function! s:align()
"   let p = '^\s*|\s.*\s|\s*$'
"   if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"     let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
"     let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
"     Tabularize/|/l1
"     normal! 0
"     call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"   endif
" endfunction
"
" " fresh: vim/plugins/tpope.vim
"
" "Git Blame
" if !has_key(g:bundle_names, 'vim-fugitive')
"   Bundle 'tpope/vim-fugitive'
" end
"
" "allows opening of spec files
" Bundle 'tpope/vim-rails'
" map <leader>gc :Rcontroller<cr>
" map <leader>gm :Rmodel<cr>
"
" "Eunuch - Unix Helpers
" Bundle 'tpope/vim-eunuch'
"
" " fresh: vim/plugins/vim-ruby-refactor.vim
"
" Bundle 'rking/vim-ruby-refactoring'
"
" let g:ruby_refactoring_map_keys = 0
"
" " fresh: vim/plugins/vim-ruby.vim
"
" Bundle 'jasoncodes/vim-ruby'
"
" let g:ruby_hanging_indent = 0
"
" " fresh: nathanaelkane/dotfiles vim/plugins/gitgutter.vim
"
" Bundle 'airblade/vim-gitgutter'
"
" let g:gitgutter_realtime = 0
" let g:gitgutter_eager = 1
" let g:gitgutter_map_keys = 0
"
" nmap ]d <Plug>GitGutterNextHunk
" nmap [d <Plug>GitGutterPrevHunk
"
" " fresh: jasoncodes/dotfiles vim/plugins/ctrlp.vim
"
" Bundle 'kien/ctrlp.vim'
" Bundle 'jasoncodes/ctrlp-modified.vim'
" Bundle 'ivalkeen/vim-ctrlp-tjump'
"
" let g:ctrlp_clear_cache_on_exit = 1
" let g:ctrlp_working_path_mode = 0 " Don't manage
" let g:ctrlp_dotfiles = 0 " Ignore all dot/hidden files
" let g:ctrlp_custom_ignore = {
"  \ 'dir': '\.git$\|\.hg$\|\.svn$\|backups$\|logs$\|tmp$\|_site$',
"  \ 'file': '',
"  \ 'link': '',
"  \ }
" let g:ctrlp_match_window_reversed = 0
" let g:ctrlp_match_window = 'bottom,order:ttb,min:10,max:10'
"
" " Kill buffers in Ctrl-P with Ctrl-@
" " https://github.com/kien/ctrlp.vim/issues/280
" let g:ctrlp_buffer_func = { 'enter': 'CtrlPEnter' }
" func! CtrlPEnter()
"   nnoremap <buffer> <silent> <C-@> :call <sid>CtrlPDeleteBuffer()<cr>
" endfunc
" func! s:CtrlPDeleteBuffer()
"   let line = getline('.')
"   let bufid = line =~ '\[\d\+\*No Name\]$' ?
"     \ str2nr(matchstr(line, '\d\+')) :
"     \ fnamemodify(line[2:], ':p')
"   exec "bd" bufid
"   exec "norm \<F5>"
" endfunc
"
" augroup ctrlp-tjump
"   autocmd VimEnter * runtime autoload/ctrlp/tjump.vim
"   autocmd VimEnter * let g:ctrlp_tjump_only_silent = 1
"   autocmd VimEnter * augroup! ctrlp-tjump
" augroup end
"
" map <Leader>t :CtrlP<CR>
" map <Leader>T :CtrlPClearAllCaches<CR>:CtrlP<CR>
" map <Leader>l :CtrlPBuffer<CR>
" map <Leader>m :CtrlPModified<CR>
" map <Leader>M :CtrlPBranch<CR>
" map <Leader>d :CtrlPCurFile<CR>
" map <silent> <C-]> :CtrlPtjump<CR>
"
" " fresh: twe4ked/dotfiles vim/vundle_after.vim
"
" if run_bundle_install == 1
"   :BundleInstall
"
"   silent !echo ""
"   silent !echo "Vim is now ready."
"   :cq
" endif
"
" " fresh: jasoncodes/dotfiles vim/config/tags.vim
"
" if !has_key(g:bundle_names, 'vim-fugitive')
"   Bundle 'tpope/vim-fugitive'
" end
"
" " dependencies:
" "   brew install ctags
" "   gem install CoffeeTags
"
" function! UpdateTags()
"   if exists('b:git_dir') && executable('ctags')
"     call system('(cd "'.b:git_dir.'/.." && [ "$(pwd)" != /usr/local ] && rm -f .git/tags.new && PATH="/usr/local/bin:$PATH" nice ctags --tag-relative -R -f .git/tags.new --exclude=.git --langmap="ruby:+.rake.builder.rjs" . && (cd .git && find .. -name "*.coffee" | if which coffeetags &> /dev/null; then xargs coffeetags -f -; else true; fi) >> .git/tags.new && sort .git/tags.new > .git/tags && rm -f .git/tags.new) &')
"   endif
" endfunction
"
" " Generate .git/tags (ctags) automatically on save
" autocmd BufWritePost * call UpdateTags()
"
" set tags+=.git/tags
"
" " fresh: jasoncodes/dotfiles vim/config/format.vim
"
" function! Format(line1, line2)
"   if getline(a:line1) =~ '^ *<'
"     execute a:line1 . "," . a:line2 . "!xmllint -format -"
"   else
"     execute a:line1 . "," . a:line2 . "!(which json_reformat &> /dev/null && json_reformat || python -mjson.tool) | perl -pe 's{^(\\s*)}{\" \" x (length($1)/2)}e' | sed 's/ *$//'"
"   endif
" endfunction
"
" command! -range=% Format call Format(<line1>, <line2>)
"
" " fresh: jasoncodes/dotfiles vim/config/search.vim
"
" " Find the next match as we type the search
" set incsearch
" " Highlight searches by default
" set hlsearch
"
" " Clear search
" map <silent><Leader>/ :nohls<CR>
"
" " Search for selected text, forwards or backwards.
" " http://vim.wikia.com/wiki/Search_for_visually_selected_text
" vnoremap <silent> * :<C-U>
"   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
"   \gvy/<C-R><C-R>=substitute(
"   \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
"   \gV:call setreg('"', old_reg, old_regtype)<CR>
" vnoremap <silent> # :<C-U>
"   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
"   \gvy?<C-R><C-R>=substitute(
"   \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
"   \gV:call setreg('"', old_reg, old_regtype)<CR>
"
" " Highlight word at cursor without changing position
" map <Leader>h *<C-O>
" " Highlight word at cursor and then Ack it.
" map <Leader>H *<C-O>:AckFromSearch!<CR>
"
" " Search text object
" " http://vim.wikia.com/wiki/Copy_or_change_search_hit
" vnoremap <silent> S //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
"     \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
" omap S :normal vS<CR>
"
" " fresh: jasoncodes/dotfiles vim/config/bubbling.vim
"
" Bundle 'matze/vim-move'
" Bundle 'AndrewRadev/sideways.vim'
"
" let g:move_map_keys = 0
"
" " Use option-J/K to bubble lines up and down
" nmap <silent> ˚ <Plug>MoveLineUp
" nmap <silent> ∆ <Plug>MoveLineDown
" vmap <silent> ˚ <Plug>MoveBlockUp
" vmap <silent> ∆ <Plug>MoveBlockDown
"
" " Use option-H/L to bubble items (function arguments, etc) left and right
" nmap ˙ :SidewaysLeft<CR>
" nmap ¬ :SidewaysRight<CR>
"
" " fresh: jasoncodes/dotfiles vim/config/locksmith.vim
"
" function! s:Locksmith(bang, name)
"   let dir = expand('~/.vim/locksmith-cache')
"   if !isdirectory(dir)
"     call mkdir(dir, 'p')
"   endif
"
"   let file = dir . '/' . a:name . '.vim'
"   if !filereadable(file) || a:bang
"     call system('vim-locksmith '.shellescape(a:name).' > '.shellescape(file))
"   endif
"
"   execute 'source '.file
"   echo 'Cut new key mappings for '.a:name
" endfunction
"
" command! -nargs=1 -bang Locksmith call s:Locksmith('!' == '<bang>', <q-args>)
"
" " fresh: jasoncodes/dotfiles vim/config/completion.vim
"
" Bundle 'ervandew/supertab'
" Bundle 'szw/vim-kompleter'
"
" let g:SuperTabDefaultCompletionType = '<C-x><C-u>' " use completion plugin
"
" let g:kompleter_replace_standard_mappings = 0 " keep original <C-n> and <C-p>
" let g:kompleter_case_sensitive = 3 " smartcase
"
" " fresh: jasoncodes/dotfiles vim/config/undo.vim
"
" if !isdirectory(expand("~/.vim/.undo/"))
"   silent !mkdir -p ~/.vim/.undo/
" endif
" set undodir=$HOME/.vim/.undo
" set undofile
" set undolevels=1000
" set undoreload=10000
"
" " fresh: vim/config/colorcolumn.vim
"
" set colorcolumn=80
"
" " fresh: vim/config/disable_mouse_scroll.vim
"
" set mouse=a
" map <ScrollWheelUp> <Nop>
" map <ScrollWheelDown> <Nop>
" map <ScrollWheelLeft> <Nop>
" map <ScrollWheelRight> <Nop>
"
" " fresh: vim/config/folding.vim
"
" "Configuration
" set foldmethod=indent
" set foldnestmax=10
" set nofoldenable
" set foldlevel=99
" set foldminlines=0
"
" "Keybindings
" nnoremap <Space> za
" vnoremap <Space> za
"
" " fresh: vim/config/general_config.vim
"
" syntax enable
" set background=dark
" set tabstop=2
" set softtabstop=2
" set shiftwidth=2
" set expandtab
" set number
" set hidden
" set noswapfile
" set incsearch " Find the next match as we type the search
" set hlsearch " Highlight searches by default
" set scrolloff=8 "Set point where the file scrolls
" set ignorecase
" set nowrap
" set ttyfast
" set noesckeys
"
" colorscheme jellybeans
"
" " fresh: vim/config/search_highlighting.vim
"
" hi Search cterm=underline ctermfg=201
"
" " fresh: vim/config/tab_completion_table_settings.vim
"
" "Highlighting on table completion
" "hi Pmenu ctermbg=232 ctermfg=255 gui=bold
"
" " fresh: vim/config/tmux_column_select.vim
"
" "Fix cursor for column select
" if exists('$TMUX')
"   let &t_SI = "\<Esc>[3 q"
"   let &t_EI = "\<Esc>[0 q"
" else
"   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" endif
"
" " fresh: vim/config/wrapped_line_movement.vim
"
" " Movement & wrapped long lines
" " This solves the problem that pressing down jumps your cursor 'over' the current line to the next line
" nnoremap j gj
" nnoremap k gk

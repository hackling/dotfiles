" Required by Vundle
set nocompatible
filetype off
let mapleader = ","

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
function s:AutoMkdir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

autocmd BufWritePre * :call s:AutoMkdir(expand('<afile>'), +expand('<abuf>'))
Bundle 'ervandew/supertab'
Bundle 'szw/vim-kompleter'

let g:SuperTabDefaultCompletionType = '<C-x><C-u>' " use completion plugin

let g:kompleter_replace_standard_mappings = 0 " keep original <C-n> and <C-p>
let g:kompleter_case_sensitive = 3 " smartcase
function! Format(line1, line2)
  if getline(a:line1) =~ '^ *<'
    execute a:line1 . "," . a:line2 . "!xmllint -format -"
  else
    execute a:line1 . "," . a:line2 . "!(which json_reformat &> /dev/null && json_reformat || python -mjson.tool) | perl -pe 's{^(\\s*)}{\" \" x (length($1)/2)}e' | sed 's/ *$//'"
  endif
endfunction

command! -range=% Format call Format(<line1>, <line2>)
" Find the next match as we type the search
set incsearch
" Highlight searches by default
set hlsearch

" Clear search
map <silent><Leader>/ :nohls<CR>

" Search for selected text, forwards or backwards.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Highlight word at cursor without changing position
map <silent> <Leader>h :
  \:let view=winsaveview()<CR>
  \*
  \:call winrestview(view)<CR>
vmap <silent> <Leader>h :
  \:<C-U>let view=winsaveview()<CR>
  \gv*
  \:<C-U>call winrestview(view)<CR>

" Highlight word at cursor and then Ack it.
map <Leader>H <Leader>h:AckFromSearch!<CR>
if match(map(copy(g:vundle#bundles), "v:val['name']"), 'vim-fugitive') < 0
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
Bundle 'matze/vim-move'
Bundle 'AndrewRadev/sideways.vim'

let g:move_map_keys = 0

" Use option-J/K to bubble lines up and down
nmap <silent> ˚ <Plug>MoveLineUp
nmap <silent> ∆ <Plug>MoveLineDown
vmap <silent> ˚ <Plug>MoveBlockUp
vmap <silent> ∆ <Plug>MoveBlockDown

" Use option-H/L to bubble items (function arguments, etc) left and right
nmap ˙ :SidewaysLeft<CR>
nmap ¬ :SidewaysRight<CR>
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
" Jump to start and end of line using the home row keys
noremap H ^
noremap L $
" Select all
map <Leader>a ggVG
" Substitute
map <Leader>sr <Leader>h<bar>:%s///g<left><left>
map <Leader>, <C-^>
" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv
Bundle 'jasoncodes/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-rake'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-haml'
Bundle 'kchmck/vim-coffee-script'
Bundle 'rking/vim-ruby-refactoring'

autocmd FileType ruby,rails,haml,hamlc,eruby,yaml,ru,cucumber set ai sw=2 sts=2 et
autocmd BufRead,BufNewFile Podfile,*.podspec set ft=ruby
autocmd BufRead,BufNewFile *.hamlc set ft=haml

let g:ruby_hanging_indent = 0

let g:ruby_refactoring_map_keys = 0

let g:rails_projections = {
  \'app/models/*.rb':{'related':'app/models/%s.sql*'},
  \'app/models/*.sql':{'related':'app/models/%s.rb'},
  \'app/models/*.sql.erb':{'related':'app/models/%s.rb'},
  \'app/sql/*.rb':{'related':'app/sql/%s.sql*'},
  \'app/sql/*.sql':{'related':'app/sql/%s.rb'},
  \'app/sql/*.sql.erb':{'related':'app/sql/%s.rb'}
\}
Bundle 'ctrlpvim/ctrlp.vim'
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
if match(map(copy(g:vundle#bundles), "v:val['name']"), 'vim-repeat') < 0
  Bundle 'tpope/vim-repeat'
end
Bundle 'tpope/vim-unimpaired'
Bundle 'airblade/vim-gitgutter'

let g:gitgutter_realtime = 0
let g:gitgutter_eager = 1
let g:gitgutter_map_keys = 0

nmap ]d <Plug>GitGutterNextHunk
nmap [d <Plug>GitGutterPrevHunk
" fresh: vim/plugins/ack.vim
Bundle 'mileszs/ack.vim'

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

map <Leader>f :Ack!<Space>
map <Leader>F :AckFromSearch!<CR>
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --cached --exclude-standard --others']
Bundle 'twe4ked/vim-diff-toggle'
Bundle 'Lokaltog/vim-easymotion'

let g:EasyMotion_leader_key = '<Leader>e'

map <Space><Space> <Plug>(easymotion-bd-w)
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
"Keybindings
Bundle 'tomtom/tcomment_vim'
let g:tcommentMapLeaderOp1 = '<Leader>c'
Bundle 'elixir-lang/vim-elixir'
Bundle 'bogado/file-line'
Bundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
"NERD-Tree
Bundle 'scrooloose/nerdtree'

" Nerd Tree mapppings
noremap <Leader>. :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeFind<CR>

let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeHijackNetrw     = 0
let g:NERDTreeIgnore          = ['Icon$']
let g:NERDTreeWinPos          = 'right'
let g:NERDTreeMinimalUI       = 1
let g:NERDTreeDirArrows       = 1
"Change surrounds
if match(map(copy(g:vundle#bundles), "v:val['name']"), 'vim-repeat') < 0
  Bundle 'tpope/vim-repeat'
end
Bundle 'tpope/vim-surround'
let g:surround_113  = "#{\r}"   " v
let g:surround_35   = "#{\r}"   " #
let g:surround_40   = "(\r)"    " (
let g:surround_41   = "(\r)"    " )
let g:surround_123  = "{\r}"    " {
let g:surround_125  = "{\r}"    " }
let g:surround_91   = "[\r]"    " [
let g:surround_93   = "[\r]"    " ]
let g:surround_69   = "expect(\r).to"    " E
Bundle 'godlygeek/tabular'
Bundle 'ludovicchabant/vim-gutentags'
let g:gutentags_cache_dir = '/tmp'
Bundle 'ntpeters/vim-better-whitespace'
let g:strip_whitespace_on_save = 1
let g:better_whitespace_enabled = 1

map <Leader>sw :w<CR>
Bundle 'tpope/vim-eunuch'
Bundle 'terryma/vim-expand-region'

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
Bundle 'nanotech/jellybeans.vim'
let g:SuperTabDefaultCompletionType = "<c-n>"
call vundle#end()
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
set backspace=2

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

runtime macros/matchit.vim
colorscheme jellybeans

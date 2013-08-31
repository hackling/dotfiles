Bundle 'kien/ctrlp.vim'
Bundle 'jasoncodes/ctrlp-modified.vim'

"Keybindings
"CtrlP
map <Leader>t :CtrlP<CR>
let g:ctrlp_clear_cache_on_exit   = 1
let g:ctrlp_working_path_mode     = 0 " Handle working path manually
let g:ctrlp_dotfiles              = 0 " Ignore all dot/hidden files
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore         = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|backups$\|logs$\|tmp$',
  \ 'file': '',
  \ 'link': '',
  \ }

"CtrlP-modified
map <Leader>T :CtrlPClearAllCaches<CR>:CtrlP<CR>
map <Leader>l :CtrlPBuffer<CR>
map <Leader>m :CtrlPModified<CR>
map <Leader>d :CtrlPCurFile<CR>

"Shortcuts for jumping to a path easily - Rails oriented
map ,jm :CtrlP<CR> app/models
map ,jc :CtrlP<CR> app/controllers
map ,jv :CtrlP<CR> app/views
map ,jh :CtrlP<CR> app/helpers
map ,jl :CtrlP<CR> lib
map ,jp :CtrlP<CR> public
map ,js :CtrlP<CR> spec
map ,jf :CtrlP<CR> fast_spec
map ,jd :CtrlP<CR> db
map ,jC :CtrlP<CR> config
map ,jV :CtrlP<CR> vendor
map ,jF :CtrlP<CR> factories
map ,jT :CtrlP<CR> test

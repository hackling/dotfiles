"Git Blame
if !has_key(g:bundle_names, 'vim-fugitive')
  Bundle 'tpope/vim-fugitive'
end

"allows opening of spec files
Bundle 'tpope/vim-rails'
map <leader>gc :Rcontroller<cr>
map <leader>gm :Rmodel<cr>

"Eunuch - Unix Helpers
Bundle 'tpope/vim-eunuch'

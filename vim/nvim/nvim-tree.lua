use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
}
require("nvim-tree").setup({
  view = {
    side = "right"
  },
})

vim.cmd([[
  nnoremap <leader>n <cmd>NvimTreeFindFile<cr>
  nnoremap <leader>. <cmd>NvimTreeClose<cr>
]])

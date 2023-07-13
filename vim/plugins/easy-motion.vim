use {
  'Lokaltog/vim-easymotion',
  config = function()
    vim.cmd [[
      let g:EasyMotion_leader_key = '<Leader>e'

      map <Space><Space> <Plug>(easymotion-bd-w)
      nmap s <Plug>(easymotion-s2)
      nmap t <Plug>(easymotion-t2)
    ]]
  end,
}

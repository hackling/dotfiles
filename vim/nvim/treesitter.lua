use {
  'nvim-treesitter/nvim-treesitter',
  run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "c",
        "cpp",
        "javascript",
        "lua",
        "org",
        "ruby",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
      },
    }
  end,
}

-- use { 'neovim/nvim-lspconfig' }
-- use { 'hrsh7th/nvim-cmp', config = [[require('config.nvim-cmp')]] }    
-- use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' } 
-- use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }        -- buffer auto-completion
-- use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }          -- path auto-completion
-- use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }       -- cmdline auto-completion
-- use 'L3MON4D3/LuaSnip'
-- use 'saadparwaiz1/cmp_luasnip'

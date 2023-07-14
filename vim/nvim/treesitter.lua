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

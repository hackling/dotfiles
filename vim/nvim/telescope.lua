use {
  'nvim-telescope/telescope.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
	    pickers = {
		    find_files = {
			    mappings = {
				    i = {
					    ["<C-k>"] = require('telescope.actions').move_selection_previous,
					    ["<C-j>"] = require('telescope.actions').move_selection_next,
				    },
			    },
        },
		    buffers = {
			    mappings = {
				    i = {
					    ["<C-k>"] = require('telescope.actions').move_selection_previous,
					    ["<C-j>"] = require('telescope.actions').move_selection_next,
				    },
			    },
		    },
		    live_grep = {
			    mappings = {
				    i = {
					    ["<C-k>"] = require('telescope.actions').move_selection_previous,
					    ["<C-j>"] = require('telescope.actions').move_selection_next,
				    },
			    },
		    },
		    grep_string = {
			    mappings = {
				    i = {
					    ["<C-k>"] = require('telescope.actions').move_selection_previous,
					    ["<C-j>"] = require('telescope.actions').move_selection_next,
				    },
			    },
		    },
	    }
    })

    -- https://github.com/nvim-telescope/telescope.nvim/issues/555#issuecomment-785919858
    MakeCommandPicker = function(prompt_title, command)
      local make_entry = require "telescope.make_entry"
      local pickers = require "telescope.pickers"
      local finders = require "telescope.finders"
      local conf = require("telescope.config").values
      return function(opts)
        -- By creating the entry maker after the cwd options,
        -- we ensure the maker uses the cwd options when being created.
        opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)

        pickers.new(opts, {
          prompt_title = prompt_title,
          finder = finders.new_oneshot_job(
            vim.tbl_flatten( {
              command
            } ),
            opts
          ),
          previewer = conf.file_previewer(opts),
          sorter = conf.file_sorter(opts),
        }):find()
      end
    end

    builtin = require('telescope.builtin')
    builtin.git_modified = MakeCommandPicker('Git Modified Files', 'modified.sh')
    builtin.git_branch_modified = MakeCommandPicker('Git Branch Modified Files', 'branch_modified.sh')
    builtin.myorg = MakeCommandPicker('Org', 'myorg.sh')

    vim.cmd([[
      nnoremap <C-p>t <cmd>Telescope find_files<cr>
      nnoremap <leader>t <cmd>Telescope find_files<cr>
      nnoremap <leader>l <cmd>Telescope buffers<cr>
      nnoremap <leader>m <cmd>Telescope git_modified<cr>
      nnoremap <leader>M <cmd>Telescope git_branch_modified<cr>
      nnoremap <leader>h :let @/ = '\V' . escape(expand('<cword>'), '\')<CR>:set hlsearch<CR>
      nnoremap <leader>f <cmd>Telescope live_grep<cr>
      map <leader>F <leader>h<cmd>Telescope grep_string<cr>
    ]])
  end,
}

return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>tf', builtin.find_files, {desc="Search all files"})
            vim.keymap.set('n', '<leader>tg', builtin.git_files, {desc="Search git files"})
            vim.keymap.set('n', '<leader>tS', function()
                builtin.grep_string({search = vim.fn.input("grep> ")});
            end, {desc="Grep search"})

            vim.keymap.set('n', '<leader>th', builtin.help_tags, {desc="Help tags"})
            vim.keymap.set('n', '<leader>tb', builtin.buffers, {desc="Search open buffers"})
            vim.keymap.set('n', '<leader>tr', builtin.oldfiles, {desc="Search recent files"})
            vim.keymap.set('n', '<leader>ts', builtin.live_grep, {desc="Live grep"})
            vim.keymap.set('n', '<leader>tk', builtin.keymaps, {desc="Search keymaps"})
            vim.keymap.set('n', '<leader>td', builtin.diagnostics, {desc="Search diagnostics"})
            vim.keymap.set('n', '<leader>/', function()
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                  prompt_title = "Live Grep in Current Buffer",
                  winblend = 10,
                  previewer = false,
                })
            end, { desc = 'Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>t/', function()
              grep_open_files = true,
              builtin.live_grep {
                  prompt_title = 'Live Grep in Open Files',
            }
            end, { desc = 'Search in open files' })

            vim.keymap.set('n', '<leader>tc', function()
                builtin.find_files {
                    cwd = vim.fn.stdpath 'config',
                }
            end, { desc = 'Search Neovim config' })

            require('telescope').setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown()
                    }
                }
            }

            pcall(require('telescope').load_extension, 'ui-select')
        end,
    },
}

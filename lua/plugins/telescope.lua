return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>tf', builtin.find_files, {desc="Search all files"})
            vim.keymap.set('n', '<leader>tg', builtin.git_files, {desc="Search git files"})
            vim.keymap.set('n', '<leader>tS', function()
                builtin.grep_string({search = vim.fn.input("grep> ")});
            end, {desc="Grep search"})

            vim.keymap.set('n', '<leader>vh', builtin.help_tags, {desc="Help tags"})
            vim.keymap.set('n', '<leader>tb', builtin.buffers, {desc="Search open buffers"})
            vim.keymap.set('n', '<leader>tr', builtin.oldfiles, {desc="Search recent files"})
            vim.keymap.set('n', '<leader>ts', builtin.live_grep, {desc="Live grep"})
        end
    },
}

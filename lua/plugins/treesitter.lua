return {
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = {"c_sharp", "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "bash", "dockerfile", "go", "html", "json", "kusto", "markdown_inline", "python", "regex", "yaml" },
                sync_install = false,
                auto_install = true,
                ignore_install = { "javascript" },
                highlight = {
                    enable = true,
                    disable = {},
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    }
}

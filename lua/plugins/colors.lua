return {
    {
        'chriskempson/base16-vim',
        dependencies = {
            "soares/base16.nvim",
        },
        config = function()
            function setcolors(color) 
                vim.cmd("colorscheme base16-onedark")
                -- vim.cmd("hi Pmenu ctermbg=10 ctermfg=15 guibg=#BBBBBB guifg=#000000")
            end

            setcolors()
        end
    },
}

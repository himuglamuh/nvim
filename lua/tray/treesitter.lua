-- Built-in tree-sitter bootstrap.
-- Parsers loaded from ~/.local/share/nvim/site/parser/
-- Queries loaded from ~/.local/share/nvim/site/queries/
-- See `:checkhealth vim.treesitter` to diagnose.

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft == "" then return end

        -- Resolve filetype -> tree-sitter language name
        local lang = vim.treesitter.language.get_lang(ft) or ft

        -- Try to load the parser; bail silently if no .so is available
        if not pcall(vim.treesitter.language.add, lang) then return end

        -- Start highlighting; pcall in case queries are missing
        pcall(vim.treesitter.start, args.buf, lang)
    end,
})

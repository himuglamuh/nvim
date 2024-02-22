return {
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('bufferline').setup {
                options = {
                    mode = "buffers",
                    indicator = {
                        style = "underline",
                    },
                    tab_size = 18,
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        return "(" .. count .. ")"
                    end,
                    name_formatter = function(buf)
                        return buf.bufnr .. " " .. buf.name
                    end,
                    show_buffer_icons = true,
                    separator_style = "thin",
                    always_show_bufferline = true,
                },
            }
        end
    }
}

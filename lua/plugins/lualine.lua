return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
		config = function()
			local harpoon = require("harpoon.mark")

			local function harpoon_component()
				local total_marks = harpoon.get_length()

				if total_marks == 0 then
					return ""
				end

				local current_mark = "—"

				local mark_idx = harpoon.get_current_index()
				if mark_idx ~= nil then
					current_mark = tostring(mark_idx)
				end

				return string.format("󱡅 %s/%d", current_mark, total_marks)
			end

			require("lualine").setup({
				options = {
                    theme = "dracula",
					globalstatus = true,
					component_separators = { left = "", right = "" },
					section_separators = { right = "", left = "" },
                },
                sections = {
                    lualine_a = {
                        { 'mode', left_padding = 2, right_padding = 2 },
                    },
                    lualine_b = { 'filename', 'branch' },
                    lualine_c = { 'buffers', harpoon_component },
                    lualine_x = { 'searchcount', 'selectioncount' },
                    lualine_y = { 'filetype', 'diagnostics', 'diff' },
                    lualine_z = { 'location' },
                },
            })
        end,
    },
}

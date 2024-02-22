local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")

-- center the buffer
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "%", "%zz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

-- find/replace quickly
vim.keymap.set("n", "S", function()
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end)

-- retain visual selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- quick nav to start and end of line
vim.keymap.set("n", "L", "$<left>")
vim.keymap.set("n", "H", "^")

-- buffer and pane navigation
vim.keymap.set("n", "<leader>a", ":bprevious<CR>", {desc="Previous buffer"})
vim.keymap.set("n", "<leader>g", ":bnext<CR>", {desc="Next buffer"})
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", {desc="Vertical split buffer"})
vim.keymap.set("n", "<leader>s", ":split<CR>", {desc="Horizontal split buffer"})
vim.keymap.set("n", "<leader>H", ":wincmd h<CR>", {desc="Move to left pane"})
vim.keymap.set("n", "<leader>J", ":wincmd j<CR>", {desc="Move to below pane"})
vim.keymap.set("n", "<leader>K", ":wincmd k<CR>", {desc="Move to above pane"})
vim.keymap.set("n", "<leader>L", ":wincmd l<CR>", {desc="Move to right pane"})
vim.keymap.set("n", "<leader>b", ":buf ", {desc="Move to right pane"})
vim.keymap.set("n", "<leader>d", ":bd<CR>", {desc="Close buffer"})

-- redo
vim.keymap.set("n", "U", "<C-r>")

-- symbol outline
vim.keymap.set("n", "<leader>so", ":SymbolsOutline<cr>", {desc="SymbolsOutline"})

-- copilot
vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

-- harpoon
vim.keymap.set("n", "<leader>ho", function()
    harpoon_ui.toggle_quick_menu()
end,
{desc="Open Harpoon"})

vim.keymap.set("n", "<leader>ha", function()
    harpoon_mark.add_file()
end,
{desc="Add to Harpoon"})

vim.keymap.set("n", "<leader>h1", function()
    harpoon_ui.nav_file(1)
end,
{desc="Harpoon: File 1"})

vim.keymap.set("n", "<leader>h2", function()
    harpoon_ui.nav_file(2)
end,
{desc="Harpoon: File 2"})

vim.keymap.set("n", "<leader>h3", function()
    harpoon_ui.nav_file(3)
end,
{desc="Harpoon: File 3"})

vim.keymap.set("n", "<leader>h4", function()
    harpoon_ui.nav_file(4)
end,
{desc="Harpoon: File 4"})

vim.keymap.set("n", "<leader>h5", function()
    harpoon_ui.nav_file(5)
end,
{desc="Harpoon: File 5"})

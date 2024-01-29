local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")
local illuminate = require("illuminate")

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

-- quick nav to start and end of line
vim.keymap.set("n", "L", "$<left>")
vim.keymap.set("n", "H", "^")

-- redo
vim.keymap.set("n", "U", "<C-r>")

-- symbol outline
vim.keymap.set("n", "<leader>so", ":SymbolsOutline<cr>", {desc="SymbolsOutline"})

-- illuminate
vim.keymap.set("n", "<leader>]", function()
    illuminate.goto_next_reference()
    vim.api.nvim_feedkeys("zz", "n", false)
end, {desc="Illuminate: Goto next reference"})

vim.keymap.set("n", "<leader>[", function()
    illuminate.goto_prev_reference()
    vim.api.nvim_feedkeys("zz", "n", false)
end, {desc="Illuminate: Goto prev reference"})

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

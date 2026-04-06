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
vim.keymap.set({"n", "v"}, "L", "$<left>")
vim.keymap.set({"n", "v"}, "H", "^")

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
vim.keymap.set("n", "<leader>-", "<C-w>-", {desc="Decrease pane height"})
vim.keymap.set("n", "<leader>=", "<C-w>+", {desc="Increase pane height"})
vim.keymap.set("n", "<leader>,", "<C-w>>", {desc="Increase pane width"})
vim.keymap.set("n", "<leader>.", "<C-w><", {desc="Decrease pane width"})

-- redo
vim.keymap.set("n", "U", "<C-r>")

-- symbol outline
vim.keymap.set("n", "<leader>so", ":SymbolsOutline<cr>", {desc="SymbolsOutline"})

-- copilot
vim.g.copilot_no_tab_map = false

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

-- Normal/visual: start/end of line (non-blank / end)
vim.keymap.set({ "n", "v" }, "<C-a>", "^", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-e>", "$", { noremap = true, silent = true })

-- Insert: do it without leaving insert mode
vim.keymap.set("i", "<C-a>", "<C-o>^", { noremap = true, silent = true })
vim.keymap.set("i", "<C-e>", "<C-o>$", { noremap = true, silent = true })

-- Command-line: beginning/end of command
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<End>", { noremap = true })

-- Obsidian
vim.keymap.set("n", "<leader>of", ":Obsidian quick_switch<CR>", { desc = "Obsidian: find note" })
vim.keymap.set("n", "<leader>os", ":Obsidian search<CR>", { desc = "Obsidian: search vault" })

local function new_weekly_note()
  local vault = vim.fn.expand("~/OneDrive/Apps/remotely-save/scratch2")
  local current = vault .. "/current.md"

  -- archive existing current.md
  if vim.fn.filereadable(current) == 1 then
    local id = nil
    for line in io.lines(current) do
      local match = line:match('^id:%s*"?([^"]+)"?%s*$')
      if match then
        id = match
        break
      end
    end

    if id then
      id = id:gsub('^"(.*)"$', '%1')
      local new_path = vault .. "/" .. id .. ".md"
      os.rename(current, new_path)
      vim.notify("Archived: " .. id .. ".md")
    else
      vim.notify("No id found in current.md frontmatter", vim.log.levels.ERROR)
      return
    end
  end

  -- prompt for the new week id
  vim.ui.input({ prompt = "New week id: " }, function(input)
    if not input or input == "" then
      vim.notify("Cancelled", vim.log.levels.WARN)
      return
    end

    -- write current.md directly
    local date = os.date("%B %-d")
    local f = io.open(current, "w")
    if f then
      f:write("---\n")
      f:write('id: "' .. input .. '"\n')
      f:write("aliases: []\n")
      f:write("tags:\n")
      f:write("  - work-notes\n")
      f:write("  - journal\n")
      f:write("---\n")
      f:write("# " .. date .. "\n")
      f:close()
      vim.cmd("e " .. current)
      vim.notify("Created: current.md for " .. input)
    else
      vim.notify("Failed to create current.md", vim.log.levels.ERROR)
    end
  end)
end

vim.keymap.set("n", "<leader>wn", new_weekly_note, { desc = "New weekly note" })
vim.keymap.set("n", "<leader>on", new_weekly_note, { desc = "New weekly note" })
vim.keymap.set("n", "<leader>ff", ":Obsidian follow_link<CR>", { desc = "Obsidian: follow link" })

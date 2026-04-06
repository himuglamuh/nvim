return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    templates = {
      folder = "templates",
    },
    legacy_commands = false,
    workspaces = {
      {
        name = "scratch2",
        path = "~/OneDrive/Apps/remotely-save/scratch2",
      },
    },
    picker = {
      name = "telescope.nvim",
    },
    completion = {
      nvim_cmp = false,
      blink = false,
    },
    ui = {
      enable = false,
    },
    note_id_func = function(title)
      return title
    end,
    frontmatter = {
      func = function(note)
        if tostring(note.path):match("current%.md$") and vim.g.obsidian_new_week_id then
          local id = vim.g.obsidian_new_week_id
          vim.g.obsidian_new_week_id = nil
          return {
            id = id,
            aliases = {},
            tags = { "work-notes", "journal" },
          }
        end
        return note.metadata
      end,
    },
  },
}

return {
  "nvim-mini/mini.files",
  -- 1. FORCE LOAD ON STARTUP (Fixes the race condition)
  lazy = false,

  -- 2. DISABLE NETRW IMMEDIATELY
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,

  opts = {
    options = {
      -- 3. TELL MINI.FILES TO TAKE OVER DIRECTORIES
      use_as_default_explorer = true,
    },
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 30,
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        -- Check if we are already in a mini.files buffer
        if string.match(buf_name, "^minifiles") then
          require("mini.files").close()
        else
          require("mini.files").open(buf_name, true)
        end
      end,
      desc = "Toggle mini.files (directory of current file)",
    },
    {
      "<leader>E",
      function()
        local minifiles = require("mini.files")
        -- If open, close it; otherwise open at CWD
        if not minifiles.close() then
          minifiles.open(vim.uv.cwd(), true)
        end
      end,
      desc = "Toggle mini.files (cwd)",
    },
    {
      "<leader>fm",
      function()
        local minifiles = require("mini.files")
        if not minifiles.close() then
          minifiles.open(LazyVim.root(), true)
        end
      end,
      desc = "Toggle mini.files (root)",
    },
  },
}

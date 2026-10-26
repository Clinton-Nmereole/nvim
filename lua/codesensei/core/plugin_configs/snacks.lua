-- ============================================================================
-- snacks.nvim — Collection of small QoL plugins by folke
-- ============================================================================

return {
  -- ── snacks.picker — advanced picker (replaces telescope for many tasks) ──
  picker = {
    -- Enabled sources
    sources = {
      files = { hidden = true, ignored = true },
      grep = { hidden = true, ignored = true },
      buffers = {},
      recent = {},
      git_files = {},
      git_status = {},
      git_log = {},
      lsp_references = {},
      lsp_definitions = {},
      lsp_symbols = {},
      lsp_workspace_symbols = {},
      diagnostics = {},
      keymaps = {},
      help = {},
      commands = {},
      colorschemes = {},
      marks = {},
      quickfix = {},
    },
    -- UI layout
    layout = {
      preset = "default",
      layout = {
        box = "horizontal",
        width = 0.8,
        height = 0.8,
        border = "rounded",
        title = "{source} {live}",
        title_pos = "center",
        { box = "vertical", border = "rounded", title = "{title} {live}", title_pos = "center", width = 0.4,
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" }, },
        { win = "preview", border = "rounded", title = "{preview}", width = 0.6, height = 0.7 }, },
    },
    -- Format strings for items
    formatters = {
      file = {
        filename_first = true,
      },
    },
    -- Keymaps inside picker
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
          ["<C-j>"] = { "list_down", mode = { "i", "n" } },
          ["<C-k>"] = { "list_up", mode = { "i", "n" } },
          ["<C-s>"] = { "toggle_preview", mode = { "i", "n" } },
        },
      },
    },
    -- Default matcher (fzf or frecency)
    matcher = {
      frecency = true,
    },
  },

  -- ── snacks.notifier — beautiful notification system ──────────────────
  notifier = {
    enabled = true,
    timeout = 3000,
    width = { min = 40, max = 0.5 },
    height = { min = 1, max = 0.6 },
    margin = { top = 0, right = 1, bottom = 0 },
    padding = true,
    sort = { "level", "added" },
    level = vim.log.levels.TRACE,
    icons = {
      error = " ",
      warn = " ",
      info = " ",
      debug = " ",
      trace = "󰓗 ",
    },
    keep = function(notif)
      return vim.fn.getcmdpos() > 0
    end,
    style = "compact",
    top_down = true,
    -- Replace vim.notify with snacks
    ---@diagnostic disable-next-line: unused-local
    refresh = 50,  -- refresh at most every 50ms
  },

  -- ── snacks.dashboard — startup dashboard ─────────────────────────────
  dashboard = {
    enabled = false, -- disabled until user explicitly enables
    width = 60,
    row = nil, -- nil = center
    col = nil, -- nil = center
    pane_gap = 4,
    autokeys = "1234567890abcdefghijklmnopqrstuvwxyz",
    preset = {
      header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]],
    },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "startup" },
    },
  },

  -- Indent guides and scope highlighting are owned by indent-blankline.
  indent = { enabled = false },

  -- ── snacks.scroll — smooth scrolling ─────────────────────────────────
  scroll = {
    enabled = true,
    animate = {
      duration = { step = 15, total = 150 },
      easing = "linear",
    },
  },

  -- ── snacks.input — floating input ────────────────────────────────────
  input = {
    enabled = true,
  },

  -- ── snacks.words — word under cursor highlight ───────────────────────
  words = {
    enabled = true,
    debounce = 200,
    notify_jump = false,
    notify_end = true,
    foldopen = true,
    jumplist = true,
    modes = { "n", "i" },
  },

  -- ── snacks.bigfile — handle large files gracefully ───────────────────
  bigfile = {
    enabled = true,
    notify = true,
    size = 1.5 * 1024 * 1024, -- 1.5 MB
    line_length = 1000,
    -- Features to disable for large files
    ---@diagnostic disable-next-line: assign-type-mismatch
    setup = function(ctx)
      vim.b.miniindentscope_disable = true
      if vim.fn.exists(":NoMatchParen") ~= 0 then
        vim.cmd([[NoMatchParen]])
      end
    end,
  },

  -- ── snacks.quickfile — quick file operations ─────────────────────────
  quickfile = {
    enabled = true,
  },

  -- ── snacks.statuscolumn — git-aware statuscolumn ─────────────────────
  statuscolumn = {
    enabled = false, -- let gitsigns handle the signcolumn
    folds = {
      open = true,
      git_hl = true,
    },
  },

  -- ── snacks.zen — distraction-free mode ───────────────────────────────
  zen = {
    enabled = true,
    width = 120,
    height = nil,
    zoom = {
      toggles = true,
      win = {
        backdrop = { transparent = true, blend = 100 },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = true },
        tmux = { enabled = true },
      },
    },
  },

  -- ── snacks.image — image viewer ──────────────────────────────────────
  image = {
    enabled = false, -- requires optional deps
    max_height = 20,
    max_width = 0.5,
  },

  -- ── snacks.animate — smooth animations ────────────────────────────────
  animate = {
    enabled = true,
    duration = 20,
    easing = "linear",
    fps = 60,
  },

  -- ── snacks.profiler — built-in profiler ──────────────────────────────
  profiler = {
    enabled = true,
  },

  -- ── Keymaps (set globally, not via snacks config) ─────────────────────
  -- Suggested keymaps for snacks.picker:
  --   <leader>sf → files
  --   <leader>sg → grep
  --   <leader>sb → buffers
  --   <leader>sr → recent
  --   <leader>s" → registers
  --   <leader>s/ → search history
  --   <leader>s: → command history
  --   <leader>sc → colorschemes
  --   <leader>sk → keymaps
  --   <leader>sh → help
  --   <leader>sC → commands
  --   <leader>sR → resume last picker
  --   <leader>un → dismiss all notifications
  --   <leader>uz → toggle zen mode
}

-- ============================================================================
-- fff.nvim — Fast fuzzy file finder (dmtrKovalenko/fff.nvim)
-- ============================================================================

return {
  -- Base path for indexing
  base_path = vim.fn.getcwd(),
  prompt = "> ",
  title = "FFFiles",
  max_results = 100,
  max_threads = 4,
  lazy_sync = true,
  prompt_vim_mode = false,
  follow_symlinks = false,
  enable_home_dir_scanning = true,
  enable_fs_root_scanning = false,

  -- Layout
  layout = {
    height = 0.8,
    width = 0.8,
    prompt_position = "bottom",
    preview_position = "right",
    preview_size = 0.5,
    flex = { size = 130, wrap = "top" },
    min_list_height = 10,
    show_scrollbar = true,
    path_shorten_strategy = "middle_number",
    anchor = "center",
  },

  -- Preview
  preview = {
    enabled = true,
    max_size = 10 * 1024 * 1024, -- 10 MB
    chunk_size = 8192,
    binary_file_threshold = 1024,
    line_numbers = false,
    cursorlineopt = "both",
    wrap_lines = false,
    filetypes = {
      svg = { wrap_lines = true },
      markdown = { wrap_lines = true },
      text = { wrap_lines = true },
    },
  },

  -- Keymaps inside the picker
  keymaps = {
    close = "<Esc>",
    select = "<CR>",
    select_split = "<C-s>",
    select_vsplit = "<C-v>",
    select_tab = "<C-t>",
    move_up = { "<Up>", "<C-p>" },
    move_down = { "<Down>", "<C-n>" },
    preview_scroll_up = "<C-u>",
    preview_scroll_down = "<C-d>",
    toggle_debug = "<F2>",
    cycle_grep_modes = "<S-Tab>",
    cycle_previous_query = "<C-Up>",
    toggle_select = "<Tab>",
    send_to_quickfix = "<C-q>",
    focus_list = "<leader>l",
    focus_preview = "<leader>p",
  },

  -- Frecency (learns from your usage)
  frecency = {
    enabled = true,
    db_path = vim.fn.stdpath("cache") .. "/fff_nvim",
  },

  -- Query history
  history = {
    enabled = true,
    db_path = vim.fn.stdpath("data") .. "/fff_queries",
    min_combo_count = 3,
    combo_boost_score_multiplier = 100,
  },

  -- Git integration
  git = {
    status_text_color = false,
  },

  -- Grep settings
  grep = {
    max_file_size = 10 * 1024 * 1024,
    max_matches_per_file = 100,
    smart_case = true,
    time_budget_ms = 150,
    modes = { "plain", "regex", "fuzzy" },
    trim_whitespace = false,
    location_format = ":%d:%d",
  },

  -- Debug overlay
  debug = {
    enabled = false,
    show_scores = false,
    show_file_info = {
      file_info = true,
      score_breakdown = true,
      timings = {
        modified = true,
        accessed = true,
      },
    },
  },
}

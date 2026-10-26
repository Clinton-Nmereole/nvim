-- ============================================================================
-- oil.nvim — File explorer as a regular buffer
-- ============================================================================

return {
  -- Restore window options when leaving an oil buffer
  restore_win_options = true,
  -- Show hidden files/directories
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return vim.startswith(name, "..")
    end,
    natural_order = "fast",
  },
  -- Skip the "press ? for help" message
  skip_confirm_for_simple_edits = true,
  -- Prompt to save on changes
  prompt_save_on_select_new_entry = false,
  -- Floating window style
  float = {
    padding = 8,
    max_width = 120,
    max_height = 30,
    border = "rounded",
  },
  -- Keymaps within oil buffers
  keymaps = {
    ["?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
    ["<BS>"] = "actions.parent",
    ["<C-r>"] = "actions.refresh",
    ["<C-l>"] = false, -- disable default refresh
    ["<C-w>"] = false, -- disable default close
  },
  -- Use default keymaps on oil buffers
  use_default_keymaps = false,
  -- Configuration for the floating window in ssh connections
  ssh = {
    border = "rounded",
  },
  -- Experimental: watch for filesystem changes
  watch_for_changes = true,
  -- Enable trash support
  delete_to_trash = true,
}

-- ============================================================================
-- gitsigns.nvim — Git integration: signs, blame, hunk navigation
-- ============================================================================

return {
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "▎" },
    topdelete = { text = "󱂥" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  signs_staged = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "▎" },
    topdelete = { text = "󱂥" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  -- Preview hunk in floating window
  preview_config = {
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  -- Attach to these filetypes
  attach_to_untracked = true,
  -- Update signs more aggressively
  update_debounce = 200,
  -- Max file size for live updates (bytes)
  max_file_length = 40000,
  -- Status line integration
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 500,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  -- Use trouble.nvim for quickfix navigation (if available)
  trouble = false,
  -- Keymaps set via on_attach
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend("force", { buffer = bufnr }, opts or {})
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, { desc = "Next Git Hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, { desc = "Prev Git Hunk" })

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
    map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
    map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      { desc = "Stage Selected Hunk" })
    map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      { desc = "Reset Selected Hunk" })

    map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
    map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
    map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
    map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
    map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame Line" })
    map("n", "<leader>hB", gitsigns.toggle_current_line_blame, { desc = "Toggle Line Blame" })
    map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This" })
    map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Diff This ~" })
    map("n", "<leader>tb", gitsigns.toggle_signs, { desc = "Toggle Signs" })
    map("n", "<leader>tB", gitsigns.toggle_numhl, { desc = "Toggle NumHL" })
    map("n", "<leader>tl", gitsigns.toggle_linehl, { desc = "Toggle LineHL" })
    map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle Word Diff" })
    map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })

    -- Text objects
    map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select Hunk (inner)" })
  end,
}

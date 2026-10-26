-- ============================================================================
-- conform.nvim — Lightweight formatter orchestration
-- ============================================================================

return {
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    scss = { "prettierd", "prettier", stop_after_first = true },
    -- Go
    go = { "gofumpt", "goimports-reviser" },
    gomod = { "goimports-reviser" },
    -- Rust
    rust = { "rustfmt", lsp_format = "fallback" },
    -- C / C++
    c = { "clang_format" },
    cpp = { "clang_format" },
    -- Zig
    zig = { "zigfmt" },
    -- Shell
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    -- Misc
    toml = { "taplo" },
    graphql = { "prettierd", "prettier", stop_after_first = true },
    sql = { "sqlfmt" },
    -- Odin (fallback to LSP)
    odin = { lsp_format = "fallback" },
    -- Typst
    typst = { "typstyle", lsp_format = "fallback" },
    -- Nix
    nix = { "nixfmt" },
  },

  -- Format-on-save (async — runs after save, doesn't block)
  format_after_save = function(bufnr)
    -- Disable format on save for files > 1MB
    local max_file_size = 1024 * 1024
    if vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr)) > max_file_size then
      return
    end

    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    return {
      timeout_ms = 2000,
      lsp_fallback = true,
      async = true,
      quiet = false,
    }
  end,

  -- Custom formatter configurations
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2", "-ci" },
    },
    gofumpt = {
      prepend_args = { "-extra" },
    },
    stylua = {
      prepend_args = {
        "--indent-type",
        "Tabs",
        "--indent-width",
        "4",
      },
    },
  },

  -- Notify on format success/failure
  notify_on_error = true,
  -- Default log level
  log_level = vim.log.levels.WARN,

  -- Keymap for manual formatting
  -- (set in keymaps.lua: <leader>fm to format, <leader>fM to format range)
}

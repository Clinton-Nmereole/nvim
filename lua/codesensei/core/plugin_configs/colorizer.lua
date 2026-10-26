-- ============================================================================
-- nvim-colorizer.lua — Color highlighter
-- ============================================================================

return {
  -- Filetypes to attach to
  filetypes = {
    "*",
    "!lazy",
    "!fzf",
    "!toggleterm",
    "!packer",
    "!neo-tree",
    "!NvimTree",
    "!TelescopePrompt",
    "!TelescopeResults",
  },
  -- Default options applied to all filetypes
  user_default_options = {
    -- Tailwind-style: only colorize CSS variables in TSX files
    names = true,
    -- Write CSS values inline
    css = true,
    -- CSS variable syntax: var(--name)
    css_fn = true,
    -- Available modes: foreground, background, virtualtext
    mode = "background",
    -- Virtual text character
    virtualtext = "■",
    -- Update on InsertLeave and TextChanged
    always_update = false,
    -- Tailwind CSS colors (hex, rgb, hsl)
    tailwind = true,
    -- Sass/Less variable syntax: $name, @name
    sass = { enable = true, parsers = { "css" } },
    -- Enable for all modes
    virtualtext_mode = "background",
    -- Disable for large files (> 1000 lines)
    virtualtext_inline = false,
  },
  -- Per-filetype overrides
  buftypes = {},
}

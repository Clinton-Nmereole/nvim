-- ============================================================================
-- showkeys — Eye-candy keys screencaster (nvzone/showkeys)
-- ============================================================================

return {
  timeout = 3,       -- seconds before keys clear
  maxkeys = 5,       -- max keys shown at once
  show_count = true, -- show key count badges
  position = "top-right",
  excluded_modes = { "i" }, -- don't show insert-mode keys
  keyformat = {
    ["<CR>"] = "󰌑",
    ["<Esc>"] = "󱁐",
    ["<BS>"] = "󰁮",
    ["<Space>"] = "󱁐",
    ["<Tab>"] = "󰌒",
  },
}

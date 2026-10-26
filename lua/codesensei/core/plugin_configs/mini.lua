-- ============================================================================
-- mini.nvim — Collection of minimal, independent modules
-- ============================================================================

return {
  -- ── mini.ai — smarter text objects ────────────────────────────────────
  ai = {
    n_lines = 500,
    custom_textobjects = {
      f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
      o = require("mini.ai").gen_spec.treesitter({
        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
      }),
      c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
      t = require("mini.ai").gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
      d = { "%f[%d]%d+" }, -- digits
      e = { -- entire buffer
        { "%f[%S].-%f[%s]", "%f[%S].*%f[%s]" },
        { "^%s*().-()%s*$", "^%s*().*()%s*$" },
      },
      -- Argument / parameter textobjects
      A = require("mini.ai").gen_spec.argument({ brackets = { "%b()", "%b[]", "%b{}" } }),
    },
  },

  -- ── mini.surround — add/change/delete surroundings ────────────────────
  surround = {
    -- Timeout for surround mode (ms)
    mappings = {
      add = "sa", -- saiw" -> surround inner word with quotes
      delete = "sd", -- sd" -> delete surrounding quotes
      find = "sf", -- sf" -> find right surrounding quote
      find_left = "sF", -- sF" -> find left surrounding quote
      highlight = "sh", -- sh" -> highlight surrounding quotes
      replace = "sr", -- sr"' -> replace " with '
      update_n_lines = "sn", -- sn -> update n_lines
    },
    n_lines = 20,
    -- Custom surroundings
    custom_surroundings = {
      -- [ is paired with ]
      ["["] = { suffix = "]" },
      -- ( is paired with )
      ["("] = { suffix = ")" },
      -- { is paired with }
      ["{"] = { suffix = "}" },
      -- f -> function()...end
      f = {
        input = "%[%w-]+%b() do.-end",
        output = { left = "function", right = "end" },
      },
    },
    -- Silence non-error messages
    silent = true,
  },

  -- ── mini.comment — fast comment toggling ─────────────────────────────
  comment = {
    -- Whether to ignore blank lines when commenting
    ignore_blank_line = true,
    -- Start of line when `ignore_blank_line` is true
    start_of_line = false,
    -- Pad comment parts with spaces
    pad_comment_parts = true,
    -- Custom comment string detection
    custom_commentstring = function()
      return vim.bo.commentstring
    end,
    -- Mappings (set globally, not per-buffer)
    mappings = {
      -- Toggle comment (gc in normal, gc in visual)
      comment = "gc",
      -- Toggle comment on current line
      comment_line = "gcc",
      -- Toggle comment using blockwise
      comment_visual = "gc",
      -- Define 'comment' textobject (gcc in normal)
      textobject = "gc",
    },
    -- Hooks
    hooks = {
      pre = function() end,
      post = function() end,
    },
  },

  -- ── mini.indentscope — visualize and operate on indent scope ──────────
  indentscope = {
    draw = {
      delay = 100,
      priority = 2,
      animation = require("mini.indentscope").gen_animation.none(),
    },
    options = {
      border = "both",
      indent_at_cursor = true,
      try_as_border = true,
    },
    -- Mappings
    mappings = {
      goto_top = "[I",
      goto_bottom = "]I",
      object_scope = "ii",
      object_border = "ai",
    },
    symbol = "│",
  },

  -- ── mini.statusline — lightweight statusline ─────────────────────────
  -- (disabled by default — using lualine instead)
  -- statusline = { use_icons = true, set_vim_settings = true },

  -- ── mini.cursorword — highlight word under cursor ─────────────────────
  cursorword = {
    delay = 100,
  },

  -- ── mini.trailspace — highlight trailing whitespace ───────────────────
  trailspace = {},

  -- ── mini.bufremove — buffer deletion with safety ─────────────────────
  -- (no config needed, just call require("mini.bufremove").delete())
}

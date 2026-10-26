-- sidekick.nvim — Neovim AI sidekick (Codex, Claude, Gemini, etc.)
-- Integrates AI CLI tools directly into Neovim via a built-in terminal.
-- User authenticates with their ChatGPT Pro subscription (no API key needed).

---@type sidekick.Config
return {
  -- ── Next Edit Suggestions (NES) ──────────────────────────
  -- Requires GitHub Copilot subscription — disabled for now.
  nes = {
    enabled = false,
  },

  -- ── AI CLI Integration ──────────────────────────────────
  cli = {
    -- Auto-watch for file changes made by AI CLI tools
    watch = true,

    -- Terminal window config
    win = {
      layout = "right", -- side panel on the right
      split = {
        width = 80,     -- narrow enough to keep code visible
        height = 20,
      },
    },

    -- Session persistence: no multiplexer by default.
    -- Enable "tmux" or "zellij" here to persist CLI sessions
    -- across Neovim restarts.
    mux = {
      enabled = false,  -- set to true if you use tmux/zellij
    },

    -- Preferred picker (snacks is already installed)
    picker = "snacks",

    -- Pre-configured CLI tools (sidekick ships with these defaults)
    -- Only Codex is needed with ChatGPT Pro; others are listed
    -- for reference if you install them later:
    --   aider, amazon_q, claude, codex, copilot, crush,
    --   cursor, gemini, grok, opencode, pi, qwen
    tools = {
      codex = {}, -- OpenAI Codex CLI (included with ChatGPT Pro)
    },
  },

  -- ── Appearance ──────────────────────────────────────────
  ui = {
    icons = {
      nes              = " ",
      attached         = " ",
      started          = " ",
      installed        = " ",
      missing          = " ",
      terminal_attached = " ",
      terminal_started  = " ",
    },
  },

  -- ── Debug ───────────────────────────────────────────────
  debug = false,
}

-- ============================================================================
-- minuet-ai.nvim — AI code completions via OpenRouter (free DeepSeek V4 Flash)
-- ============================================================================
-- Requires: OPENROUTER_API_KEY env var (free account at openrouter.ai)
-- The OpenRouter free tier includes DeepSeek models at $0/token.
-- Sign up → openrouter.ai/keys → export OPENROUTER_API_KEY="sk-or-..."
--
-- Manual invoke in insert mode: <A-y> (blink.cmp keymap)
-- Toggle auto-complete: :Minuet blink toggle
-- Change model/provider: :Minuet change_model
-- ============================================================================

return {
	-- ── Provider: OpenRouter via OpenAI-compatible chat API ──────────
	provider = "openai_compatible",
	request_timeout = 2.5,
	throttle = 1500, -- ms between requests (reduces rate-limit pressure)
	debounce = 600, -- ms idle before firing (avoids noise on fast typing)
	n_completions = 3,

	-- ── Blink.cmp integration settings ──────────────────────────────
	blink = {
		enable_auto_complete = true,
	},

	-- ── Provider options: OpenRouter → DeepSeek V4 Flash (free) ────
	provider_options = {
		openai_compatible = {
			api_key = "OPENROUTER_API_KEY",
			end_point = "https://openrouter.ai/api/v1/chat/completions",
			model = "deepseek/deepseek-v4-flash",
			name = "Openrouter",
			optional = {
				max_tokens = 56,
				top_p = 0.9,
				-- Disable thinking to minimise first-token latency
				reasoning = { effort = "none" },
				provider = {
					sort = "throughput", -- fastest provider wins
				},
			},
		},
	},
}

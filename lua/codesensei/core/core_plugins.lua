local themes = require("codesensei.core.themes")
local M = {
	--Pi agent plugin
	{
		"pablopunk/pi.nvim",
		config = function()
			require("pi").setup()
		end,
	},

	{
		"carderne/pi-nvim",
		config = function()
			require("pi-nvim").setup()
		end,
	},
	--[[{
		"aliou/nvim-pi",
		config = function()
			require("pi-nvim").setup({
				-- Seamless: open in a vertical split (like a chat panel)
				auto_start = true,
				data_dir = nil,
				win = {
					layout = "auto", -- "vertical", "horizontal", "float", or "auto"
					width_threshold = 150,
					width = 80,
					height = 20,
					focus_source_on_stopinsert = true, -- switch to source window on exiting terminal mode
					keys = {
						close = { "<C-q>", mode = "n", desc = "Close Pi" },
						stopinsert = { "<C-q>", mode = "t", desc = "Exit terminal mode" },
						suspend = { "<C-z>", mode = "t", desc = "Suspend Neovim" },
						picker = { "<C-Space>", mode = "t", desc = "Open context picker" },
					},
				},
			})
		end,
	},
    ]]
	--

	-- Mini Nvim
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			local mini_config = require("codesensei.core.plugin_configs.mini")
			require("mini.ai").setup(mini_config.ai)
			require("mini.surround").setup(mini_config.surround)
			require("mini.comment").setup(mini_config.comment)
			-- Keep scope motions/text objects; indent-blankline owns drawing.
			vim.g.miniindentscope_disable = true
			require("mini.indentscope").setup(mini_config.indentscope)
			require("mini.cursorword").setup(mini_config.cursorword)
			require("mini.trailspace").setup(mini_config.trailspace)
		end,
	},
	--Telescope
	{
		"nvim-telescope/telescope.nvim",
		--tag = "0.1.4",
		branch = "master",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("telescope").setup()
		end,
	},

	--Treesitter stuff

	{
		"nvim-treesitter/nvim-treesitter",
		--event = { "BufReadPre", "BufRead", "BufNewFile" },
		--cmd = { ":TSInstall", ":TSModuleInfo", ":TSBufEnable", ":TSBufDisable" },
		branch = "main",
		build = { ":TSUpdate" },
		--run = "TSUpdate",
		config = function()
			require("codesensei.core.plugin_configs.treesitter")
		end,
	},

	--undotree
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		init = function()
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_SplitWidth = 22
		end,
	},

	--web dev icons and nvim-tree
	{
		"ryanoasis/vim-devicons",
	},
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		--tag = "nightly" -- optional, updated every week. (see issue #1193)
	},

	--Harpoon for file navigation
	{
		"ThePrimeagen/harpoon",
		lazy = true,
	},

	-- LSP — core server protocol support
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
	},

	-- Mason — LSP / DAP / linter / formatter installer
	{
		"williamboman/mason.nvim",
		opts = {},
	},

	-- Auto-install LSP servers via Mason
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},

	-- None-ls — null-ls fork (formatting & diagnostics outside LSP)
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("null-ls").setup(require("codesensei.core.plugin_configs.null-ls"))
		end,
	},

	-- Mason null-ls bridge — install none-ls tools via Mason
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
	},
	{
		"rafamadriz/friendly-snippets",
		lazy = true,
	},

	-- Minuet — AI code completions via LLM (OpenRouter DeepSeek free tier)
	{
		"milanglacier/minuet-ai.nvim",
		lazy = true,
		config = function()
			require("minuet").setup(require("codesensei.core.plugin_configs.minuet"))
		end,
	},

	-- Blink.cmp — modern completion engine (replaces nvim-cmp)
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
			"milanglacier/minuet-ai.nvim", -- AI completions source
		},
		config = function()
			require("codesensei.core.plugin_configs.blink")
		end,
	},

	--Lsp-Lines
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup({
				vim.diagnostic.config({
					virtual_text = true,
					virtual_lines = true,
				}),
			})
		end,
	},



	--indent blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
				indent = { char = "¦" },
			})
		end,
	},

	{
		"numToStr/Comment.nvim",
	},

	{
		"glepnir/lspsaga.nvim",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opt = true,
	},

	--Debbugger
	{
		"mfussenegger/nvim-dap",
		lazy = true,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		lazy = true,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
		lazy = true,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opt = {
			handlers = {},
		},
	},
	-- Mason handles all LSP/DAP/linter installations (configured in lsp.lua & dap configs)

	--Python debugger
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("dap-python").setup()
		end,
		lazy = false,
	},
	--Go Debbugger
	{
		"dreamsofcode-io/nvim-dap-go",
		ft = "go",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
		lazy = true,
	},

	-- Notify
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
		init = function()
			vim.notify = require("notify")
		end,
	},

	--Auto pairs
	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "snacks_picker_input", "spectre_panel", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			-- Blink handles brackets for accepted completions itself.
		end,
	},

	--bufferline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup()
		end,
	},

	--Noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					hover = {
						enabled = true,
					},
					signature = {
						enabled = true,
					},
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
				},
			})
		end,
	},

	--[[
    --Miscellaneous
    --]]
	--
	--
	--Alpha-nvim
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},

	--Go language support
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
		end,
	},

	--Nim language support
	{
		"alaviss/nim.nvim",
		ft = "nim",
	},

	--Odin language support
	{
		"Tetralux/odin.vim",
		ft = "odin",
	},

	--Rust language support
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("rust-tools").setup()
		end,
	},

	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 0 -- Conform owns format-on-save
		end,
	},

	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			crates.show()
		end,
	},

	--Astrojs support
	{
		"wuelnerdotexe/vim-astro",
		ft = "astro",
	},

	--[[Zig language support
	{
		"ziglang/zig.vim",
		event = { "BufReadPre", "BufRead", "BufNewFile" },
		init = function()
			vim.g.zig_fmt_autosave = 1
		end,
		ft = "zig",
		lazy = false,
	},]]
	--

	-- Spectre search and replace
	{
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup()
		end,
	},

	--[[Codeium for AI suggestions
	{
		"Exafunction/codeium.vim",
		lazy = false,
	},]]
	--
	--[[

	{
		"monkoose/neocodeium",
		event = "VeryLazy",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup()
			vim.keymap.set("i", "<Tab>", neocodeium.accept)
		end,
	},
    ]]
	--

	--[[Hardtime for vim suggestions
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {},
	},]]
	--

	--LazyGit
	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		dependencies = "nvim-lua/plenary.nvim",
		init = function()
			vim.g.lazygit_floating_window_winblend = 0
			vim.g.lazygit_floating_window_scaling_factor = 0.9
			vim.g.lazygit_floating_window_border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
			vim.g.lazygit_use_neovim_remote = 1
			vim.g.lazygit_floating_window_use_plenary = 0
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			spec = {
				{ "<leader>a", group = "AI / Harpoon", mode = { "n", "x" } },
				{ "<leader>c", group = "Code" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>du", group = "Debug windows" },
				{ "<leader>f", group = "Files / format", mode = { "n", "x" } },
				{ "<leader>h", group = "Git hunks", mode = { "n", "x" } },
				{ "<leader>j", group = "Just tasks" },
				{ "<leader>l", group = "Git / diagnostics" },
				{ "<leader>m", group = "Make / windows" },
				{ "<leader>n", group = "File tree" },
				{ "<leader>r", group = "Rename / run" },
				{ "<leader>s", group = "Search / splits" },
				{ "<leader>t", group = "Tabs / toggles" },
				{ "<leader>u", group = "UI" },
				{ "<leader>x", group = "Diagnostics / lists" },
			},
		},
	},

	--Todo Comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	--Plugin that remembers the last color theme called with ":colorscheme"
	{
		"raddari/last-color.nvim",
		lazy = false,
		priority = 1000,
	},

	--Latex support
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_general_viewer = "zathura"
			vim.g.compiler_method = "tex-live"
			vim.g.maplocalleader = ","
		end,
	},
	-- Transparent background for neovim
	{
		"tribela/vim-transparent",
	},

	--[[Neorg plugin
	{
		"nvim-neorg/neorg",
		run = ":Neorg sync-parsers",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
					["core.keybinds"] = {
						config = {
							default_keybindings = true,
						},
					},
				},
			})
		end,
		dependencies = "nvim-lua/plenary.nvim",
	},]]
	--

	-- Trouble
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opt = {},
	},

	--barbacue
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},

	--colorizer
	{
		"norcalli/nvim-colorizer.lua",
		opts = function() return require("codesensei.core.plugin_configs.colorizer") end,
	},

	--Conform
	{
		"stevearc/conform.nvim",
		opts = function() return require("codesensei.core.plugin_configs.conform") end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	-- ── Oil.nvim — file explorer ───────────────────────────────────
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Oil",
		keys = {
			{ "<leader>e", "<cmd>Oil<CR>", desc = "Oil Explorer" },
			{ "-", "<cmd>Oil<CR>", desc = "Oil (parent dir)" },
		},
		opts = function() return require("codesensei.core.plugin_configs.oil") end,
	},

	-- ── Showkeys — keypress display ───────────────────────────────
	{
		"nvzone/showkeys",
		cmd = "ShowkeysToggle",
		event = "VeryLazy",
		opts = function() return require("codesensei.core.plugin_configs.showkeys") end,
		config = function(_, opts)
			require("showkeys").setup(opts)
			-- Insert mode can close the overlay before its timeout callback runs.
			-- Guard upstream cleanup so a second close cannot redraw a missing window.
			local state = require("showkeys.state")
			local utils = require("showkeys.utils")
			local clear_and_close = utils.clear_and_close
			utils.clear_and_close = function()
				if not state.win or not vim.api.nvim_win_is_valid(state.win) then
					state.keys = {}
					state.win = nil
					return
				end
				clear_and_close()
			end
			-- Auto-enable on startup so you don't have to toggle every session
			vim.defer_fn(function()
				pcall(vim.cmd.ShowkeysToggle)
			end, 100)
		end,
	},

	-- ── Gitsigns — git gutter signs ───────────────────────────────
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = function() return require("codesensei.core.plugin_configs.gitsigns") end,
	},

	-- ── Sidekick.nvim — AI assistant with Codex CLI ───────────────
	{
		"folke/sidekick.nvim",
		dependencies = {
			"folke/snacks.nvim", -- optional: better prompt/tool picker
		},
		event = "VeryLazy",
		keys = {
			{ "<c-.>", function() require("sidekick.cli").focus() end, mode = { "n", "t", "i" }, desc = "AI: Focus CLI" },
			{ "<leader>aa", function() require("sidekick.cli").toggle({ name = "codex", focus = true }) end, desc = "AI: Toggle Codex" },
			{ "<leader>as", function() require("sidekick.cli").select() end, desc = "AI: Select CLI Tool" },
			{ "<leader>ak", function() require("sidekick.cli").prompt() end, desc = "AI: Ask with Prompt" },
			{ "<leader>ac", function() require("sidekick.cli").toggle({ name = "codex", focus = true }) end, desc = "AI: Chat with Codex" },
			{ "<leader>ar", function() require("sidekick.cli").send({ msg = "review" }) end, desc = "AI: Review File" },
			{ "<leader>ad", function() require("sidekick.cli").close() end, desc = "AI: Detach Session" },
			{ "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, mode = { "n", "x" }, desc = "AI: Send This" },
			{ "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, desc = "AI: Send File" },
			{ "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = { "x" }, desc = "AI: Send Selection" },
			{ "<leader>ap", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "AI: Prompt Picker" },
		},
		opts = function() return require("codesensei.core.plugin_configs.sidekick") end,
	},

	-- ── Snacks.nvim — QoL utilities ───────────────────────────────
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = function() return require("codesensei.core.plugin_configs.snacks") end,
	},

	--Nvim lint
	--[[
	{
		"mfussenegger/nvim-lint",
	},
    ]]
	--

	--LspKind
	{ "onsails/lspkind.nvim" },

	--[[ Code Companion AI (commented — using sidekick+Codex instead)
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"saghen/blink.cmp",
				opts = {
					sources = {
						default = { "codecompanion" },
						providers = {
							codecompanion = {
								name = "CodeCompanion",
								module = "codecompanion.providers.completion.blink",
								enabled = true,
							},
						},
					},
				},
			},
		},
		config = true,
	},
    ]]
	--

	--Themes
	themes,
}

return M

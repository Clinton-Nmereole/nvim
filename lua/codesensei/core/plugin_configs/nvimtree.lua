local g = vim.g
local api = vim.api

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

vim.cmd("hi NvimTreeNormal guibg=NONE")

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = false,
	},
	view = {
		adaptive_size = true,
		side = "left",
		width = 24,
		preserve_window_proportions = true,
	},
	filesystem_watchers = {
		enable = true,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	git = {
		ignore = false, -- Set to false to show gitignored files by default
	},
})

local function open_nvim_tree()
	-- open the tree
	require("nvim-tree.api").tree.open()
end

api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

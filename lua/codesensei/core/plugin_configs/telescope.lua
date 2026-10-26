local keymap = vim.keymap
local builtin = require("telescope.builtin")

-- Telescope owns file/text navigation; Snacks supplies utility pickers.
keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find project files" })
keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep project" })
keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })
keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Grep word under cursor" })
keymap.set("n", "<leader>fz", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy search current buffer" })
keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search help tags" })
keymap.set("n", "<leader>fn", function()
    builtin.find_files({
        cwd = vim.fn.stdpath("config"),
        prompt_title = "Neovim config files",
        hidden = true,
    })
end, { desc = "Find Neovim config files" })

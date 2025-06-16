local keymap = vim.keymap
local api = vim.api
--local themes = require("codesensei.core.themes")
local themes = vim.fn.getcompletion("","color")
--local a = {}

--[[
for i,theme in pairs(themes) do
  table.insert(a, theme.name)
end
]]--


--theme picker
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local dropdown = require("telescope.themes").get_dropdown()

function  Enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
  actions.close(prompt_bufnr)
end

function  Next_color(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

function  Prev_color(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end



local mini = {
  layout_strategy = "horizontal",
  layout_config = {
    height = 20,
    width = 0.7,
    prompt_position = "top"
  },
  sorting_strategy = "ascending",

}

local opts = {
  finder = finders.new_table(themes),
  sorter = sorters.get_fzy_sorter({}),

  attach_mappings = function (prompt_bufnr, map)
    map("i", "<CR>", Enter)
    map("i", "<Up>", Prev_color)
    map("i", "<Down>", Next_color)
    return true
  end,
}

local colors = pickers.new(mini, opts)

api.nvim_create_user_command("ColorMe", function()
  colors:find()
end, {})

keymap.set("n", "<leader>th", ":ColorMe<CR>")

--Bufferline
keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true})
keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true})





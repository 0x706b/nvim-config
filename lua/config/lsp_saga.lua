local M = require'util.keymap'
local border = require'util.border'
local lspsaga = require'lspsaga'

lspsaga.setup {
  border_style = 'round',
  diagnostic_prefix_format = "%d. ",
}

vim.api.nvim_exec([[
autocmd CursorHold * Lspsaga show_cursor_diagnostics
]], false)

M.keymap({
  { 'n', 'K', '<cmd>Lspsaga hover_doc<cr>', { silent = true, noremap = true } },
  { 'n', '<leader>p', '<cmd>Lspsaga code_action<cr>', { silent = true, noremap = true } }
})

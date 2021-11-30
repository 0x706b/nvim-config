local M = require'util.keymap'

M.keymap {
  { 'n', '<leader>ff', '<CMD>Telescope find_files<CR>', { noremap = true } },
  { 'n', '<leader>fg', '<CMD>Telescope live_grep<CR>', { noremap = true } }
}

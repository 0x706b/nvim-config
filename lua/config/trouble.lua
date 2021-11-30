local M = require'util.keymap'
require'trouble'.setup {}

M.keymap {
  { 'n', '<leader>xx', '<CMD>Trouble<CR>', { noremap = true, silent = true } }
}

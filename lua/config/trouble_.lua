require'trouble'.setup {}

local noremap = { noremap = true }

local maps = {
  { 'n', '<leader>xx', ':TroubleToggle<CR>', noremap },
  { 'n', '<leader>xw', ':TroubleToggle lsp_workspace_diagnostics<CR>', noremap },
  { 'n', '<leader>xd', ':TroubleToggle lsp_document_diagnostics<CR>', noremap },
  { 'n', '<leader>xq', ':TroubleToggle quickfix<CR>', noremap },
  { 'n', '<leader>xl', ':TroubleToggle loclist<CR>', noremap }
}

require'util.keymap'.keymap(maps)
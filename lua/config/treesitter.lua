require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  ignore_install = { 'comment' },
  highlight = {
    enable = true,
    disable = { 'typescript', 'tsx' }
  },
  indent = {
    enable = true,
    disable = { 'typescript', 'tsx' }
  }
}

vim.api.nvim_set_keymap(
  'n',
  '<leader>sp',
  ":lua require'nvim-treesitter-playground.hl-info'.show_hl_captures()<CR>",
  { noremap = true, silent = true }
)

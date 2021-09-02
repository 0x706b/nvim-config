require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = true,
  }
}

vim.api.nvim_set_keymap(
  'n',
  '<leader>sp',
  ":lua require'nvim-treesitter-playground.hl-info'.show_hl_captures()<CR>",
  { noremap = true, silent = true }
)

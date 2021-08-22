local n, i, t, o, v, esc = "n", "i", "t", "o", "v", "<esc>"
local silent = { silent = true }
local silnoremap = { silent = true, noremap = true }

local mappings = {}

local maps = {
  { n, "gd", ":lua require'telescope.builtin'.lsp_definitions()<CR>", silent },
  { n, "gi", ":lua require'telescope.builtin'.lsp_implementations()<CR>", silent },
  { n, "gy", ":lua vim.lsp.buf.type_definition()<CR>", silent },
  { n, "gr", ":lua require'telescope.builtin'.lsp_references()<CR>", silent },
  { n, "<A-d>", ":lua require'telescope.builtin'.lsp_workspace_diagnostics()<CR>", silent },
  { n, "K", ":lua vim.lsp.buf.hover({ border = 'rounded' })<CR>", silent },
  { n, 'L', ":lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded', focusable = false })<CR>", silnoremap },
  { n, 'ff', ":lua require'telescope.builtin'.find_files()<CR>", silent }
}

mappings.setup = function()
	-- Apply the keymaps
	require('util.keymap').keymap(maps)
end

return mappings
local map = vim.api.nvim_set_keymap

vim.g.bufferline = {
  animation = true,
  auto_hide = true
}

local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<S-TAB>', ':BufferPrevious<CR>', opts)
map('n', '<TAB>', ':BufferNext<CR>', opts)

-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
map('n', '<A->>', ':BufferMoveNext<CR>', opts)

-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)

-- Close buffer
map('n', '<C-c>', ':BufferClose<CR>', opts)

-- Magic buffer-picking mode
map('n', '<C-p>', ':BufferPick<CR>', opts)

-- Sort automatically by...
map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)

vim.api.nvim_command('source ~/.config/nvim/config/barbar_colors.vim')

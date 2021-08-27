local lspkind = require 'config.lspkind'
local cmp = require 'cmp'

vim.o.completeopt = "menuone,noselect"

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

cmp.setup {
  documentation = {
    border = 'rounded',
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
  },
  
  mapping = {
    ['<CR>'] = function(fallback)
      local complete_info = vim.fn.complete_info()
      local selected = complete_info.selected

      if vim.fn.pumvisible() ~= 0 and selected ~= -1 then
        cmp.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        })
        return
      end

      if vim.fn['vsnip#expandable']() ~= 0 then
        vim.fn.feedkeys(t('<Plug>(vsnip-expand)'), '')
        return
      end

      fallback()
    end,
    
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t("<C-n>"), '')
      elseif vim.fn['vsnip#available'](1) == 1 then
         vim.fn.feedkeys(t("<Plug>(vsnip-expand-or-jump)"), '')
      elseif check_back_space() then
        vim.fn.feedkeys(t("<Tab>"), '')
      else
        cmp.mapping.complete()
      end
    end,
      
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t("<C-p>"), '')
      elseif vim.fn['vsnip#available'](-1) == 1 then
         vim.fn.feedkeys(t("<Plug>(vsnip-jump-prev)"), '')
      elseif check_back_space() then
        vim.fn.feedkeys(t("<S-Tab>"), '')
      end
    end,
  },
  
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' }
  },
  
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = lspkind.presets.default[vim_item.kind]
        .. " "
        .. vim_item.kind
      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
      })[entry.source.name]
      return vim_item
    end
  },
}

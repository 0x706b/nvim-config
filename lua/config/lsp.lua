local lspconfig = require 'lspconfig'
local saga = require 'lspsaga'
local m = require 'util.keymap'

local n, i, t, o, v, esc = "n", "i", "t", "o", "v", "<esc>"
local silent = { silent = true }

local function mapbuf(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

local silnoremap = {noremap = true, silent = true}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "rounded"
  }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded"
  }
)

local lsp_signature_config = {
  bind = true,
  border = 'rounded',
  hint_enable = false,
  floating_window = true,
  hi_parameter = 'Title',
  padding = ' ',
  toggle_key = '<M-x>',
  zindex = 50,
  fix_pos = true
}

local function get_node_modules(root_dir)
  local root_node = root_dir .. "/node_modules"
  local stats = uv.fs_stat(root_node)
  if stats == nil then
    return nil
  else
    return root_node
  end
end

local on_attach = function (client, bufnr)
  mapbuf(n, '<leader>p', "<cmd>lua vim.lsp.buf.code_action()<CR>", silnoremap)
  mapbuf(v, '<leader>p', "<cmd>lua vim.lsp.buf.range_code_action()<CR>", silnoremap)

      -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    mapbuf(n, "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", silnoremap)
  elseif client.resolved_capabilities.document_range_formatting then
    mapbuf(n, "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", silnoremap)
  end

  -- vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.diagnostic.show_position_diagnostics({ border = 'rounded', focusable = false })")
  vim.api.nvim_command("autocmd CursorHold  <buffer> lua require'lspsaga.diagnostic'.show_cursor_diagnostics()")

end

saga.init_lsp_saga {
  use_saga_diagnostic_sign = false,
  border_style = 'round',
  code_action_prompt = {
    enable = false
  }
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
  debounce_text_changes = 100,
  on_attach = function (client, bufnr)
    require 'lsp_signature'.on_attach(lsp_signature_config, bufnr)
    vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
    vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
    vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()")
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end
}

lspconfig.diagnosticls.setup {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'scss'},
  init_options = {
    linters = {
      eslint_d = {
        command = 'eslint_d',
        rootPatterns = {
          '.eslintrc',
          '.eslintrc.cjs',
          '.eslintrc.js',
          '.eslintrc.json',
          '.eslintrc.yaml',
          '.eslintrc.yml',
        },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint_d',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = { 'info', 'warning', 'error'}
      }
    },
    filetypes = {
      javascript = 'eslint_d',
      javascriptreact = 'eslint_d',
      typescript = 'eslint_d',
      typescriptreact = 'eslint_d',
    },
    formatters = {
      prettier_eslint = {
        command = 'prettier-eslint',
        args = { '--prettier-last', '--stdin', '--stdin-filepath', '%filepath' },
        rootPatterns = {
          '.eslintrc',
          '.eslintrc.cjs',
          '.eslintrc.js',
          '.eslintrc.json',
          '.eslintrc.yaml',
          '.eslintrc.yml',
        },
      },
      prettier = {
        command = 'prettier',
        args = { '--stdin', '--stdin-filepath', '%filepath' }
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'prettier_eslint',
      javascriptreact = 'prettier_eslint',
      json = 'prettier',
      scss = 'prettier',
      typescript = 'prettier_eslint',
      typescriptreact = 'prettier_eslint'
   }
  }
}

local vs_code_extracted = {
  html = "vscode-html-language-server",
  cssls = "vscode-css-language-server",
}

for ls, cmd in pairs(vs_code_extracted) do
  lspconfig[ls].setup {
    cmd = {cmd, "--stdio"},
    on_attach = on_attach,
    capabilities = capabilities
  }
end

lspconfig.jsonls.setup {
  cmd = {"vscode-json-language-server", "--stdio"},
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"json", "jsonc"},
  settings = {
    json = {
      -- Schemas https://www.schemastore.org
      schemas = {
        {
          fileMatch = {"package.json"},
          url = "https://json.schemastore.org/package.json"
        },
        {
          fileMatch = {"tsconfig*.json"},
          url = "https://json.schemastore.org/tsconfig.json"
        },
        {
          fileMatch = {
            ".prettierrc",
            ".prettierrc.json",
            "prettier.config.json"
          },
          url = "https://json.schemastore.org/prettierrc.json"
        },
        {
          fileMatch = {".eslintrc", ".eslintrc.json"},
          url = "https://json.schemastore.org/eslintrc.json"
        },
        {
          fileMatch = {".babelrc", ".babelrc.json", "babel.config.json"},
          url = "https://json.schemastore.org/babelrc.json"
        },
        {
          fileMatch = {"lerna.json"},
          url = "https://json.schemastore.org/lerna.json"
        },
        {
          fileMatch = {"now.json", "vercel.json"},
          url = "https://json.schemastore.org/now.json"
        },
        {
          fileMatch = {
            ".stylelintrc",
            ".stylelintrc.json",
            "stylelint.config.json"
          },
          url = "http://json.schemastore.org/stylelintrc.json"
        }
      }
    }
  }
}

vim.fn.sign_define("LspDiagnosticsSignError", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = ""})

-- Capture real implementation of function that sets signs
local orig_set_signs = vim.lsp.diagnostic.set_signs

local set_signs_limited = function(diagnostics, bufnr, client_id, sign_ns, opts)

  -- original func runs some checks, which I think is worth doing
  -- but maybe overkill
  if not diagnostics then
    diagnostics = diagnostic_cache[bufnr][client_id]
  end

  -- early escape
  if not diagnostics then
    return
  end

  -- Work out max severity diagnostic per line
  local max_severity_per_line = {}
  for _,d in pairs(diagnostics) do
    if max_severity_per_line[d.range.start.line] then
      local current_d = max_severity_per_line[d.range.start.line]
      if d.severity < current_d.severity then
        max_severity_per_line[d.range.start.line] = d
      end
    else
      max_severity_per_line[d.range.start.line] = d
    end
  end

  -- map to list
  local filtered_diagnostics = {}
  for i,v in pairs(max_severity_per_line) do
    table.insert(filtered_diagnostics, v)
  end

  -- call original function
  orig_set_signs(filtered_diagnostics, bufnr, client_id, sign_ns, opts)
end

vim.lsp.diagnostic.set_signs = set_signs_limited

local maps = {
  { n, "gd", "<cmd>lua require'telescope.builtin'.lsp_definitions()<CR>", silent },
  { n, "gi", "<cmd>lua require'telescope.builtin'.lsp_implementations()<CR>", silent },
  { n, "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", silent },
  { n, "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", silent },
  { n, "<A-d>", "<cmd>lua require'telescope.builtin'.lsp_workspace_diagnostics()<CR>", silent },
  { n, "K", "<cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>", silent },
  { n, 'ff', "<cmd>lua require'telescope.builtin'.find_files()<CR>", silent },
  { n, '<leader>p', "<cmd>lua require'lspsaga.codeaction'.code_action()<CR>", silnoremap },
  { n, '<leader>r', "<cmd>lua require'lspsaga.rename'.rename()<CR>", silnoremap }
}

m.keymap(maps)

local lsp_status = require 'lsp-status'
local lspconfig = require 'lspconfig'
local m = require 'util.keymap'

local n, i, t, o, v, esc = "n", "i", "t", "o", "v", "<esc>"
local silent = { silent = true }

local function mapbuf(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

local silnoremap = {noremap = true, silent = true}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

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

-- vim.api.nvim_command("autocmd CursorHoldI * lua vim.lsp.buf.signature_help()")

local lsp_signature_config = {
  bind = true,
  border = 'rounded',
  hint_enable = false,
  floating_window = true,
  fix_pos = true,
}

local function get_node_modules(root_dir)
  -- util.find_node_modules_ancestor()
  local root_node = root_dir .. "/node_modules"
  local stats = uv.fs_stat(root_node)
  if stats == nil then
    return nil
  else
    return root_node
  end
end

local on_attach = function (client)
  --[[
     [ require 'lsp_signature'.on_attach(lsp_signature_config)
     ]]
  lsp_status.on_attach(client)
  lsp_status.register_progress()

  mapbuf(n, '<leader>p', "<cmd>lua vim.lsp.buf.code_action()<CR>", silnoremap)
  mapbuf(v, '<leader>p', "<cmd>lua vim.lsp.buf.range_code_action()<CR>", silnoremap)

      -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    mapbuf(n, "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", silnoremap)
  elseif client.resolved_capabilities.document_range_formatting then
    mapbuf(n, "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", silnoremap)
  end

  -- vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.diagnostic.show_position_diagnostics({ border = 'rounded', focusable = false })")
  vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
  vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
  vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()")
  vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()")

end

lspconfig.tsserver.setup {
  capabilities = capabilities,
  debounce_text_changes = 100,
  on_attach = on_attach
}

lspconfig.diagnosticls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'scss'},
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint',
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
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      prettier_eslint = {
        command = 'prettier-eslint',
        args = { '--stdin', '--stdin-filepath', '%filename' },
        rootPatterns = { '.git' },
      },
      prettier = {
        command = 'prettier',
        args = { '--stdin-filepath', '%filename' }
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
  { n, "gd", ":lua require'telescope.builtin'.lsp_definitions()<CR>", silent },
  { n, "gi", ":lua require'telescope.builtin'.lsp_implementations()<CR>", silent },
  { n, "gy", ":lua vim.lsp.buf.type_definition()<CR>", silent },
  { n, "gr", ":lua require'telescope.builtin'.lsp_references()<CR>", silent },
  { n, "<A-d>", ":lua require'telescope.builtin'.lsp_workspace_diagnostics()<CR>", silent },
  { n, "K", ":lua vim.lsp.buf.hover({ border = 'rounded' })<CR>", silent },
  { n, 'L', ":lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded', focusable = false })<CR>", silnoremap },
  { n, 'ff', ":lua require'telescope.builtin'.find_files()<CR>", silent }
}

m.keymap(maps)

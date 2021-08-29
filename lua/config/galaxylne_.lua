local gl = require "galaxyline"

gl.short_line_list = { 'coc-explorer' }

local gls = gl.section

local vcs = require "galaxyline.provider_vcs"
local fileinfo = require "galaxyline.provider_fileinfo"

local condition = require('galaxyline.condition')

local colors = {
  bg = "#121111",
  fg = "#D3CFCF",
  dark_gray = "#222020",
  gray = "#5F5959",
  light_gray = "#9D9695",
  light_red = "#D76363",
  dark_red = "#FF2D3C",
  green = "#7FAC71",
  yellow = "#D7A863",
  orange = "#FFAA23",
  cyan = "#81A7BB",
  blue = "#7488AD",
  dark_purple = "#9E80BB",
  light_purple = "#AD8ECA",
  info = '#68B9F0'
}

local modes = {
  n = "normal",
  v = "visual (char)",
  V = "visual (line)",
  [""] = "visual (block)",
  s = "select (char)",
  S = "select (line)",
  [""] = "select (block)",
  i = "insert",
  ic = "completion",
  ix = "completion",
  R = "replace",
  Rc = "completion",
  Rx = "completion",
  c = "command",
  cv = "ex",
  ce = "normal ex",
  r = "hit enter",
  ["r?"] = "confirm",
  ["!"] = "command",
  t = "terminal"
}

local mode_color = {
  n = colors.light_gray,
  i = colors.green,
  v = colors.cyan,
  [""] = colors.cyan,
  V = colors.cyan,
  c = colors.light_red,
  no = colors.dark_purple,
  s = colors.orange,
  S = colors.orange,
  [""] = colors.orange,
  ic = colors.yellow,
  R = colors.light_purple,
  Rv = colors.light_purple,
  cv = colors.light_red,
  ce = colors.light_red,
  r = colors.cyan,
  rm = colors.cyan,
  ["r?"] = colors.cyan,
  ["!"] = colors.light_red,
  t = colors.light_red
}

local buf_icon = {
  help             = '  ',
  defx             = '  ',
  nerdtree         = '  ',
  denite           = '  ',
  ['vim-plug']     = '  ',
  dbui             = '  ',
  magit            = '  ',
  NvimTree         = '  ',
  ['coc-explorer'] = '  ',
}

local icons = {
  lock = '',
  pencil = ''
}

local hi_normal = { colors.light_gray, colors.dark_gray }
local hi_reversed = { colors.bg, colors.light_gray }

local hi_separator = { colors.light_gray, colors.dark_gray }

gls.short_line_left[1] = {
  BufferType = {
    provider = function ()
      return vim.bo.filetype
    end,
    separator = ' ',
    separator_highlight = hi_separator,
    highlight = {colors.gray, colors.dark_gray,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = function ()
      return buf_icon[vim.bo.filetype] or ''
    end,
    highlight = {colors.gray, colors.dark_gray,'bold'}
  }
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end

local function file_readonly(readonly_icon)
  if vim.bo.filetype == 'help' then
    return ''
  end
  local icon = readonly_icon or ''
  if vim.bo.readonly == true then
    return " " .. icon .. " "
  end
  return ''
end

gls.left[1] = {
  Edge = {
    provider = function()
      local mode = vim.fn.mode()
      vim.api.nvim_command("hi GalaxyEdge guifg=" .. mode_color[mode])
      return "▊ "
    end,
    highlight = {colors.cyan, colors.dark_gray}
  }
}

gls.left[2] = {
  ViMode = {
    provider = function()
      local mode = vim.fn.mode()
      -- auto change color according the vim mode
      vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[mode])
      return modes[mode]
    end,
    separator = ' ',
    separator_highlight = hi_separator,
    highlight = {colors.light_gray, colors.dark_gray, "bold"}
  }
}

gls.left[3] = {
  SlantDown = {
    provider = function ()
      return ''
    end,
    separator = '',
    separator_highlight = { colors.light_gray, colors.gray },
    highlight = { colors.gray, colors.dark_gray } 
  }
}

gls.left[4] = {
  GitIcon = {
    provider = function() return ' ' end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    separator = '<-',
    separator_highlight = { colors.bg, colors.light_gray, 'bold' },
    highlight = { colors.bg, colors.light_gray, 'bold' },
  }
}

gls.left[5] = {
  GitBranch = {
    provider = function ()
      local branch = vcs.get_git_branch()
      if branch then
        return branch .. ' '
      end
      return
    end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.bg, colors.light_gray, 'bold'},
    separator = '',
    separator_highlight = { colors.light_gray, colors.gray },
  }
}

gls.left[6] = {
  SlantUp = {
    provider = function ()
      return ''
    end,
    highlight = { colors.dark_gray, colors.gray },
  }
}

gls.left[7] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '   ',
    highlight = {colors.green,colors.dark_gray},
  }
}
gls.left[8] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' ',
    highlight = {colors.orange,colors.dark_gray},
  }
}
gls.left[9] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.light_red,colors.dark_gray},
  }
}

gls.left[10] = {
  FilePath = {
    provider = function ()
      local path = vim.fn.expand('%:p')
      if vim.fn.empty(path) == 1 then return '' end
      if string.len(file_readonly(icons.lock)) ~= 0 then
        return path .. file_readonly(icons.pencil)
      end
      if vim.bo.modifiable then
        if vim.bo.modified then
          return path .. ' ' .. icons.pencil .. '  '
        end
      end
      return path .. ' '
    end,
    condition = buffer_not_empty,
    highlight = hi_normal
  }
}

gls.mid[0] = {
  ShowLspClient = {
    provider = function ()
      return (vim.g.coc_status or '') .. (vim.b.coc_current_function or '')
    end,
    condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' LSP: ',
    highlight = {colors.cyan,colors.dark_gray,'bold'}
  }
}

gls.right[1] = {
  FileEncoding = {
    provider = function ()
      local encoding = vim.bo.fenc ~= '' and vim.bo.fenc or vim.o.enc
      local format = vim.bo.fileformat
      return format .. ' ' .. encoding .. ' '
    end,
    condition = buffer_not_empty,
    highlight = hi_normal
  }
}

gls.right[2] = {
  FileSize = {
    provider = 'FileSize',
    separator = ' ',
    condition = buffer_not_empty,
    highlight = hi_normal,
    separator_highlight = hi_separator
  }
}

gls.right[3] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.dark_gray},
  },
}

gls.right[4] = {
  FileType = {
    provider = function ()
      return vim.bo.filetype .. ' '
    end,
    condition = buffer_not_empty,
    highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.dark_gray }
  }
}

gls.right[5] = {
  SlantUpRev = {
    provider = function ()
      return ''
    end,
    highlight = { colors.gray, colors.dark_gray },
  }
}

gls.right[6] = {
  LineInfo = {
    provider = function ()
      local line = vim.fn.line('.')
      local column = vim.fn.col('.')
      return string.format(" %3d : %2d ", line, column)
    end,
    separator = '',
    separator_highlight = { colors.light_gray, colors.gray },
    highlight = hi_reversed,
  },
}

gls.right[7] = {
  SlantDownRev = {
    provider = function ()
      return ''
    end,
    highlight = { colors.light_gray, colors.gray },
  }
}

gls.right[8] = {
  PerCent = {
    provider = 'LinePercent',
    separator = '',
    separator_highlight = { colors.gray, colors.dark_gray },
    highlight = {colors.light_gray,colors.dark_gray,'bold'},
  }
}

gls.right[9] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = ' ',
    highlight = {colors.bg,colors.dark_red},
    separator = '',
    separator_highlight = { colors.dark_gray, colors.dark_red }
  }
}
gls.right[10] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = ' ',
    highlight = {colors.bg,colors.orange},
    separator = '',
    separator_highlight = { colors.dark_red, colors.orange }
  }
}

gls.right[11] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = ' ',
    highlight = {colors.info,colors.dark_gray},
    separator = '',
    separator_highlight = { colors.orange, colors.dark_gray }
  }
}

require('packer').startup(function (use)
  use 'wbthomason/packer.nvim'

  use '0x706b/monotone'

  use {
    'vim-airline/vim-airline',
    config = function ()
      vim.api.nvim_command('source ~/.config/nvim/config/airline.vim')
    end
  }

  use 'sainnhe/everforest'

  use 'vim-airline/vim-airline-themes'

  use {
    '0x706b/coc.nvim',
    branch = 'master',
    run = 'yarn install --frozen-lockfile',
    config = function ()
      vim.api.nvim_command('source ~/.config/nvim/config/coc.vim')
    end
  }

  use {
    'HerringtonDarkholme/yats.vim',
    config = function ()
      vim.g.yats_host_keyword = 0
    end
  }

  use 'othree/yajs.vim'
  use 'Quramy/vim-js-pretty-template'

  use {
    'Raimondi/delimitMate',
    config = function ()
      vim.g.delimitMate_expand_cr = 1
      vim.g.delimitMate_expand_space = 1
    end
  }

  use {
    'preservim/nerdcommenter',
    config = function ()
      vim.api.nvim_command('source ~/.config/nvim/config/nerdcommenter.vim')
    end
  }
  use 'ryanoasis/vim-devicons'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'

  use {
    'jdhao/better-escape.vim',
    config = function ()
      vim.g.better_escape_interval = 300
      vim.g.better_escape_shortcut = { 'jj' }
    end
  }

  use 'junegunn/fzf'

  use {
    'junegunn/fzf.vim',
    config = function ()
      vim.api.nvim_command('source ~/.config/nvim/config/fzf.vim')
    end
  }

  use 'antoinemadec/coc-fzf'

  use {
    'romgrk/barbar.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require'config.barbar'
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require'config.indent-blankline'
    end
  }

  use {
    'easymotion/vim-easymotion',
    config = function ()
      vim.api.nvim_command('source ~/.config/nvim/config/easymotion.vim')
    end
  }

  -- use {
  --   'neovim/nvim-lspconfig',
  --   config = function ()
  --     require 'config.lsp'
  --     require 'config.lspkind'.init()
  --   end
  -- }

  -- use {
  --   'hrsh7th/nvim-compe',
  --   config = function () require 'config.nvim_compe' end,
  --   requires = { {'hrsh7th/vim-vsnip', opt = true} }
  -- }

  -- use {
  --   'folke/trouble.nvim',
  --   requires = 'kyazdani42/nvim-web-devicons',
  --   config = function()
  --     require'config.trouble_'
  --   end
  -- }

  -- use {
  --   'creativenull/diagnosticls-configs-nvim',
  --   requires = { 'neovim/nvim-lspconfig' },
  --   config = function ()
  --     require 'config.diagnosticls'
  --   end
  -- }

  -- use {
  --   'nvim-lua/lsp-status.nvim',
  --   config = function ()
  --     require 'config.lsp_status'.activate()
  --   end
  -- }

  -- use 'ray-x/lsp_signature.nvim'

  -- use {
  --   'RishabhRD/nvim-lsputils',
  --   requires = { 'RishabhRD/popfix' },
  --   config = function ()
  --     require 'config.lsp_utils'
  --   end
  -- }

  -- use {
  --   'nvim-telescope/telescope.nvim',
  --   requires = { {'nvim-lua/plenary.nvim'} },
  --   config = function ()
  --     require 'config.telescope_'
  --   end
  -- }

end)

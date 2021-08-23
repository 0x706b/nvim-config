require('packer').startup(function ()
  use 'wbthomason/packer.nvim'

  use '0x706b/monotone'

  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  use {
    '0x706b/coc.nvim',
    branch = 'master',
    run = 'yarn install --frozen-lockfile',
    config = function ()
      vim.api.nvim_command('source ~/.config/nvim/plugins/coc.vim')
    end
  }

  use 'HerringtonDarkholme/yats.vim'
  use 'othree/yajs.vim'
  use 'Quramy/vim-js-pretty-template'

  use 'Raimondi/delimitMate'
  -- use 'Yggdroot/indentLine'
  use 'preservim/nerdcommenter'
  use 'ryanoasis/vim-devicons'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'jdhao/better-escape.vim'

  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'antoinemadec/coc-fzf'

  use {
    "romgrk/barbar.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require'config.barbar'
    end
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require'config.indent-blankline'
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
  --   "folke/trouble.nvim",
  --   requires = "kyazdani42/nvim-web-devicons",
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

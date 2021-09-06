local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

local packer = require 'packer'

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
    prompt_border = 'rounded'
  }
}

packer.startup(function (use)
  use 'wbthomason/packer.nvim'

  use '0x706b/monotone.nvim'
  use 'mcchrish/zenbones.nvim'
  use '0x706b/crumbling.nvim'

  use {
    'glepnir/galaxyline.nvim',
    config = function ()
      require 'config.galaxyline'
    end,
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use 'sainnhe/everforest'

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
  use 'MaxMEllon/vim-jsx-pretty'

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

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function ()
      require'config.gitsigns'
    end
  }

  use {
    'rktjmp/lush.nvim'
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = { 'nvim-treesitter/playground' },
    config = function ()
      require'config.treesitter'
    end
  }

end)

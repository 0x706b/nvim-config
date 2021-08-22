lua << EOF
require 'plugins'
EOF

source ~/.config/nvim/settings.vim
source ~/.config/nvim/mapping.vim
source ~/.config/nvim/colorschemes/monotone.vim

""" plugin configs

source ~/.config/nvim/plugins/easymotion.vim
source ~/.config/nvim/plugins/nerdcommenter.vim
source ~/.config/nvim/plugins/delimitmate.vim
source ~/.config/nvim/plugins/yats.vim
source ~/.config/nvim/plugins/easymotion.vim
source ~/.config/nvim/plugins/indentline.vim
source ~/.config/nvim/plugins/betterescape.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/hoogle.vim

" lua << EOF
" require 'mappings'.setup()
" EOF

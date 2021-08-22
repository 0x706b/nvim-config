set background=dark
let g:solarized_termtrans = 1
let g:solarized_statusline = 'flat'
let g:solarized_extra_hi_groups = 1

hi! link typescriptTypeReference Type
hi! link typescriptTypeParameter Type
hi! link typescriptArrowFunc Statement
hi! link typescriptParens Delimiter
hi! link typescriptBraces Delimiter

hi CocErrorHighlight guifg=NONE guibg=NONE guisp=#dc322f gui=undercurl
hi CocWarningHighlight guifg=NONE guibg=NONE guisp=#b58900 gui=undercurl
hi CocInfoHighlight guifg=NONE guibg=NONE guisp=#2aa198 gui=undercurl

colorscheme solarized8

let g:airline_solarized_dark_text = 1
let g:airline_solarized_dark_inactive_border = 1

let g:airline_theme='solarized'

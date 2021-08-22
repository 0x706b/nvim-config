augroup HoogleMaps
  autocmd!
  autocmd FileType haskell nnoremap <buffer> <leader>hh :Hoogle <c-r>=expand('<cword>')<CR><CR>
augroup END


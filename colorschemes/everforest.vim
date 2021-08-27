let g:everforest_background = 'hard'
let g:everforest_sign_column_background = 'none'

set background=dark

function! s:everforest_custom() abort
  let l:configuration = everforest#get_configuration()
  let l:palette = everforest#get_palette(l:configuration.background)
  " call everforest#highlight('Type', l:palette.yellow, l:palette.none, 'bold')
  call everforest#highlight('CursorLineNr', l:palette.grey2, l:palette.bg1)
  call everforest#highlight('typescriptCall', l:palette.fg, l:palette.none)
  call everforest#highlight('typescriptOperator', l:palette.orange, l:palette.none, 'bold')

  hi! link typescriptArrowFuncArg typescriptCall
  hi! link typescriptTypeBrackets Delimiter
  hi! link typescriptDotNotation Delimiter
  hi! link typescriptTypeAnnotation Delimiter
  hi! link typescriptBinaryOp typescriptOperator
  hi! link typescriptTernaryOp typescriptOperator
  hi! link typescriptTypeQuery typescriptOperator
  hi! link typescriptMappedIn typescriptOperator
  hi! link typescriptAssign typescriptOperator
  hi! link typescriptUnaryOp typescriptOperator
  hi! link typescriptBracket Delimiter
  hi! link typescriptPredefinedType Special
  hi! link typescriptTypeArguments Delimiter
  hi! link typescriptInterfaceName Type
  hi! link typescriptClassName Type
  hi! link typescriptAliasDeclaration Type
  hi! link typescriptNull Number
  hi! link typescriptBoolean Number
  hi! link tsxIntrinsicTagName Special
  hi! link tsxTagName Type
  hi! link tsxTag Delimiter
  hi! link tsxCloseTag Delimiter
  hi! link tsxCloseString Delimiter
  hi! link tsxAttrib Normal
  hi! link tsxEqual Delimiter
endfunction

let g:airline_theme='everforest'

colorscheme everforest

call s:everforest_custom()

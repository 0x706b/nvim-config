local z = require 'zenbones.colors'
local lushUtils = require 'util.lush'

local colors = {
  fg = z.stone,
  bg = z.sand,
  bg0 = z.sand.da(4),
  bg1 = z.sand.da(14),
  bg2 = z.sand.da(20),
  fg0 = z.stone.li(4),
  fg1 = z.stone.li(8),
  fg2 = z.stone.li(12),
  b = {
    red = z.rose,
    yellow = z.wood,
    blue = z.water
  },
  n = {
    yellow = z.wood,
    green = z.leaf,
    red = z.rose,
    blue = z.sky,
    magenta = z.blossom
  },
  git = {
    add = z.leaf,
    change = z.wood,
    delete = z.rose
  }
}

return lushUtils.lushToHex(colors)

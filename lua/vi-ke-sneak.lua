-- vi-ke for vim-sneak. Sneak needs to be added to your dependencies - https://github.com/justinmk/vim-sneak

-- Handle ; and , keys. Handoff to sneak when appropriate
local map = vim.api.nvim_set_keymap
map('n', ';',           "<cmd>lua require('vi-ke').ke0Sneak()<CR>",      {noremap = true})
map('n', ',',           "<cmd>lua require('vi-ke').ke0SneakUp()<CR>",    {noremap = true})
map('x', ';',           "<cmd>lua require('vi-ke').ke0Sneak()<CR>",      {noremap = true})
map('x', ',',           "<cmd>lua require('vi-ke').ke0SneakUp()<CR>",    {noremap = true})

-- Give Sneak a mapping so it doesn't sneakily steal the 's' and 'S' keys.
map('n', '<f99>',       "<Plug>Sneak_s",                                 {noremap = false})
map('n', '<f98>',       "<Plug>Sneak_S",                                 {noremap = false})

-- Case insensitive Sneak
vim.g['sneak#use_ic_scs'] = 1

-- need to know when these are being pressed, unless you are using the sneak versions
map('n', 'f',           "v:lua.ViKePress('f')",      {noremap = true, expr = true})
map('n', 'F',           "v:lua.ViKePress('F')",      {noremap = true, expr = true})
map('x', 'f',           "v:lua.ViKePress('f')",      {noremap = true, expr = true})
map('x', 'F',           "v:lua.ViKePress('F')",      {noremap = true, expr = true})

map('n', 't',           "v:lua.ViKePress('t')",      {noremap = true, expr = true})
map('n', 'T',           "v:lua.ViKePress('T')",      {noremap = true, expr = true})
map('x', 't',           "v:lua.ViKePress('t')",      {noremap = true, expr = true})
map('x', 'T',           "v:lua.ViKePress('T')",      {noremap = true, expr = true})

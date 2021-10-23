local map = vim.api.nvim_set_keymap
-- vi-ke for vim-sneak. Sneak needs to be added to your dependencies - https://github.com/justinmk/vim-sneak
-- Using the above keys will prime Sneak, so the next ; or , will activate it.
map('n', ';',           "<cmd>lua require('vi-ke').ke0Sneak()<CR>",      {noremap = true})
map('n', ',',           "<cmd>lua require('vi-ke').ke0SneakUp()<CR>",    {noremap = true})
map('x', ';',           "<cmd>lua require('vi-ke').ke0Sneak()<CR>",      {noremap = true})
map('x', ',',           "<cmd>lua require('vi-ke').ke0SneakUp()<CR>",    {noremap = true})
-- Give Sneak a mapping so it doesn't sneakily steal the 's' and 'S' keys.
-- map('n', '<f99>',       "<Plug>Sneak_s",                                 {noremap = false})
-- map('n', '<f98>',       "<Plug>Sneak_S",                                 {noremap = false})
-- Case insensitive Sneak
-- vim.g['sneak#use_ic_scs'] = 1

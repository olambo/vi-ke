-- Instead of a count indicating up or down a number of lines, it represents a partialLineNo
-- You supply the last two digits or last one digit.

local map = vim.api.nvim_set_keymap

-- If a partialLineNo is supplied, go to the next matching line. Otherwise scroll up or down by 10 lines.
-- Mapping <down> and <up> makes sense on my keyboard setup. Map the keys that make sense on yours.
map('n', '<down>',     "<cmd>lua require('vi-ke').keDown()<CR>",        {noremap = true})
map('n', '<up>',       "<cmd>lua require('vi-ke').keUp()<CR>",          {noremap = true})
map('x', '<down>',     "<cmd>lua require('vi-ke').keDown()<CR>",        {noremap = true})
map('x', '<up>',       "<cmd>lua require('vi-ke').keUp()<CR>",          {noremap = true})

-- Need to know when 0 is pressed. It still goes to the start of the line.
map('n', '0',          "<cmd>lua require('vi-ke').ke0()<CR>",           {noremap = true})
map('x', '0',          "<cmd>lua require('vi-ke').ke0()<CR>",           {noremap = true})

-- Optional
-- j and k keys. If a partialLineNo is supplied, go to the line. Otherwise works like original j and k.
map('n', 'j',           "<cmd>lua require('vi-ke').ke_j()<CR>",          {noremap = true})
map('n', 'k',           "<cmd>lua require('vi-ke').ke_k()<CR>",          {noremap = true})
map('x', 'j',           "<cmd>lua require('vi-ke').ke_j()<CR>",          {noremap = true})
map('x', 'k',           "<cmd>lua require('vi-ke').ke_k()<CR>",          {noremap = true})

-- Optional! 
-- vi-ke for vim-sneak. Sneak needs to be added to your dependencies - https://github.com/justinmk/vim-sneak
-- Using the above keys will prime Sneak, so the next ; or , will activate it.
map('n', ';',           "<cmd>lua require('vi-ke').ke0Sneak()<CR>",      {noremap = true})
map('n', ',',           "<cmd>lua require('vi-ke').ke0SneakUp()<CR>",    {noremap = true})
map('x', ';',           "<cmd>lua require('vi-ke').ke0Sneak()<CR>",      {noremap = true})
map('x', ',',           "<cmd>lua require('vi-ke').ke0SneakUp()<CR>",    {noremap = true})
-- Give Sneak a mapping so it doesn't sneakily steal the 's' and 'S' keys.
map('n', '<f99>',       "<Plug>Sneak_s",                                 {noremap = false})
-- Case insensitive Sneak
vim.g['sneak#use_ic_scs'] = 1

-- Optional! 
-- Typing v will go into visual mode. Typing vv from normal mode will activate line mode - mirroring cc, dd
-- {partialLineNo}v from normal mode will activate visual line mode and move to the line inidicated.
-- visual mode <-> visual line mode (toggle). 
map('n', 'v',          "<cmd>lua require('vi-ke').keVisual()<CR>",      {noremap = true})
map('x', 'v',          "<cmd>lua require('vi-ke').keVisual()<CR>",      {noremap = true})
-- {partialLineNo} visual block mode. I don't use <c-v>, but map it if you do.
map('n', '<leader>v',  "<cmd>lua require('vi-ke').keVisualBlock()<CR>", {noremap = true})
map('x', '<leader>v',  "<cmd>lua require('vi-ke').keVisualBlock()<CR>", {noremap = true})
-- Visual to end of line - mirroring C, D
map('n', 'V',          "v$h",                                           {noremap = true})
map('x', 'V',          "$h",                                            {noremap = true})


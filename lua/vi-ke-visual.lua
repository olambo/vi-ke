-- Instead of a count indicating up or down a number of lines, it represents a partialLineNo
-- You supply the last two digits or last one digit.

-- Typing v will go into visual mode. Typing vv from normal mode will activate line mode - mirroring cc, dd

local map = vim.api.nvim_set_keymap
-- {partialLineNo}v from normal mode will activate visual line mode and move to the line inidicated.
-- visual mode <-> visual line mode (toggle). 
map('n', 'v',          "<cmd>lua require('vi-ke').keVisual()<CR>",      {noremap = true})
map('x', 'v',          "<cmd>lua require('vi-ke').keVisual()<CR>",      {noremap = true})

-- {partialLineNo} visual block mode. I don't use <c-v>, but map it if you do.
map('n', '<leader>v',  "<cmd>lua require('vi-ke').keVisualBlock()<CR>", {noremap = true})
map('x', '<leader>v',  "<cmd>lua require('vi-ke').keVisualBlock()<CR>", {noremap = true})

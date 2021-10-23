-- Instead of a count indicating up or down a number of lines, it represents a partialLineNo
-- You supply the last two digits or last one digit.
local map = vim.api.nvim_set_keymap
-- Need to know when 0 is pressed. It still goes to the start of the line.
map('n', '0',          "<cmd>lua require('vi-ke').ke0()<CR>",           {noremap = true})
map('x', '0',          "<cmd>lua require('vi-ke').ke0()<CR>",           {noremap = true})

-- j and k keys. If a partialLineNo is supplied, go to the line.
map('n', 'j',           "<cmd>lua require('vi-ke').ke_j()<CR>",          {noremap = true})
map('n', 'k',           "<cmd>lua require('vi-ke').ke_k()<CR>",          {noremap = true})
map('x', 'j',           "<cmd>lua require('vi-ke').ke_j()<CR>",          {noremap = true})
map('x', 'k',           "<cmd>lua require('vi-ke').ke_k()<CR>",          {noremap = true})

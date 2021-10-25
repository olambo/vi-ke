-- Instead of a count indicating up or down a number of lines, it represents a partialLineNo
-- You supply the last two digits or last one digit.

-- j and k keys. If a partialLineNo is supplied, go to the line.
local map = vim.api.nvim_set_keymap
map('n', 'j',           "<cmd>lua require('vi-ke').ke_j()<CR>",          {noremap = true})
map('n', 'k',           "<cmd>lua require('vi-ke').ke_k()<CR>",          {noremap = true})
map('x', 'j',           "<cmd>lua require('vi-ke').ke_j()<CR>",          {noremap = true})
map('x', 'k',           "<cmd>lua require('vi-ke').ke_k()<CR>",          {noremap = true})

-- Need to know when 0 and l are pressed.
map('n', '0',           "v:lua.ViKePress('0')",      {noremap = true, expr = true})
map('x', '0',           "v:lua.ViKePress('0')",      {noremap = true, expr = true})
map('n', 'l',           "v:lua.ViKePress('l')",      {noremap = true, expr = true})
map('x', 'l',           "v:lua.ViKePress('l')",      {noremap = true, expr = true})



-- Instead of a count indicating up or down a number of lines, it represents a partialLineNo
-- You supply the last two digits or last one digit.

-- If a partialLineNo is supplied, go to the next matching line. Otherwise scroll up or down by 10 lines.
-- Mapping <down> and <up> makes sense on my keyboard setup. Map the keys that make sense on yours.
local map = vim.api.nvim_set_keymap
map('n', '<down>',     "<cmd>lua require('vi-ke').keDown()<CR>",        {noremap = true})
map('n', '<up>',       "<cmd>lua require('vi-ke').keUp()<CR>",          {noremap = true})
map('x', '<down>',     "<cmd>lua require('vi-ke').keDown()<CR>",        {noremap = true})
map('x', '<up>',       "<cmd>lua require('vi-ke').keUp()<CR>",          {noremap = true})

-- Need to know when 0 is pressed.
map('n', '0',           "v:lua.ViKePress('0')",      {noremap = true, expr = true})
map('x', '0',           "v:lua.ViKePress('0')",      {noremap = true, expr = true})

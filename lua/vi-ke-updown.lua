-- Instead of a count indicating up or down a number of lines, it represents a partialLineNo
-- You supply the last two digits or last one digit.
local map = vim.api.nvim_set_keymap
-- Need to know when 0 is pressed. It still goes to the start of the line.
map('n', '0',          "<cmd>lua require('vi-ke').ke0()<CR>",           {noremap = true})
map('x', '0',          "<cmd>lua require('vi-ke').ke0()<CR>",           {noremap = true})

-- If a partialLineNo is supplied, go to the next matching line. Otherwise scroll up or down by 10 lines.
-- Mapping <down> and <up> makes sense on my keyboard setup. Map the keys that make sense on yours.
map('n', '<down>',     "<cmd>lua require('vi-ke').keDown()<CR>",        {noremap = true})
map('n', '<up>',       "<cmd>lua require('vi-ke').keUp()<CR>",          {noremap = true})
map('x', '<down>',     "<cmd>lua require('vi-ke').keDown()<CR>",        {noremap = true})
map('x', '<up>',       "<cmd>lua require('vi-ke').keUp()<CR>",          {noremap = true})


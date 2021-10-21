 # VI-KE

## Summary
VI-KE for Neovim

VI-KE enables motion to a line displayed in your buffer by supplying the last two digits, or the last digit. It doesn't matter how big the line number is.

### Typing two digits 
For example, if you have a line that is below your cursor showing a line number 233, you type 33 and press the key mapped to keDown, to be taken to the line. If the line is above your cursor you press the key mapped to keUp. Typing just the last two digits of a line will take you directly to it, as long as it is displayed on your screen (and your screen doen't somehow display a plethora of lines).

### Typing one digit
If the line 235 is a few lines below the cursor, you can type 5 and press keDown to get to get to it. If the line 235 is at the bottom of the screen and your cursor is at the top, you can type 5 and then keDown to be taken to the line in a couple of keDown presses. 

## Dependencies

VI-KE is written in Lua and requires Neovim. The plugin works with VSCode Neovim.

### Install

For example, using Vim-Plug: <br/> 
Plug 'olambo/vi-ke'

### Keymappings (minimal)
```
local map = vim.api.nvim_set_keymap

-- If a partialLineNo is supplied, go to the next matching line. 
-- Otherwise scroll up or down by 10 lines.
-- Mapping <down> and <up> makes sense on my keyboard setup. 
-- Map the keys that make sense on yours.
map('n', '<down>',      "<cmd>lua require('vi-ke').keDown()<CR>",       {noremap = true})
map('n', '<up>',        "<cmd>lua require('vi-ke').keUp()<CR>",         {noremap = true})
map('x', '<down>',      "<cmd>lua require('vi-ke').keDown()<CR>",       {noremap = true})
map('x', '<up>',        "<cmd>lua require('vi-ke').keUp()<CR>",         {noremap = true})

-- Need to know when 0 is pressed. It still goes to the start of the line.
map('n', '0',           "<cmd>lua require('vi-ke').ke0()<CR>",          {noremap = true})
map('x', '0',           "<cmd>lua require('vi-ke').ke0()<CR>",          {noremap = true})
```
### Zeros
 
 * To go to the next line ending with zero, press 0 and then the movement key
 * To go to a line like 06, type 06 and then the movement key
 * to go to a line ending like 100 type 00 and then the movement key

### Maping j and k keys

This is very convenient, but the mapping is a break with standard Neovim functionality for j, k behavior with a count. 

### Interoperability with Vim-Sneak
VI-KE  works really nicely with Sneak without giving up the 's' key. 

Once you have navigated to your line simply pressing ';' will look forwards. Or ',' upwards. You have to install Sneak to use it https://github.com/justinmk/vim-sneak
 
### Enhancing Visual Mode

VI-KE can make visual mode easier to work with, allowing immediate selection of line mode to your desired line. This is a set of mappings that is also a break with standard Neovim functionality.

### Example mapping with Sneak, Visual mode and j and k keys
To try out the plugin using the example key mappings

 ```
:lua <<EOF
  require('vi-ke-example-keys')
EOF
```
*  Type a 1 or 2 digt number followed by j to go down to the next line ending with that number. Pressing j again will take you down just one line. Same with k, except upwards.
*  Type a number and then press the down arrow to go to the next matching line (or up arrow)
*  After typing a single digit and down arrow, if you are not at your destination press the down arrow again without a number
*  You will have to install Sneak to utilize ';' and ',' once you have reached your line
*  {partialLineNo}v selects down to that line in visual line mode
*  vv from normal mode takes you to visual line mode 
*  In visual mode v is a toggle to and from visual line mode
* V from normal mode selects to end of line
*  \<leader\>v selects visual block mode

### Relativity and relative line numbers

VI-KE works relative to absolute line numbers. Do not use this plugin with relative line numbers turned on (especially with the j and k keys mapped ;-)


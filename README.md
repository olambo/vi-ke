 # VI-KE

## Summary
VI-KE for Neovim

VI-KE enables motion to a line displayed in your buffer by supplying the last two digits, or the last digit. It doesn't matter how big the line number is.

### Typing two digits 
For example, if you have a line that is below your cursor showing a line number 233, you type 33 and press the key mapped to keDown, to be taken to the line. If the line is above your cursor you press the key mapped to keUp. Typing just the last two digits of a line will take you directly to it, as long as it is displayed on your screen (and your screen doen't somehow display a plethora of lines).

### Typing one digit
If the line 235 is a few lines below the cursor, you can type 5 and press keDown to get to get to it. If the line 235 is at the bottom of the screen and your cursor is at the top, you can type 5 and then keDown to be taken to the line in a couple of keDown presses. 

### Reasons for the plugin's existence

Relative line numbers are great, but some people have issues with lines constently moving and the fact they are not absolute. Without relative lines, typing 3052G can be a bit of a chore when you can see the line below you on the screen. 

Moving to the line could include guessing how many lines it is below you, using the mouse, using H L M keys or thrashing j and k. Or even using text search, which can be a bit of a mismatch when you just want to visually select down to the line.

This plugin attempts to give the convenience of Relative lines numbers to those who can't use them. I guess that rather than the lines being relative, VI-KE operates relatively to the lines displayed on the screen. If this is acceptible, a future enhancement could be to highlight the 20 single digits in the line numbers above and below the cursor to indicate you can type a single digit to get to them.

## Dependencies

VI-KE is written in Lua and requires Neovim. The plugin works with VSCode Neovim.

### Install

For example, using Vim-Plug: <br/> 
Plug 'olambo/vi-ke'

## Keymappings (minimal)
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

### Enhancing Visual Mode

VI-KE can make visual mode easier to work with, allowing immediate selection of line mode to your desired line. This is a set of mappings that is also a break with standard Neovim functionality.

### Interoperability with Vim-Sneak

Optional: If you install Sneak https://github.com/justinmk/vim-sneak and map the VI-KE Sneak keys.

## Example mapping with <down> and <up>, j and k keys, Visual mode and Sneak 
To try out the plugin using the example key mappings

 ```
:lua <<EOF
  require('vi-ke-example-keys')
EOF
```
*  Type a 1 or 2 digt number followed by j to go down to the next line ending with that number. Pressing j again will take you down just one line. Same with k, except upwards.
*  Type a number and then press the down arrow to go to the next matching line (or up arrow)
*  After typing a single digit and down arrow, if you are not at your destination press the down arrow again without a number
*  {partialLineNo}v selects down to that line in visual line mode
*  vv from normal mode takes you to visual line mode 
*  In visual mode v is a toggle to and from visual line mode
* V from normal mode selects to end of line
*  \<leader\>v selects visual block mode
*  If you have installed Sneak. Type 9j to got to the next line ending with 9. Then press the ; key. This will hand off to Sneak, which will ask for two characters to search forwards. Typing 0; or 0, will Sneak from the line you are curently on.

## Relativity and relative line numbers

VI-KE works relative to absolute line numbers. Do not use this plugin with relative line numbers turned on (especially with the j and k keys mapped ;-)


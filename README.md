 # VI-KE

## Summary
VI-KE for Neovim

VI-KE enables motion to a line displayed in your buffer by supplying the last two digits, or the last digit. It doesn't matter how big the line number is.

### Typing two digits 
For example, if you have a line that is below your cursor showing a line number 233, you type 33 and press the j key, to be taken to the line. If the line is above your cursor you press the k key. Typing just the last two digits of a line will take you directly to it, as long as it is displayed on your screen (and your screen doen't somehow display a plethora of lines).

### Typing one digit
If the line 235 is a few lines below the cursor, you can type 5 and press the j key to get to get to it. If the line 235 is at the bottom of the screen and your cursor is at the top, you can type 5 and then j several times to be taken to the line.

### Reasons for the plugin's existence

Relative line numbers are great, but some people have issues with lines constently moving and the fact they are not absolute. Without relative lines, typing 3052G can be a bit of a chore when you can see the line below you on the screen. 

Moving to a line below the cursor could include guessing how many lines there are to the one of interest and typeing {count}j, using the mouse, using H L M keys and/or thrashing j and k. Or even using text search, which can be a bit of a mismatch when you just want to visually select down to the line in visual line mode.

This plugin attempts to give the convenience of Relative lines numbers to those who can't use them. I guess that rather than the lines being relative, VI-KE operates relatively to the lines displayed on the screen. 

## Maping j and k keys

After you do a "one" dight line search via these keys, the j and k keys will move by 10 lines until you leave column 1. If you are on a line with no characters just press a movement key such as return to take you to another line, to resume navigating by 1 line.
This enables you to get to your target line as fast as possible. It's also quite useful for navigating the file quickly with just the j and k keys.

A two digit search will not move by 10 lines after the search. This is because you should have already arrived at your destination line.

If you are want to move by the old number of lines count, you have other movement keys that will navigate by {count} lines such as return and ctrl-j, ctrl-p

### Dependencies

VI-KE is written in Lua and requires Neovim. The plugin works with VSCode Neovim.

### Install

For example, using Vim-Plug: <br/> 
Plug 'olambo/vi-ke'

### Keymappings - minimal with j and k keys

```
:lua <<EOF
vim.api.nvim_command('autocmd ColorScheme * highlight ViKeHL ctermfg=brown guifg=orange')
require('vi-ke').keLight()
require('vi-ke-jk')
EOF
```

### Other considerations

### Relativity and relative line numbers

VI-KE works relative to absolute line numbers. Do not use this plugin with relative line numbers turned on (especially with the j and k keys mapped ;-)

### Zeros
 
 * To go to the next line ending with zero, press 0 and then the movement key
 * To go to a line like 06, type 06 and then the movement key
 * to go to a line ending like 100 type 00 and then the movement key

### Enhancing Visual Mode

VI-KE can make visual mode easier to work with, allowing immediate selection of line mode to your desired line. 

### Interoperability with Vim-Sneak

If you install Sneak https://github.com/justinmk/vim-sneak and require('vi-ke-sneak') .

### Keymappings - without j and k keys

If you dont want to map the j and k keys, you can map whatever keys you like to the keDown and keUp keys. The Full mapping example at the bottom of the page shows how to map these keys

### Example mapping with j and k keys, Visual mode, Sneak, arrow down and arrow up keys

To try out the plugin using the full example key mappings (shown at the bottom of the page). 

 ```
:lua <<EOF
  vim.api.nvim_command('autocmd ColorScheme * highlight ViKeHL ctermfg=brown guifg=orange')
  require('vi-ke').keLight()
  require('vi-ke-jk')
  require('vi-ke-sneak')
  require('vi-ke-visual')
  require('vi-ke-updown')
EOF
```
*  Type a 1 digt number followed by j to go down to the next line ending with that number. Pressing j again will take you down 10 lines. Move from the first column to resume moving by 1 line
*  Type a number and then press the down arrow to go to the next matching line (or up arrow)
*  After typing a single digit and down arrow, if you are not at your destination press the down arrow again without a number
*  {partialLineNo}v selects down to that line in visual line mode
*  vv from normal mode takes you to visual line mode 
*  In visual mode v is a toggle to and from visual line mode
* V from normal mode selects to end of line
*  \<leader\>v selects visual block mode
*  If you have installed Sneak. Type 9j to got to the next line ending with 9. Then press the ; key. This will hand off to Sneak, which will ask for two characters to search forwards. Typing 0; or 0, will Sneak from the line you are curently on.

### Full key mapping - if you want to make your own mappings

Note - it doesn't really make sense to change the j, k or 0 key mappings.

```
:lua <<EOF
-- add color to the 10 lines below the cursor to indicate which lines you can navigate to with 1 digit
vim.api.nvim_command('autocmd ColorScheme * highlight ViKeHL ctermfg=brown guifg=orange')
require('vi-ke').keLight()

local map = vim.api.nvim_set_keymap
-- j and k keys. If a partialLineNo is supplied, go to the line.
map('n', 'j',           "<cmd>lua require('vi-ke').ke_j()<CR>",          {noremap = true})
map('n', 'k',           "<cmd>lua require('vi-ke').ke_k()<CR>",          {noremap = true})
map('x', 'j',           "<cmd>lua require('vi-ke').ke_j()<CR>",          {noremap = true})
map('x', 'k',           "<cmd>lua require('vi-ke').ke_k()<CR>",          {noremap = true})

-- Need to know when 0 is pressed. It still goes to the start of the line.
map('n', '0',          "<cmd>lua require('vi-ke').ke0()<CR>",            {noremap = true})
map('x', '0',          "<cmd>lua require('vi-ke').ke0()<CR>",            {noremap = true})

-- Typing v will go into visual mode. Typing vv from normal mode will activate line mode - mirroring cc, dd
-- {partialLineNo}v from normal mode will activate visual line mode and move to the line inidicated.
-- visual mode <-> visual line mode (toggle). 
map('n', 'v',          "<cmd>lua require('vi-ke').keVisual()<CR>",       {noremap = true})
map('x', 'v',          "<cmd>lua require('vi-ke').keVisual()<CR>",       {noremap = true})
-- {partialLineNo} visual block mode. I don't use <c-v>, but map it if you do.
map('n', '<leader>v',  "<cmd>lua require('vi-ke').keVisualBlock()<CR>",  {noremap = true})
map('x', '<leader>v',  "<cmd>lua require('vi-ke').keVisualBlock()<CR>",  {noremap = true})
-- Visual to end of line - mirroring C, D
map('n', 'V',          "v$h",                                            {noremap = true})
map('x', 'V',          "$h",                                             {noremap = true})

-- vi-ke for vim-sneak.
map('n', ';',           "<cmd>lua require('vi-ke').ke0Sneak()<CR>",      {noremap = true})
map('n', ',',           "<cmd>lua require('vi-ke').ke0SneakUp()<CR>",    {noremap = true})
map('x', ';',           "<cmd>lua require('vi-ke').ke0Sneak()<CR>",      {noremap = true})
map('x', ',',           "<cmd>lua require('vi-ke').ke0SneakUp()<CR>",    {noremap = true})
-- Give Sneak a mapping so it doesn't sneakily steal the 's' and 'S' keys.
map('n', '<f99>',       "<Plug>Sneak_s",                                 {noremap = false})
-- Case insensitive Sneak
vim.g['sneak#use_ic_scs'] = 1

-- If a partialLineNo is supplied, go to the next matching line. Otherwise scroll up or down by 10 lines.
-- Mapping <down> and <up> makes sense on my keyboard setup. Map the keys that make sense on yours.
map('n', '<down>',     "<cmd>lua require('vi-ke').keDown()<CR>",         {noremap = true})
map('n', '<up>',       "<cmd>lua require('vi-ke').keUp()<CR>",           {noremap = true})
map('x', '<down>',     "<cmd>lua require('vi-ke').keDown()<CR>",         {noremap = true})
map('x', '<up>',       "<cmd>lua require('vi-ke').keUp()<CR>",           {noremap = true})
EOF

```

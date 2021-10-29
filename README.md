 # VI-KE

## Summary
VI-KE for Neovim

VI-KE enables motion to a line displayed in your buffer by supplying the last two digits, or the last digit. It doesn't matter how big the line number is.

### Typing two digits 
For example, if you have a line that is below your cursor showing a line number 233, you type 33 and press the j key, to be taken to the line. If the line is above your cursor you press the k key. Typing just the last two digits of a line will take you directly to it, as long as it is displayed on your screen (and your screen doen't somehow display a plethora of lines).

### Typing one digit
This is very convenient and fast. If the line 235 is a few lines below the cursor, you can type 5 and press the j key to get to get to it. If the line 235 is at the bottom of the screen and your cursor is at the top, you can type 5 and then j several times to be taken to the line.

### Reasons for the plugin's existence

Moving to a line below the cursor (especially in visual mode), means guessing how many lines there are to the one of interest and typing {count}j, using the mouse, using H L M keys and/or thrashing j and k. Navigating directly by typing something like 3052G can be a bit of a chore when you can see the line below you on the screen. 
As an alternative, using text search, can be a bit of a mismatch when you just want to visually select down to the line in visual line mode. 

Relative line mode, attempts to fix the above problems, but comes at a cost. Some people have issues with lines constently moving around. The fact they are not absolute is a problem when pair programming.

This plugin mirrors the convenience of relative lines numbers. I guess that rather than the lines being relative, VI-KE operates relatively to the lines displayed on the screen. 

In many instances, this plugin is faster and easier than using relative line numbers, because it alows just one digit to be pressed followed by the same movement key (one or more times).

## Maping j and k keys

After you do a "one" dight line search via these keys, the j and k keys will move by 10 lines until you leave column 1. This enables you to get to your target line as fast as possible. It's also quite useful for navigating the file quickly with just the j and k keys. I show it as turbo mode on my status line.

If you are on a line with no characters just press <esc>, l or a movement key to take you to another line, to resume navigating by 1 line.

A two digit search will not move by 10 lines after the search. This is because you should have already arrived at your destination line. 

If you are want to move by the old number of lines count, you have other movement keys that will navigate by {count} lines such as return and ctrl-j, ctrl-p

### Dependencies

VI-KE is written in Lua and requires Neovim.

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

Visual line mode is selected when providing a number which is probably what you want.
The keystrokes vv and V become consistent with other vim operators. 

* From normal mode vv will go into line mode mirroring cc, dd
* v inside visual mode toggles between visual and visual line mode
* V will select visual mode to the end of line
* From normal mode, {partialLineNo}v will select down to the line in visual line mode
* {partialLineNo}j inside visual mode will select down to the line in visual line mode
* `<leader>v` will select visual block mode. `<c-v>` will still also select visual block mode.

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
*  If you have installed Sneak. Type 9j to got to the next line ending with 9. Then press the ; key. This will hand off to Sneak, which will ask for two characters to search forwards. To start a new sneak press 'l' or any movement key. If you search using f, F, t, T you will need to move off the line or press '0' to resume sneaking

### Full key mapping - if you want to make your own mappings

These are available in the lua directory of this plugin.

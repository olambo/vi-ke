-- Move up or down a file utilizing partial line numbers. 
-- Type a single digit followed by a movement key to move to the row ending with that digit.
-- Type two digits followed by a movement key to move to the row ending with the two digits.

local keBounce
local ke0Cnt = 0
local jkLn = 0
local hiLn = 0

local function keDir(lnr, cnt, dir, zeroCnt) 
  if cnt >= 100 or cnt < 0 then
    print('v:count too big ' .. cnt .. ' set to 0')
    cnt = 0
  end

  local unit = 10
  if cnt >= 10 or zeroCnt > 1 or (cnt ~= 0 and zeroCnt > 0) then
    unit = 100
  end
  local roundedToUnit = math.floor(lnr/unit)*unit
  local l = roundedToUnit + cnt
  if dir == 1 and l < lnr then
    l = l + unit
  elseif dir == -1 and l > lnr then
    l = l - unit
  end
  local x = l
  if (l == lnr) then
    l = l + (unit*dir)
  end
  if l < 1 then
    l = 1
  end
  -- print("wantL unit roundedToUnit L nL:", cnt, unit, roundedToUnit, x, l, 'zeroCnt', zeroCnt)
  return l, unit
end

local function keUpOrDown(dir, isBlockMode)
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  local curln = vim.fn.line('.')
  local ln, unit
  if cnt == 0 and (col > 1 or ke0Cnt == 0) then
    ln = curln + (10 * dir)
    local lastln = vim.fn.line('$')
    if ln < 1 or ln > lastln then 
      if not keBounce and curln ~= 1 and curln ~= lastln then
        keBounce = curln
      end
      if ln < 1 then
        ln = 1
      elseif ln > lastln then
        ln = lastln
      end
    elseif keBounce then
      if ln < 12 or ln > lastln - 12  then
        ln = keBounce
      end
      keBounce = nil
    end
  else 
    keBounce = nil
    ln, unit = keDir(curln, cnt, dir, ke0Cnt)
  end
  ke0Cnt = 0
  local col1Cmd = '0'
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode
  local cv = vim.api.nvim_replace_termcodes('<c-v>',true,false,true)
  if mode == 'v' then 
    vim.api.nvim_feedkeys('V', 'n', false)
    col1Cmd = ''
  elseif mode == cv or isBlockMode or mode == 'V' then
    col1Cmd = ''
  elseif unit == 10 or jkLn ~= 0 then
    jkLn = ln
  end
  vim.api.nvim_feedkeys(col1Cmd .. ln .. 'G', 'n', false)
end

local function ke0()
  local col = vim.fn.col('.')
  ke0Cnt = ke0Cnt + 1
  vim.api.nvim_feedkeys('0', 'n', false)
  jkLn = 0
end

local function keDown()
  keUpOrDown(1)
  jkLn = 0
end

local function keUp()
  keUpOrDown(-1)
  jkLn = 0
end

local function keVisual()
  local cnt = vim.api.nvim_eval('v:count')
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode
  if (cnt == 0 and ke0Cnt == 0) or mode ~= 'n' then
    if mode == 'v' then 
      vim.api.nvim_feedkeys('V', 'n', false)
    else 
      vim.api.nvim_feedkeys('v', 'n', false)
    end
  else
    vim.api.nvim_feedkeys('V', 'n', false)
    keUpOrDown(1, true)
  end
end

local function keVisualBlock()
  local cnt = vim.api.nvim_eval('v:count')
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode
  local cv = vim.api.nvim_replace_termcodes('<c-v>',true,false,true)
  if mode ~= cv then
    vim.api.nvim_feedkeys(cv,'n',false)
  end
  if (cnt > 0 or ke0Cnt > 0) and mode == 'n' then
    keUpOrDown(1, true)
  elseif mode == 'n' then
    -- select an extra line to start
    vim.api.nvim_feedkeys('j','n',false)
  end
end

local function sneakCount()
  local cnt = vim.api.nvim_eval('v:count') 
  local sneakn = ''
  if cnt > 0 then
    sneakn = cnt
  end
  return sneakn
end

local function ke0Sneak()
  local col = vim.fn.col('.')
  if col == 1 then
    -- https://github.com/neovim/neovim/blob/b535575acdb037c35a9b688bc2d8adc2f3dece8d/src/nvim/keymap.h#L225
    ke0Cnt = 0
    vim.fn.feedkeys(string.format('%c%c%cSneak_s', 0x80, 253, 83))
  else 
    local sneakn = sneakCount()
    vim.fn.feedkeys(sneakn .. string.format('%c%c%cSneak_;', 0x80, 253, 83))
  end
end 

local function ke0SneakUp()
  local col = vim.fn.col('.')
  if col == 1 then
    ke0Cnt = 0
    vim.fn.feedkeys(string.format('%c%c%cSneak_S', 0x80, 253, 83))
  else 
    local sneakn = sneakCount()
    vim.fn.feedkeys(sneakn .. string.format('%c%c%cSneak_,', 0x80, 253, 83))
  end
end

local function ke_j()
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  if cnt > 0 or (col == 1 and ke0Cnt > 0) or (col == 1 and jkLn == vim.fn.line('.')) then
    keUpOrDown(1)
  else
    vim.api.nvim_feedkeys('gj', 'n', false)
    jkLn = 0
  end
end

local function ke_k()
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  if cnt > 0 or (col == 1 and ke0Cnt > 0) or (col == 1 and jkLn == vim.fn.line('.')) then
    keUpOrDown(-1)
  else
    vim.api.nvim_feedkeys('gk', 'n', false)
    jkLn = 0
  end
end

local function keLightLines(ckLn)
  local ln = vim.fn.line('.')
  if ckLn and hiLn == ln then
    return
  end
  vim.api.nvim_command('sign unplace 2 group=*')
  local a = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
  for i = 1,11 do
    vim.api.nvim_command('sign place 2 name=ViKeHL line=' .. ln + a[i])
  end
  hiLn = ln
end

local function keLight()
  vim.api.nvim_command('sign define ViKeHL numhl=ViKeHL')
  
  vim.api.nvim_command('augroup ViKeHL_grp')
  vim.api.nvim_command('au!')
  vim.api.nvim_command("autocmd CursorMoved * lua require('vi-ke').keLightLines(true)")
  vim.api.nvim_command("autocmd InsertEnter,InsertLeave,BufEnter * lua require('vi-ke').keLightLines(false)")
  vim.api.nvim_command('augroup END')
end

local function status()
  print("Status is ok")
end

return {
  ke0 = ke0,
  keDown = keDown,
  keUp = keUp,
  ke0Sneak = ke0Sneak,
  ke0SneakUp = ke0SneakUp,
  keVisual = keVisual,
  keVisualBlock = keVisualBlock,
  ke_j = ke_j,
  ke_k = ke_k,
  keLightLines = keLightLines,
  keLight = keLight,
  status = status,
}

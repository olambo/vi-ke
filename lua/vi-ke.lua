-- Move up or down a file utilizing partial line numbers. 
-- Type a single digit followed by a movement key to move to the row ending with that digit.
-- Type two digits followed by a movement key to move to the row ending with the two digits.

local keBounce
local ke0Cnt = 0
local ke0Col = 1
local jkLn = 0
local hiLn = 0
local cv = vim.api.nvim_replace_termcodes('<c-v>',true,false,true)
local esc = vim.api.nvim_replace_termcodes('<esc>',true,false,true)
local isFfTt = true

local function keDir(lnr, cnt, dir, zeroCnt) 
  if cnt >= 100 or cnt < 0 then
    -- print('v:count too big ' .. cnt .. ' set to 0')
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

local function kePreCol(ke0Cnt, ke0Col)
  if (ke0Cnt > 0) and (ke0Col > 1) then
    return ke0Col .. 'l'
  else 
    return ''
  end
end

local function kePostCol(mode, unit, keepPostcol)
  if (mode == cv) or (unit == 100) or keepPostcol then
    return ''
  else
    return '0'
  end
end

local function keCalcBounce(keBounce, curln, ln, lastln) 
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
  return keBounce, ln
end

local function keUpOrDown(dir, keepPostcol)
  isFfTt = false
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  local curln = vim.fn.line('.')
  local ln, unit
  if cnt == 0 and (col > 1 or ke0Cnt == 0) then
    local lastln = vim.fn.line('$')
    ln = curln + (10 * dir)
    keBounce, ln = keCalcBounce(keBounce, curln, ln, lastln)
  else 
    keBounce = nil
    ln, unit = keDir(curln, cnt, dir, ke0Cnt)
  end

  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode
  local chMode = ''
  if mode == 'v' then 
    chMode = 'V'
  end
  if unit == 10 or jkLn ~= 0 then
    jkLn = ln
  end

  local cmd = kePreCol(ke0Cnt, ke0Col) .. chMode .. ln .. 'G' .. kePostCol(mode, unit, keepPostcol)
  vim.api.nvim_feedkeys(cmd, 'n', false)
  ke0Cnt = 0
  ke0Col = 1
end

local function keZero()
  isFfTt = false
  local col = vim.fn.col('.')
  if col > 1 then
    ke0Col = col
  end
  ke0Cnt = ke0Cnt + 1
  -- vim.api.nvim_feedkeys('0', 'n', false)
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
    keUpOrDown(1)
  end
end

local function keVisualBlock()
  local cnt = vim.api.nvim_eval('v:count')
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode
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

_G.ViKePress = function(k)
  if k == 'f' or k == 'F' or k == 't' or k == 'T' then isFfTt = true 
  elseif k == 'l' or k == 'h' or k == esc then jkLn = 0 
  elseif k == '0' then keZero() 
  end
  return k
end

_G.ViKeTurbo = function(setStatus)
  if jkLn ~= 0 and setStatus == "off" then jkLn = 0 end
  return jkLn ~= 0
end

local function sneakCount()
  local cnt = vim.api.nvim_eval('v:count') 
  local sneakn = ''
  if cnt > 0 then sneakn = cnt end
  return sneakn
end

local function newSneakOk(col)
  if isFfTt then
    if col == 1 then return true end
    return false
  end
  local sn = vim.fn['sneak#is_sneaking']()
  return sn ~= 1
end

-- https://github.com/neovim/neovim/blob/b535575acdb037c35a9b688bc2d8adc2f3dece8d/src/nvim/keymap.h#L225
local function ke0Sneak()
  local col = vim.fn.col('.')
  if newSneakOk(col) then
    ke0Cnt = 0
    ke0Col = 1
    isFfTt = false
    vim.fn.feedkeys(string.format('%c%c%cSneak_s', 0x80, 253, 83))
  elseif isFfTt then
    vim.api.nvim_feedkeys(';','n',false)
  else 
    local sneakn = sneakCount()
    vim.fn.feedkeys(sneakn .. string.format('%c%c%cSneak_;', 0x80, 253, 83))
  end
end 

local function ke0SneakUp()
  local col = vim.fn.col('.')
  if newSneakOk(col) then
    ke0Cnt = 0
    ke0Col = 1
    isFfTt = false
    vim.fn.feedkeys(string.format('%c%c%cSneak_S', 0x80, 253, 83))
  elseif isFfTt then
    vim.api.nvim_feedkeys(',','n',false)
  else 
    local sneakn = sneakCount()
    vim.fn.feedkeys(sneakn .. string.format('%c%c%cSneak_,', 0x80, 253, 83))
  end
end

local function ke_j()
  isFfTt = false
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  if cnt > 0 or (col == 1 and ke0Cnt > 0) or (col == 1 and jkLn == vim.fn.line('.')) then
    if cnt > 0 then 
      jkLn = 0
    end
    keUpOrDown(1)
  else
    vim.api.nvim_feedkeys('gj', 'n', false)
    jkLn = 0
  end
end

local function ke_k()
  isFfTt = false
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  if cnt > 0 or (col == 1 and ke0Cnt > 0) or (col == 1 and jkLn == vim.fn.line('.')) then
    if cnt > 0 then 
      jkLn = 0
    end
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

local function keStatus()
  print("VI-KE status is ok")
end

return {
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
  keStatus = keStatus,
}

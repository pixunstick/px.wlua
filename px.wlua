local iup = require "iuplua"

local cr

local function quit()
  --be a responsible citizen and don't pollute the tray
  cr.tray = "NO"
  iup.ExitLoop()
end

local cv = iup.canvas{
  bgcolor="0 0 0",
  rastersize="5x5",
  cursor="CROSS",
  border="NO"}

local cm = iup.menu{
  iup.item{
    title="Close",
    action=quit
  }
}

local bp = iup.imagergb{width=1, height=1, pixels = {0, 0, 0}}

local flicker = true

local tr = iup.timer{time=10,run="yes",
  action_cb=function(self)
    if flicker then
      cv.bgcolor="255 0 0"
      flicker=false
      --iup.Refresh(cv)
    else
      cv.bgcolor="0 0 0"
      flicker=true
      --iup.Refresh(cv)
    end
  end
}

cr = iup.dialog{
  TOPMOST="YES",
  BORDER="NO", MAXBOX="NO",
  MINBOX="NO", MENUBOX="NO",
  RESIZE="NO", TRAY="YES",
  TRAYIMAGE = bp;
  cv}

function cv:button_cb(b, pressed, x, y)
  --if left or right clicked
  if b == iup.BUTTON3
    and pressed == 1 then
    cm:popup(iup.MOUSEPOS, iup.MOUSEPOS)
  elseif b == iup.BUTTON1 then
    if pressed == 1 then
      self.cursor="NONE"
    else
      self.cursor="CROSS"
    end
  end
end

local movelock
function cv:motion_cb(x, y, status)
  if iup.isbutton1(status) and not movelock then
    cr:showxy(iup.MOUSEPOS, iup.MOUSEPOS)
  end
end

function cr:show_cb(state)
  if state==iup.HIDE then
    quit()
  end
end

function cr:trayclick_cb(b, press, dclick)
  --if left or right clicked
  if (b == 1 or b == 3) and press then
    cm:popup(iup.MOUSEPOS, iup.MOUSEPOS)
  end
  return iup.DEFAULT
end

cr:show()

iup.MainLoop()

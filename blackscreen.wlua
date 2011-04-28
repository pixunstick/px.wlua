local iup = require "iuplua"

local blk = iup.canvas{bgcolor="0 0 0"}

local vsx, vsy, vsw, vsh = string.match(
  iup.GetGlobal"VIRTUALSCREEN",
  "^(%-?%d*) (%-?%d*) (%-?%d*) (%-?%d*)$")

local dlg = iup.dialog{
  TOPMOST="YES",
  MAXBOX="NO", MINBOX="NO",
  MENUBOX="NO",
  RESIZE="NO",
  BORDER="NO",
  shrink="yes",
  rastersize=string.format("%dx%d",vsw,vsh);
  blk}

function blk:button_cb()
  iup.ExitLoop()
end

dlg:showxy(vsx, vsy)

iup.MainLoop()

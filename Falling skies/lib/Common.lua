
VERSION = "1.0"

SH = 480
SW = 320

BG_SH = 570
BG_SW = 380

MIDDLE_WIDTH = SW / 2
MIDDLE_HEIGHT = SH / 2

SW_VIEW_ORIGIN = display.screenOriginX
SH_VIEW_ORIGIN = display.screenOriginY

SW_VIEW = SW; if SW_VIEW_ORIGIN < 0 then SW_VIEW = SW + ( SW_VIEW_ORIGIN * -1 ) end
SH_VIEW = SH; if SH_VIEW_ORIGIN < 0 then SH_VIEW = SH + ( SH_VIEW_ORIGIN * -1 ) end

FONT_NORMAL = native.systemFont
FONT_BOLD = native.systemFontBold

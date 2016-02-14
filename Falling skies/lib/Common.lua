
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

function roundToNthDecimal(num, n)
  local mult = 10^(n or 0)
  return math.floor(num * mult + 0.5) / mult
end

function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end


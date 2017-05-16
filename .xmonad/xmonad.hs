import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.Tabbed
import System.IO

import XMonad.Layout.NoBorders (smartBorders)
import qualified XMonad.Layout.BinarySpacePartition as BSP
import qualified XMonad.Layout.Spacing as S

myManageHook = composeAll [
    className =? "trayer" --> doFloat
    , manageDocks
    ]

myTerminal = "termite"

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ def {
        terminal = myTerminal
        , manageHook = myManageHook
        , layoutHook = myLayout
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor "Green" "" . shorten 50
            }
        , handleEventHook = mconcat [ docksEventHook
                                    , handleEventHook def ]
        , modMask = mod4Mask 
        } `additionalKeys`
        [ 
        ((mod4Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock") 
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s") 
        , ((0, xK_Print), spawn "scrot") 
        , ((mod1Mask .|. shiftMask, xK_z), spawn "setxkbmap -layout us")
        , ((mod1Mask .|. shiftMask, xK_x), spawn "setxkbmap -layout latam")
        , ((mod4Mask .|. shiftMask, xK_p), spawn "/home/santiago/.xmonad/notify-color.sh")

        -- function keys, sleep, etc.
        , ((0, xF86XK_AudioLowerVolume) , spawn "pamixer -d 3")
        , ((0, xF86XK_AudioRaiseVolume) , spawn "pamixer -i 3")
        , ((0, xF86XK_AudioMute), spawn "pamixer -t")
        , ((mod4Mask .|. shiftMask, xK_s), spawn "/home/santiago/.xmonad/sleep")
        , ((0, xF86XK_MonBrightnessUp), spawn "/home/santiago/.xmonad/raise_brightness")
        , ((0, xF86XK_MonBrightnessDown), spawn "/home/santiago/.xmonad/lower_brightness")
        ]

myLayout = avoidStruts(S.spacing 1 $ (
                Full |||
                Tall 1 (3/100) (1/2) |||
                Mirror (Tall 1 (3/100) (1/2))
                )
            )

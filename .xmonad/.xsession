#!/bin/bash
# My custom xsession script. Thanks to John Goerzen for making all of this possible
# load resources

xrdb -merge .Xresources

# setup dual screen
xrandr --output eDP1 --primary
xrandr --output HDMI1 --auto --right-of eDP1


# autolock after 10 mintutes (requires xautolock)(
xautolock -time 10 -locker "pm action suspend" & 

# fire up apps
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
     --expand true --width 10 --transparent true --tint 0x191970 --height 18 &

if [ -x /usr/bin/nm-applet ] ; then
    #    nm-applet --sm-disable &
    wicd-gtk -t &
fi

# setup compositing (requires installing xcompmgr)
xcompmgr &

# set battery daemon (for notification)
fdpowerdaemon &

# feh will set our background image (requires feh)
feh --bg-fill /home/santiago/Documents/Backgrounds/bg.jpg

# start xscreensaver
xscreensaver -no-splash &

# diable the mouse when typing
syndaemon -i .8 -d -t

# everyything else will be managed by xmonad :)
exec xmonad

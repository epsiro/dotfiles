#!/bin/sh
# Load resources
#xrdb -merge .Xresources

# Set up an icon tray
#trayer --edge top --align right --SetDockType true --SetPartialStrut true \
# --expand true --width 5 --transparent true --alpha 255 --tint 0x000000 --height 12 &

# Set the background color
#xsetroot -solid \#2e3436
xsetroot -solid \#000000

# Fire up apps
gnome-appearance-properties &
xscreensaver -no-splash &
nm-applet --sm-disable &
gnome-power-manager &
sleep 2; killall gnome-appearance-properties
#exec xmonad

# Load font (Terminus)
#xset +fp /usr/share/fonts/local &
#xset +fp /usr/share/fonts/cureextra &
xset +fp /usr/share/fonts/epsiro-einfach &
xset fp rehash &

# Set statusbar
while xsetroot -name "`~/Dropbox/config/scripts/dwm-status`"; do
    sleep 10
done &

# Start DWM
exec $HOME/Dropbox/config/scripts/dwm-start

#exec dwm

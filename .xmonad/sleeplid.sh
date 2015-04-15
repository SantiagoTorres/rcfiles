#!/bin/bash

# custom wrapper for the lid button under xmonad and acpi in general
# I wanted my computer to go to sleep if I closed the lid. 
#
# To use:
#   replace the action event under /etc/acpi/events/lidbtn 
#   from: action=/etc/acpi/lid.sh
#   to:   action=/path/to/this/script
#
#   If the paths of the original scripts change, change the location of the sleep.sh
#   script inside the if

# check the state of the lid for a closed state
grep -q closed /proc/acpi/button/lid/*/state

# if we are actually closed...
if [ $? = 0 ] 
then
    # lock and go to sleep
    xscreensaver-command -lock
    /etc/acpi/sleep.sh
fi


#!/bin/bash

TOGGLE=/home/santiago/.xmonad/mute

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    pactl set-sink-mute 0 0
else
    rm $TOGGLE
    pactl set-sink-mute 0 1
fi

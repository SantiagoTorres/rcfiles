#!/bin/bash

echo "sleeping $(date)" >> ~/.xmonad/sleep.log
xscreensaver-command -lock
pm-suspend 2>&1> sleep.err
echo "waking up..." >> ~/.xmonad/sleep.log

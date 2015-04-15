#!/usr/bin/env python
import sys

BRIGHTNESS_STEP=10
BRIGHTNESS_MAX=100
BRIGHTNESS_MIN=0

# this function raises brightness of the screen
def raise_brightness():
    with open("/sys/class/backlight/acpi_video1/brightness","rw+") as fp:
        current_brightness = fp.read()
        current_brightness = current_brightness.strip()

        # if this goes wrong, then we are reading the wrong file
        int_brightness = int(current_brightness)
        int_brightness += BRIGHTNESS_STEP
        
        if int_brightness > BRIGHTNESS_MAX:
            int_brightness = BRIGHTNESS_MAX

        fp.seek(0)
        fp.write("{}".format(int_brightness))
        
def lower_brightness():
    with open("/sys/class/backlight/acpi_video1/brightness","rw+") as fp:
        current_brightness = fp.read()
        current_brightness = current_brightness.strip()

        # if this goes wrong, then we are reading the wrong file
        int_brightness = int(current_brightness)
        int_brightness -= BRIGHTNESS_STEP
        
        if int_brightness < BRIGHTNESS_MIN:
            int_brightness = BRIGHTNESS_MIN

        fp.seek(0)
        fp.write("{}".format(int_brightness))
     

if __name__ == '__main__':
    if sys.argv[1] == '+':
        raise_brightness()

    elif sys.argv[1] == '-':
        lower_brightness()

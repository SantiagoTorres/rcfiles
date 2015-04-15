#include <stdio.h>


int main() {
    // we are root now
    setuid(0);

    // lets go to sleep
    system("python /home/santiago/.xmonad/brightness_adjust.py -");
    return 0;
}

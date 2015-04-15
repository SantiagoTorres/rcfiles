#include <stdio.h>


int main() {
    // we are root now
    setuid(0);

    // lets go to sleep
    system("/bin/bash /home/santiago/.xmonad/sleep.sh");
    return 0;
}

#include "gbdk_headers.h"

#include "title_screen.h"
#include "save_room.h"

void main(void) {
    SHOW_SPRITES;
    SHOW_BKG;
    DISPLAY_ON;
    titleScreen();
    saveRoom();
}
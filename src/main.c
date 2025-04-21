// GBDK
#include "../Tools/GBDK/include/gb/gb.h"
#include "../Tools/GBDK/include/gb/drawing.h"

// Player character
#include "../res/goofy_guy.c"

// title_screen.c
#include "title_screen.c"

// save_room.c
#include "save_room.c"


void main(void) {

    SHOW_SPRITES;
    SHOW_BKG;
    DISPLAY_ON;
    titleScreen();
    saveRoom();

}
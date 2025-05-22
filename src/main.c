#include "gbdk_headers.h"
#include "title_screen.h"
#include "save_room.h"
#include "player.h"


void main(void) {    
    SHOW_SPRITES;
    SHOW_BKG;
    DISPLAY_ON;    
    SHOW_WIN;
    //titleScreen();
    saveRoom();
}

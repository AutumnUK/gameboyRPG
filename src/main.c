#include "headers.h"
#include "title_screen.h"
#include "save_room.h"
#include "player.h"
#include "../res/test_tiles.c"
void main(void) {    
    SHOW_SPRITES;
    SHOW_BKG;
    DISPLAY_ON;    
    set_bkg_data(0,4,TestTiles);
    for (int i = 0; i < 20; i++ ){
    set_bkg_tiles(i,0,1,1,&TestTiles[i]);
    }

    //titleScreen();
    //saveRoom();
}

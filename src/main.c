#include "headers.h"
#include "title_screen.h"
#include "save_room.h"
#include "player.h"
#include "../res/test_tiles.c"

void clear(void) {
    
    for (int i = 0; i < 18; i++) {
        for (int j = 0; j < 20; j++) {
            set_bkg_tile_xy(j,i,0);
        }

    }


}

void main(void) {    
    SHOW_SPRITES;
    SHOW_BKG;
    DISPLAY_ON;    
    set_bkg_data(0,4,TestTiles);
    clear();
    for (int i = 0; i < 20; i++ ){
    set_bkg_tile_xy(i,0,2);
    }
    //saveRoom();
}

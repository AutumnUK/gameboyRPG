#include "headers.h"

// Map and Tile Data
#include "../res/maps/title_screen_map.c"
#include "../res/maps/title_screen_tiles.c"

void titleScreen(void) {
    set_bkg_data(0,80,TitleScreenTiles);      
    set_bkg_tiles(0,0,20,18,TitleScreenMap);
    while(joypad() != J_START) { vsync(); }
}
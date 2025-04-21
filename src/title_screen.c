#include "../res/title_screen_map.c"
#include "../res/title_screen_tiles.c"

// TODO
// Add music.
void titleScreen(void) {
    set_bkg_data(0,80,TitleScreenTiles);
    set_bkg_tiles(0,0,20,18,TitleScreenMap);

    while(1) {
        vsync();
        if (joypad() == J_START) { 
            break; 
        }
    }
}
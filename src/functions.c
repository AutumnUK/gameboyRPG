#include    "../Tools/GBDK/include/gb/gb.h"

void clear(void) {
    for (int i = 0; i < 18; i++) {
        for (int j = 0; j < 20; j++) {
            set_bkg_tile_xy(j,i,0);
        }
    }
}

void systemSetup(void) {
    clear();
    SHOW_SPRITES;
    SHOW_BKG;
    DISPLAY_ON;

}
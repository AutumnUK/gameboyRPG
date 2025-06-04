#include    "headers.h"
#include    "../res/save_room_map.c"
#include    "../res/save_room_tiles.c"

uint8_t     stepsNeeded     = 10;

void drawRoom( void ) {
    set_bkg_data(96,80,SaveRoomTiles);
    set_bkg_tiles(0,0,20,18,SaveRoomMap);
    //redo this tomorrow
}

void saveRoom(void) {
    gotogxy(0,0);
    gprintf(" ");

    uint8_t     state           = 1;
    Player      player;

    playerSpawn(&player, 40, 80);
         
    while (state = 1) {   
        vsync();

        if ( player.steps > stepsNeeded) {

            //Spawn Slime
            Enemy slime = {
                // Needs to draw the sprite.
                .name       = "SLIME",
                .hp         = 5,
                .max_hp     = 5,
                .speed      = 2,
                .attack     = 2,
                .defence    = 2,
                .xp         = 2
            };
            battle(&player , &slime);
            SHOW_SPRITES;
        }

        if ( joypad() & J_SELECT ) {
            pause_init(&player);
        }

        handlePlayerInput(&player);
        updatePlayerPosition(&player);
        movePlayerSprites(&player);

    }
}

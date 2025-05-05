#include "gbdk_headers.h"

#include "../res/save_room_map.c"
#include "../res/save_room_tiles.c"

#include "player.h"

// TODO
// Add collision
// Add interaction (PC with menu)
// Add pause menu?
// More later
void saveRoom(void) {
    Player player;
    playerSpawn(&player, 40, 80);

    set_bkg_data(0, 80, SaveRoomTiles);
    set_bkg_tiles(0, 0, 20, 18, SaveRoomMap);

    while (1) {
        handlePlayerInput(&player);
        updatePlayerPosition(&player);
        movePlayerSprites(&player);
        vsync();
    }
}
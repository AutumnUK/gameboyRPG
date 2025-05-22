#include "gbdk_headers.h"
#include "player.h"
#include "testament_lib.h"
#include "battle.h"
#include "pause.h"

uint16_t    battle_timer    = 0;

void saveRoom(void) {
    
    uint8_t     state           = 1;

    Player player;
    playerSpawn(&player, 40, 80);
         
    while (state == 1) {   
        vsync();
        battle_timer ++;

        if ( battle_timer == 600 ) {
            battle(&player);
            battle_timer = 0;
        }

        if ( joypad() & J_SELECT ) {
            pause_init(&player);
        }

        handlePlayerInput(&player);
        updatePlayerPosition(&player);
        movePlayerSprites(&player);

    }
}

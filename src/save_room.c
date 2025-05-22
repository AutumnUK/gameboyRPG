#include "gbdk_headers.h"
#include "player.h"
#include "testament_lib.h"
#include "battle.h"

uint8_t     states          = 1;
uint16_t    battle_timer    = 0;

void saveRoom(void) {
    Player player;
    playerSpawn(&player, 40, 80);
         
    while (1) {   
        vsync();
        battle_timer ++;

        if ( battle_timer == 600 ) {
            battle(&player);
            battle_timer = 0;
        }
        
        handlePlayerInput(&player);
        updatePlayerPosition(&player);
        movePlayerSprites(&player);

    }


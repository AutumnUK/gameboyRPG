#include    "headers.h"

uint16_t    battle_timer    = 0;



void saveRoom(void) {

    Enemy slime = {
        .name = "SLIME",
        .hp = 5,
        .max_hp = 5,
        .speed = 2,
        .attack = 2,
        .defence = 2,
        .xp = 2
    };
    
    uint8_t     state           = 1;

    Player player;
    playerSpawn(&player, 40, 80);
         
    while (state = 1) {   
        vsync();
        battle_timer ++;

        if ( battle_timer == 600 ) {            
            battle(&player , &slime);
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

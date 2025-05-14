#include    "gbdk_headers.h"
#include    "player.h"
#include    "../res/goofy_guy.c"
#include    "../res/save_room_map.h"

#define     TILE_FLOOR      0x0C // Floor tile.
#define     MOVE_DISTANCE   16

void playerSpawn(Player* player, int x, int y) {
    player -> x             = x;
    player -> y             = y;
    player -> is_moving     = 0;
    player -> direction     = 0;
    player -> move_progress = 0;
    player -> player_hp     = 20;
    player -> player_speed  = 5;
    player -> player_atk    = 1;

    set_sprite_data(0, 4, GoofyGuy);  // Load sprite tile data
    set_sprite_tile(0, 0);
    set_sprite_tile(1, 1);
    set_sprite_tile(2, 2);
    set_sprite_tile(3, 3);
}

uint8_t getTileAt(uint8_t x, uint8_t y) {
    uint16_t tileIndex = ( y / 8 ) * 20 + ( x / 8);
    gotogxy(0,0);
    gprintf("%d", SaveRoomMap[tileIndex]);
    return 1;
}

// Handle input for movement
void handlePlayerInput(Player* player) {
    if (player->is_moving == 0) {
        switch (joypad()) {
            case J_UP:      player->is_moving = 1; player->direction = 0; break;
            case J_DOWN:    player->is_moving = 1; player->direction = 1; break;
            case J_LEFT:    player->is_moving = 1; player->direction = 2; break;
            case J_RIGHT:   player->is_moving = 1; player->direction = 3; break;
        }
    }
}

// Update player position based on direction
void updatePlayerPosition(Player* player) {
    if (player->is_moving) {
        switch (player->direction) {
            case 0: player->y--; break;
            case 1: player->y++; break;
            case 2: player->x--; break;
            case 3: player->x++; break;
        }

        player->move_progress++;
        if (player->move_progress == MOVE_DISTANCE) {
            player->move_progress = 0;
            player->is_moving = 0;
            getTileAt(player->x,player->y);
        }
    }
}


// Move the player sprites on the screen
void movePlayerSprites(Player* player) {
    move_sprite(0, player->x, player->y);
    move_sprite(1, player->x, player->y + 8);
    move_sprite(2, player->x + 8, player->y);
    move_sprite(3, player->x + 8, player->y + 8);
    
}

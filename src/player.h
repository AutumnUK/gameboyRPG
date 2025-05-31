#ifndef PLAYER_H
#define PLAYER_H

typedef struct {
    uint8_t     x;             
    uint8_t     y;          
    uint8_t     direction;         
    uint8_t     is_moving;          
    uint8_t     move_progress;      
    uint16_t    player_hp;
    uint8_t     player_speed;
    uint8_t     player_atk;
    uint8_t     level;
    uint16_t    xp;
    uint16_t    xp_for_level;
    uint16_t    player_max_hp;
    uint8_t     defence;
    uint8_t     steps;

} Player;

void        handlePlayerInput(Player* player);
void        updatePlayerPosition(Player* player) ;
void        movePlayerSprites(Player* player);
void        playerSpawn(Player* player, int x, int y);
uint8_t     getTileAt(uint8_t x, uint8_t y);
#endif

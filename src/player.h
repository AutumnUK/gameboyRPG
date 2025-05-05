#ifndef PLAYER_H
#define PLAYER_H

typedef struct {
    // Movement Values
    uint8_t x;             
    uint8_t y;          
    uint8_t direction;         
    uint8_t is_moving;          
    uint8_t move_progress;      

} Player;
void handlePlayerInput(Player* player);
void updatePlayerPosition(Player* player) ;
void movePlayerSprites(Player* player);
void playerSpawn(Player* player, int x, int y);
uint8_t getTileAt(uint8_t x, uint8_t y);
#endif
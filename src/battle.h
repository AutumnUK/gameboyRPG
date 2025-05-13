#ifndef BATTLE_H
#define BATTLE_H
#include "player.h"
void clearText( void );
void battleWindowUpdate( Player * player );
void writeBattleText( char i[20] , char k[20], char j[20] );
uint8_t battle( Player * player );

#endif // BATTLE_H

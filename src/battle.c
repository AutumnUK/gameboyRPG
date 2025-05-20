#include    "gbdk_headers.h"
#include    "title_screen.h"
#include    "save_room.h"
#include    "player.h"
#include    "testament_lib.h"

void battleWindowUpdate( uint16_t hp, uint16_t enemy ) {
    gotogxy( 0 , 15 );  gprintf( "HP : %d" , hp );
    gotogxy( 1 , 1 );   gprintf( "Enemy HP %d" , enemy );
}

// The actual battle. Should take 1 player and 1 enemy (for now)
void battle( Player* player ) { 
    uint8_t     state               = 1;
    uint8_t     selection           = 1;
    uint8_t     enemy_hp            = 5;
    uint8_t     enemy_speed         = 3;
    uint8_t     enemy_atk           = 3;

    writeText( "CYBER APPEARS" , " " , " " );
 
    while (state == 1 ) { // Player Turn
        battleWindowUpdate( player -> player_hp , enemy_hp );
                
        gotogxy(  1 , 16 );     gprintf( "Attack" );    gotogxy( 11 , 16 );     gprintf( "Item" );
        gotogxy(  1 , 17 );     gprintf( "Special" );   gotogxy( 11 , 17 );     gprintf( "Escape" );
                

        switch ( selection ) {
            case 1: // Attack
                gotogxy(  0 , 16 ); gprintf( ">" ); gotogxy( 10 , 16 ); gprintf( " " );
                gotogxy(  0 , 17 ); gprintf( " " ); gotogxy( 10 , 17 ); gprintf( " " );
                            
                if (joypad() & J_RIGHT  ) { selection = 2; }
                if (joypad() & J_DOWN   ) { selection = 3; }     
                            
                if ( joypad() & J_A ) {
                    writeText("ATTACK" , " " , " ");
                    enemy_hp -= ( player -> player_atk );
                    battleWindowUpdate( player -> player_hp , enemy_hp );
                    if ( enemy_hp > 0 ) { state = 2; }
                    if ( enemy_hp < 1 ) { state = 3; }
                }
                break;
            
            case 2: // Item
                gotogxy(  0 , 16 ); gprintf( " " ); gotogxy( 10 , 16 ); gprintf( ">" );
                gotogxy(  0 , 17 ); gprintf( " " ); gotogxy( 10 , 17 ); gprintf( " " );
                if ( joypad() & J_LEFT  ) { selection = 1; }
                if ( joypad() & J_DOWN  ) { selection = 4; }
                break;

            case 3: // Special
                if ( joypad() & J_UP    ) { selection = 1; }
                if ( joypad() & J_RIGHT ) { selection = 4; }
                gotogxy(  0 , 16 ); gprintf( " " ); gotogxy( 10 , 16 ); gprintf( " " );
                gotogxy(  0 , 17 ); gprintf( ">" ); gotogxy( 10 , 17 ); gprintf( " " );
                break;

            case 4: // Escape
                if ( joypad() & J_UP    ) { selection = 2; }
                if ( joypad() & J_LEFT  ) { selection = 3; }
                gotogxy(  0 , 16 ); gprintf( " " ); gotogxy( 10 , 16 ); gprintf( " " );
                gotogxy(  0 , 17 ); gprintf( " " ); gotogxy( 10 , 17 ); gprintf( ">" );
                break;
            }
        
                

    // Enemy Turn
    while ( state == 2 ) { 
        writeText("ENEMY ATTACKS","2 DAMAGE"," ");  
        player -> player_hp -= enemy_atk;
        state = 1;
    }

    // Win Battle
    while ( state == 3 ) {
        writeText("YOU DEFEATED CYBER","YOU GAIN 10XP"," ");
        break;
    }

        // Lose Battle
        // while ( state == 4 )            
}
}

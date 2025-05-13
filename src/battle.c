#include "gbdk_headers.h"
#include "title_screen.h"
#include "save_room.h"
#include "player.h"

// Initialises variables for battle. (To be removed)
uint8_t     selection       = 0;
uint8_t     state           = 2; 
uint8_t     turn            = 0;
uint8_t     enemy_hp        = 5;
uint8_t     enemy_speed     = 3;
uint8_t     enemy_atk       = 3;
uint8_t     wait;

// Removes all text in the 3 high battle panel.
void clearText( void ) {
    gotogxy( 0 , 15 );
    for ( uint8_t i = 0; i < 60; i ++ ) {
        gprintf( " " ); 
    }
}

void battleWindowUpdate( uint16_t hp ) {
    gotogxy( 0 , 15 );  gprintf( "HP : %d" , hp );
    gotogxy( 1 , 1 );   gprintf( "Enemy HP" );
    gotogxy( 10, 1 );   gprintf( "%d" , enemy_hp );
}

// Writes text to the battle panel.
// It takes two 20 character strings and an 18 character string.
// Probably should rebuild this to be cleaner.
void writeBattleText( char i[20] , char j[20] , char k[20] ) {
    wait = 0;
    clearText();

    gotogxy(  0 , 15 ); gprintf( "%s" , i );
    gotogxy(  0 , 16 ); gprintf( "%s" , j );
    gotogxy(  0 , 17 ); gprintf( "%s" , k );
    gotogxy( 19 , 17 ); gprintf("\n");
 
    while (wait == 0) {
        if (joypad() & J_A) {
            delay(600);
            clearText();
            wait ++;
        }
    }
}

// The actual battle. Should take 1 player and 1 enemy (for now)
// You can use temp values for the enemy until you add enemy data types
uint8_t battle( Player* player ) { 
    clearText();

    // Battle setup state.
    while (state == 0) {
        writeBattleText("CYBER APPEARS","READY YOUSELF","OR DIE"); //remove this soon
        if ( (player -> player_speed)  > enemy_speed) { state = 1; }
        else { state = 2; }
    }

    // Player Turn State
    while( state == 1 ) {
        battleWindowUpdate(player -> player_hp);

        gotogxy(  0 ,  0 ); gprintf( "%d" , selection );
        gotogxy(  1 , 16 ); gprintf( "Attack"  );
        gotogxy( 11 , 16 ); gprintf( "Item"    );
        gotogxy(  1 , 17 ); gprintf( "Special" );
        gotogxy( 11 , 17 ); gprintf( "Escape " );
 
        
        switch( selection ) {
            // Attack (top left)
            case 0 :
                if ( joypad() & J_A ) { 
                    writeBattleText("YOU ATTACK CYBER","4 DAMAGE" , "  ");  
                    enemy_hp -= ( player -> player_atk );
                    battleWindowUpdate(player -> player_hp);
                    if ( enemy_hp < 1 ) { state = 3;  }
                    if ( enemy_hp > 0 ) { state = 2;  }
                }

                if (joypad() & J_RIGHT  ) { selection = 1; }
                if (joypad() & J_DOWN   ) { selection = 2; }

                gotogxy(  0 , 16 ); gprintf( ">" );
                gotogxy( 10 , 16 ); gprintf( " " );
                gotogxy(  0 , 17 ); gprintf( " " );
                gotogxy( 10 , 17 ); gprintf( " " );

                break;

            // Special (top right)
            case 1 :
                if ( joypad() & J_LEFT  ) { selection = 0; }
                if ( joypad() & J_DOWN  ) { selection = 3; }

                gotogxy(  0 , 16 ); gprintf( " " );
                gotogxy( 10 , 16 ); gprintf( ">" );
                gotogxy(  0 , 17 ); gprintf( " " );
                gotogxy( 10 , 17 ); gprintf( " " );
                break;

            // Item (bottom left)
            case 2 :
                if ( joypad() & J_UP    ) { selection = 0; }
                if ( joypad() & J_RIGHT ) { selection = 3; }

                gotogxy(  0 , 16 ); gprintf( " " );
                gotogxy( 10 , 16 ); gprintf( " " );
                gotogxy(  0 , 17 ); gprintf( ">" );
                gotogxy( 10 , 17 ); gprintf( " " );
                break;

            // Escape (bottom right)
            case 3 :
                if ( joypad() & J_UP    ) { selection = 1; }
                if ( joypad() & J_LEFT  ) { selection = 2; }

                gotogxy(  0 , 16 ); gprintf( " " );
                gotogxy( 10 , 16 ); gprintf( " " );
                gotogxy(  0 , 17 ); gprintf( " " );
                gotogxy( 10 , 17 ); gprintf( ">" );
                break;
        }
    }
    // Enemy Turn
    while ( state == 2 ) {
        char ow1[] = "CYBER ATTACKS";
        char ow2[] = "2 DAMAGE";
        writeBattleText(ow1,ow2," ");  
        player -> player_hp -= enemy_atk;
        state = 1;
    }

    // Win Battle
    while ( state == 3 ) {
        writeBattleText("YOU DEFEATED CYBER","YOU GAIN 10XP"," ");
        return 2;
    }

    return 1;
    // Lose Battle
    // while ( state == 4 )


}


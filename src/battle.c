#include "gbdk_headers.h"
#include "title_screen.h"
#include "save_room.h"

// Initialises variables for battle. (To be removed)
uint16_t    player_hp       = 20;
uint8_t     player_atk      = 5;
uint8_t     player_speed    = 5;
uint8_t     selection       = 0;
uint16_t    enemy_hp        = 5;
uint8_t     enemy_atk       = 2;
uint8_t     enemy_speed     = 4;
uint8_t     joy;
uint8_t     state           = 0; 
uint8_t     turn            = 0;


// Removes all text in the 3 high battle panel.
void clearText( void ) {
    gotogxy( 0 , 16 );
    for ( uint8_t i = 0; i < 60; i ++ ) {
        gprintf( " " );
    }
}

// Creates the battle panel.
void battleWindow( void ) {
    // Top Bar
    gotogxy( 0 , 14 );
    for ( uint8_t i = 0; i < 20; i ++ ) {
        gprintf( "_" );
    }
}

void battleWindowUpdate( void ) {
    // Player
    gotogxy( 0 , 15 );
    gprintf( "HP : %d" , player_hp );

    gotogxy( 1 , 1 );
    gprintf( "Enemy HP" );
    gotogxy( 10, 1 );
    gprintf( "%d" , enemy_hp );

}

// Writes text to the battle panel.
// It takes two 20 char strings.
void writeBattleText( char i[20], char j[20]  ) {
    delay(200);
    clearText();
    gotogxy( 0 , 16 );  gprintf( "%s" , i );
    gotogxy( 0 , 17 );  gprintf( "%s" , j );
    uint8_t wait = 0;
    while (wait == 0) {
        if (joypad() & J_A) {
            delay(600);
            clearText();
            wait ++;
        }
    }
}

void battle( void ) {
    battleWindow(); 
    clearText();

    char i[] = "CYBER APPEARS";
    char j[] = "READY YOURSELF     \n";

    // Battle setup state.
    while (state == 0) {
        writeBattleText(i,j);
        if (player_speed > enemy_speed) { state = 1; }
        if (player_speed < enemy_speed) { state = 2; }
    }

    // Player Turn State
    while( state == 1 ) {
        battleWindowUpdate();

        gotogxy(  0 ,  0 ); gprintf( "%d" , selection );
        gotogxy(  1 , 16 ); gprintf( "Attack"  );
        gotogxy( 11 , 16 ); gprintf( "Item"    );
        gotogxy(  1 , 17 ); gprintf( "Special" );
        gotogxy( 11 , 17 ); gprintf( "Escape " );
 
        joy = joypad();

        switch( selection ) {
            // Attack
            case 0 :
                if ( joy & J_A ) { 
                    char w1[] = "YOU ATTACK CYBER";
                    char w2[] = "5 DAMAGE";
                    writeBattleText(w1,w2);  
                    enemy_hp -= player_atk; 
                    battleWindowUpdate();
                    if ( enemy_hp < 1 ) {
                        state = 3;
                    }
                    else {
                        state = 2;
                    }
                }

                if (joy & J_RIGHT  ) { selection = 1; }
                if (joy & J_DOWN   ) { selection = 2; }

                gotogxy(  0 , 16 ); gprintf( ">" );
                gotogxy( 10 , 16 ); gprintf( " " );
                gotogxy(  0 , 17 ); gprintf( " " );
                gotogxy( 10 , 17 ); gprintf( " " );
                break;

            // Special
            case 1 :
                if ( joy & J_LEFT  ) { selection = 0; }
                if ( joy & J_DOWN  ) { selection = 3; }

                gotogxy(  0 , 16 ); gprintf( " " );
                gotogxy( 10 , 16 ); gprintf( ">" );
                gotogxy(  0 , 17 ); gprintf( " " );
                gotogxy( 10 , 17 ); gprintf( " " );
                break;

            // Item
            case 2 :
                if ( joy & J_UP    ) { selection = 0; }
                if ( joy & J_RIGHT ) { selection = 3; }

                gotogxy(  0 , 16 ); gprintf( " " );
                gotogxy( 10 , 16 ); gprintf( " " );
                gotogxy(  0 , 17 ); gprintf( ">" );
                gotogxy( 10 , 17 ); gprintf( " " );
                break;

            // Escape
            case 3 :
                if ( joy & J_UP    ) { selection = 1; }
                if ( joy & J_LEFT  ) { selection = 2; }

                gotogxy(  0 , 16 ); gprintf( " " );
                gotogxy( 10 , 16 ); gprintf( " " );
                gotogxy(  0 , 17 ); gprintf( " " );
                gotogxy( 10 , 17 ); gprintf( ">" );
                break;
        }

        // Enemy Turn
        while ( state == 2 ) {
            char ow1[] = "CYBER ATTACKS";
            char ow2[] = "2 DAMAGE";
            writeBattleText(ow1,ow2);  
            player_hp -= enemy_atk;
            state = 1;
        }

        // Win Battle
        while ( state == 3 ) {
            writeBattleText("YOU DEFEATED CYBER","YOU GAIN 10XP");
            break;
        }

        // Lose Battle
        // while ( state == 4 )


    }
}

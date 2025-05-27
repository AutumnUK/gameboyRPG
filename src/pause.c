#include "headers.h"
#include "player.h"



void pause_exit( void ) {
    gotogxy( 0 , 0 );
    
    for ( uint16_t i = 0 ; i < 360 ; i ++ ) {
        gprintf( " " );
    }

    SHOW_SPRITES;
}

void pause_menu( void ) {

    while( 1 ) {
        if ( joypad() & J_B ) {
            pause_exit();
            return;
        }
    }
}


void pause_init( Player * player) {
    HIDE_SPRITES;
    
    gotogxy( 0 , 0 );
    
    for (uint8_t i = 0 ; i < 20 ; i ++) { 
        gprintf("~");    
    }
    
    for (uint8_t i = 1; i < 17; i++ ){
        gotogxy(0,i);
        gprintf("[");

        gotogxy(12,i);
        gprintf("]");

        gotogxy(19,i);
        gprintf("#");
    }       

    for (uint8_t i = 0; i < 20; i++) {
        gprintf("~"); 
    }

    gotogxy( 14 , 1 );
    gprintf( "PAUSE" );

    gotogxy( 1 , 1 );
    gprintf( "LEVEL : %d", player -> level );

    gotogxy( 1 , 2 );
    gprintf( "XP %d / %d", player -> xp, player -> xp_for_level);

    gotogxy( 1 , 4 );
    gprintf( "STATS" );

    pause_menu();
}

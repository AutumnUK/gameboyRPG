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
    
    gotogxy( 14 , 1 );
    gprintf( "PAUSE" );

    gotogxy( 1 , 1 );
    gprintf( "LEVEL : %d", player -> level );

    gotogxy( 1 , 2 );
    gprintf( "XP %d", player -> xp);
    gprintf( " / %d", player -> xp_for_level);

    gotogxy( 1 , 4 );
    gprintf( "STATS" );

    gotogxy( 1 , 5 );
    gprintf( "Attack   %d", player -> player_atk);

    gotogxy( 1 , 6 );
    gprintf( "Defence  %d", player -> defence);

    gotogxy( 1 , 7 );
    gprintf( "Speed    %d", player -> player_speed);

    pause_menu();
}

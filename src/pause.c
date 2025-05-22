#include "gbdk_headers.h"



void pause_init( void ) {
    gotogxy( 10 , 10 );
    gprintf( "PAUSE" );
}

void pause_exit( void ) {
    gotogxy( 10 , 10 );
    gprintf( "     " );
}

void pause_menu( void ) {
    
    pause_init();  
    while( 1 ) {
        if ( joypad() & J_B ) {
            pause_exit();
            return;
        }
    }
}

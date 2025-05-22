#include    "gbdk_headers.h"

#define     TOPROW      15
#define     MIDROW      16
#define     BOTROW      17
#define     ROWLEN      20
#define     BOXLEN      60 

void clearText( void ) {
    gotogxy( 0 , TOPROW);
    for ( uint8_t i = 0; i < BOXLEN; i++ ) {
        gprintf( " " );
    }
}

// This function writes to the 3 rows on the bottom of the screen.
// Update to check for a button release.
uint8_t writeText( char i[20] , char j[20] , char k[18] ) {
    clearText();
    uint8_t wait = 1;
    
    gotogxy( 0 , TOPROW );
    gprintf( "%s" , i );

    gotogxy( 0 , MIDROW );
    gprintf( "%s" , j );
    
    gotogxy( 0 , BOTROW );
    gprintf( "%s" , k );

    while ( wait = 1 ) {
        delay(200);
        if ( joypad() & J_A ) {
            delay(200);
            clearText();
            return 1;
        }
    }
}



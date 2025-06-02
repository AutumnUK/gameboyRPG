#include    "headers.h"

uint8_t enemyAppears( char enemy_name[] ) {
    uint8_t     wait = 1;
    clearText();
    gotogxy( 0 , 15 );  gprintf( "ENEMY %s APPEARS!", enemy_name); 

    while ( wait = 1 ) {
        delay(200);
        if ( joypad() & J_A ) {
            delay(200);
            clearText();
            return 1;
        }
    }
}

uint16_t enemyHit( char enemy_name[] , uint16_t enemyhp, uint8_t damage ) {

    clearText();
    gotogxy( 0 , 15 );  gprintf( "YOU ATTACKED %s!", enemy_name); 
    gotogxy( 0 , 16 );  gprintf( "%d DAMAGE!", damage);

    
    while ( 1 ) {
        delay(200);
        if ( joypad() & J_A ) {
            delay(200);
            clearText();
            if (enemyhp >= damage) {
                enemyhp -= damage;
                return enemyhp;
            }

            if (enemyhp < damage) {
                return 0;
            }
        }
    }
}

uint8_t enemyAttacks( char enemy_name[] , uint8_t damage) {
    uint8_t     wait = 1;
    clearText();
    gotogxy( 0 , 15 );  gprintf( "%s ATTACKS!", enemy_name); 
    gotogxy( 0 , 16 );  gprintf( "%d DAMAGE!", damage);

    while ( wait = 1 ) {
        delay(200);
        if ( joypad() & J_A ) {
            delay(200);
            clearText();
            return 1;
        }
    }
}

uint8_t victory( char enemy_name[] , uint8_t xp) {
    uint8_t     wait = 1;
    clearText();
    gotogxy( 0 , 15 );  gprintf( "%s IS DEAD!", enemy_name); 
    gotogxy( 0 , 16 );  gprintf( "YOU GAIN %d XP!", xp);

    while ( wait = 1 ) {
        delay(200);
        if ( joypad() & J_A ) {
            delay(200);
            clearText();
            return 1;
        }
    }
}

void battleClear( void ) {
    gotogxy( 0 , 0 );
    for (uint16_t i = 0 ; i < 360; i++) {
        gprintf(" ");
    }
}

void inputSelection( uint8_t select ) {

    gotogxy(  1 , 16 );     gprintf( "Attack" ); 
    gotogxy( 11 , 16 );     gprintf( "Item" );
    gotogxy(  1 , 17 );     gprintf( "Special" );
    gotogxy( 11 , 17 );     gprintf( "Escape" );

    switch (select) {
        case 1 : 
            gotogxy(  0 , 16 ); gprintf( ">" );     gotogxy( 10 , 16 ); gprintf( " " );
            gotogxy(  0 , 17 ); gprintf( " " );     gotogxy( 10 , 17 ); gprintf( " " );
            break;

        case 2 : 
            gotogxy(  0 , 16 ); gprintf( " " );     gotogxy( 10 , 16 ); gprintf( ">" );
            gotogxy(  0 , 17 ); gprintf( " " );     gotogxy( 10 , 17 ); gprintf( " " );
            break;

        case 3 : 
            gotogxy(  0 , 16 ); gprintf( " " );     gotogxy( 10 , 16 ); gprintf( " " );
            gotogxy(  0 , 17 ); gprintf( ">" );     gotogxy( 10 , 17 ); gprintf( " " );
            break;
        case 4 : 
            gotogxy(  0 , 16 ); gprintf( " " );     gotogxy( 10 , 16 ); gprintf( " " );
            gotogxy(  0 , 17 ); gprintf( " " );     gotogxy( 10 , 17 ); gprintf( ">" );
            break;
    }
}

void battle( Player * player , Enemy * enemy) { 
    HIDE_SPRITES;
    uint8_t     state       = 1;
    uint8_t     selection   = 1;

    battleClear();
    enemyAppears(enemy -> name);

    while ( 1) {

        if (state == 1 ) { // Player Turn

            battleWindowUpdate( player -> player_hp );
            inputSelection(selection);        
            gotogxy( 1 , 1); gprintf("%d", enemy -> hp);
        
            switch ( selection ) {
                case 1: // Attack          
                    if (joypad() & J_RIGHT  ) { selection = 2; }
                    if (joypad() & J_DOWN   ) { selection = 3; }
                         
                    if ( joypad() & J_A ) {
                        enemy -> hp = enemyHit(enemy -> name, enemy -> hp, player -> player_atk);
                        if ( enemy -> hp < 1 )  { 
                            victory(enemy -> name , enemy -> xp );
                            player -> xp        += enemy -> xp;
                            player -> steps     = 0;
                            return;
                        }
                        else                    { state = 2;}
                    }
                    break;
                
                case 2: // Item
                    if ( joypad() & J_LEFT  ) { selection = 1; }
                    if ( joypad() & J_DOWN  ) { selection = 4; }
                    break;

                case 3: // Special            
                    if ( joypad() & J_UP    ) { selection = 1; }
                    if ( joypad() & J_RIGHT ) { selection = 4; }
                    break;

                case 4: // Escape
                    if ( joypad() & J_UP    ) { selection = 2; }
                    if ( joypad() & J_LEFT  ) { selection = 3; }
                    break;
            }
        }
        // Enemy Turn
        if ( state == 2 ) {
            enemyAttacks( enemy -> name , enemy -> attack );
            player -> player_hp -= enemy -> attack;
            state = 1;
        }
        // Lose Battle
        // while ( state == 4 )   
    }    


}



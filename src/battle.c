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

uint8_t enemyHit( char enemy_name[] , uint8_t damage ) {
    uint8_t     wait = 1;
    clearText();
    gotogxy( 0 , 15 );  gprintf( "YOU ATTACKED %s!", enemy_name); 
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

void battle( Player * player , Enemy * enemy) { 
    uint8_t     state       = 1;
    uint8_t     selection   = 1;

    enemyAppears(enemy -> name);

    while (state == 1 ) { // Player Turn
        battleWindowUpdate( player -> player_hp );
                
        gotogxy(  1 , 16 );     gprintf( "Attack" ); 
        gotogxy( 11 , 16 );     gprintf( "Item" );
        gotogxy(  1 , 17 );     gprintf( "Special" );
        gotogxy( 11 , 17 );     gprintf( "Escape" );
                
        switch ( selection ) {
            case 1: // Attack
                gotogxy(  0 , 16 ); gprintf( ">" );     gotogxy( 10 , 16 ); gprintf( " " );
                gotogxy(  0 , 17 ); gprintf( " " );     gotogxy( 10 , 17 ); gprintf( " " );
                            
                if (joypad() & J_RIGHT  ) { selection = 2; }
                if (joypad() & J_DOWN   ) { selection = 3; }     
                            
                if ( joypad() & J_A ) {
                    enemyHit(enemy -> name, player -> player_atk);
                    delay(200);
                    enemy -> hp -= ( player -> player_atk );
                    battleWindowUpdate( player -> player_hp  );
                    if ( enemy -> hp > 0 ) { state = 2; }
                    if ( enemy -> hp < 1 ) { state = 3; }
                }
                break;
            
            case 2: // Item
                gotogxy(  0 , 16 ); 
                gprintf( " " ); 

                gotogxy( 10 , 16 ); 
                gprintf( ">" );
               
                gotogxy(  0 , 17 ); 
                gprintf( " " ); 

                gotogxy( 10 , 17 ); 
                gprintf( " " );

                if ( joypad() & J_LEFT  ) { 
                    selection = 1; 
                }

                if ( joypad() & J_DOWN  ) { 
                    selection = 4; 
                }

                break;

            case 3: // Special
                if ( joypad() & J_UP    ) { 
                    selection = 1; 
                }

                if ( joypad() & J_RIGHT ) { 
                    selection = 4; 
                }

                gotogxy(  0 , 16 ); 
                gprintf( " " ); 

                gotogxy( 10 , 16 ); 
                gprintf( " " );
                
                gotogxy(  0 , 17 ); 
                gprintf( ">" ); 

                gotogxy( 10 , 17 ); 
                gprintf( " " );
                
                break;

            case 4: // Escape
                if ( joypad() & J_UP    ) { 
                    selection = 2; 
                }

                if ( joypad() & J_LEFT  ) { 
                    selection = 3; 
                }

                gotogxy(  0 , 16 ); 
                gprintf( " " ); 

                gotogxy( 10 , 16 ); 
                gprintf( " " );
                
                gotogxy(  0 , 17 ); 
                gprintf( " " ); 

                gotogxy( 10 , 17 ); 
                gprintf( ">" );
                
                break;
            }
        
        // Enemy Turn
        while ( state == 2 ) { 
            writeText("ENEMY ATTACKS","2 DAMAGE"," ");  
            player -> player_hp -= enemy -> attack;
            state = 1;
        }

        // Win Battle
        while ( state == 3 ) {
            writeText("YOU DEFEATED CYBER","YOU GAIN 1XP"," ");
            player -> xp += 1;
            if ( ( player -> xp ) >= ( player -> xp_for_level ) ) {
                player -> level += 1;
                player -> xp = 0;
                player -> xp_for_level += 5;
                player -> player_atk += 1;
            }
            break;
        }

        // Lose Battle
        // while ( state == 4 )            
    }
}

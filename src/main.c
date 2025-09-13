#include    "../Tools/GBDK/include/gb/gb.h"
#include    "../Tools/GBDK/include/gb/drawing.h"
#include    "../Tools/GBDK/include/rand.h"
#include    "../res/test_tiles.c"
#include    "maps.h"
#include    "functions.h"

void drawPlayer(void) {
    for (uint8_t i = 0; i < 4; i++) {
        set_sprite_tile(i,1);
    }
}


void drawBackground(int cam_x, int cam_y, char map[60][60]) {
        // Vertical loop.
        for (int i = cam_y; i < 18 + cam_y; i++) {
            // Horizontal loop.
            for (int j = cam_x; j < 20 + cam_x; j++) {
                // Set fixed x and y with camera relative x and y;
                set_bkg_tile_xy(j - cam_x,i - cam_y,map[i][j]);
            }
        }
}

void drawPlayerUpdate(void) {
    move_sprite(0,80,72);
    move_sprite(1,88,72);
    move_sprite(2,80,80);
    move_sprite(3,88,80);
}

void drawBattleBorder(void) {
    set_bkg_tile_xy(2,2,4);
    for (int i = 0 + 3; i < 14 + 3; i++) { set_bkg_tile_xy(i,2,5); }
    set_bkg_tile_xy(17,2,6);
    for (int i = 0 + 3; i < 12 + 3; i++) { set_bkg_tile_xy(2,i,11); }
    set_bkg_tile_xy(2,15,10);
    for (int i = 0 + 3; i < 14 + 3; i++) { set_bkg_tile_xy(i,15,9); }
    set_bkg_tile_xy(17,15,8);
    for (int i = 0 + 3; i < 12 + 3; i++) { set_bkg_tile_xy(17,i,7); }
    for (int i = 3; i < 17; i++) {
        for (int j = 3; j < 15; j++) {
            set_bkg_tile_xy(i,j,0);
        }
    }
}

void drawBattleIntro(void) {
    for (int i = 2; i < 18; i++) {
        for (int j = 2; j < 16; j++) {
            set_bkg_tile_xy(i,j,1);
        }
        delay(10);
    }
    for (int i = 2; i < 18; i++) {
        for (int j = 2; j < 16; j++) {
            set_bkg_tile_xy(i,j,0);
        }
        delay(10);
    }
}

void main(void) {    
    systemSetup();
    set_bkg_data(   0,20,TestTiles);
    set_sprite_data(0,4,TestTiles);

    int camera_x = 11;
    int camera_y = 11;
    int moving   = 0;
    int canMoveLeft = 0;
    int canMoveRight = 0;
    int canMoveUp = 0;
    int canMoveDown = 0;

    drawPlayer();
    drawPlayerUpdate(); 
    drawBackground(camera_x,camera_y,debug_map);

    while (1) {
        vsync();



        // Movement code.
        if ( get_bkg_tile_xy(8,8)  == 0x02 & get_bkg_tile_xy(8,7)  == 0x02 ) { canMoveLeft  = 1; } else { canMoveLeft = 0; }
        if ( get_bkg_tile_xy(11,8) == 0x02 & get_bkg_tile_xy(11,7) == 0x02 ) { canMoveRight = 1; } else { canMoveRight = 0; }
        if ( get_bkg_tile_xy(9,6)  == 0x02 & get_bkg_tile_xy(10,6) == 0x02 ) { canMoveUp    = 1; } else { canMoveUp = 0;}
        if ( get_bkg_tile_xy(9,9)  == 0x02 & get_bkg_tile_xy(10,9) == 0x02 ) { canMoveDown  = 1; } else { canMoveDown = 0;}


        if (moving == 0) {
            if (joypad() & J_LEFT && canMoveLeft)  { 
                moving = 1;
                for (uint8_t i = 0; i < 2; i++) {
                    camera_x -= 1;
                    drawBackground(camera_x,camera_y,debug_map); 
                } 
                moving = 0; 
            }
            
            if (joypad() & J_RIGHT && canMoveRight) {
                moving = 1; 
                for (uint8_t i = 0; i < 2; i++) {
                    camera_x += 1;
                    drawBackground(camera_x,camera_y,debug_map); 
                } 
                moving = 0; 
            }

            if (joypad() & J_UP && canMoveUp){
                moving = 1; 
                for (uint8_t i = 0; i < 2; i++) {
                    camera_y -= 1;
                    drawBackground(camera_x,camera_y,debug_map); 
                } 
                moving = 0; 
            }
            
            if (joypad() & J_DOWN && canMoveDown) {
                moving = 1; 
                for (uint8_t i = 0; i < 2; i++) {
                    camera_y += 1;
                    drawBackground(camera_x,camera_y,debug_map); 
                }  
                moving = 0; 
                
            }
        }
    }
}
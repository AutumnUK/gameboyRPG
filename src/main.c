#include "headers.h"
#include "title_screen.h"
#include "save_room.h"
#include "player.h"
#include "../res/test_tiles.c"
#include "maps.h"
void clear(void) {
    
    for (int i = 0; i < 18; i++) {
        for (int j = 0; j < 20; j++) {
            set_bkg_tile_xy(j,i,0);
        }

    }


}

void main(void) {    
    SHOW_SPRITES;
    SHOW_BKG;
    DISPLAY_ON;    
    set_bkg_data(0,4,TestTiles);
    set_sprite_data(0,4,TestTiles);
    set_sprite_tile(0,1);
    set_sprite_tile(1,1);
    set_sprite_tile(2,1);
    set_sprite_tile(3,1);
    clear();
    
    int player_x;
    int player_y;
    player_x = 160/2;
    player_y = 144/2;

    int camera_x;
    int camera_y;
    int moving = 0;
    camera_x = 10;
    camera_y = 10;
    vsync();
    while (1) {
        vsync();
        move_sprite(0,player_x,player_y);
        move_sprite(1,player_x+8,player_y);
        move_sprite(2,player_x,player_y+8);
        move_sprite(3,player_x+8,player_y+8);

        // Vertical loop.
        for (int i = camera_y; i < 18 + camera_y; i++) {
            // Horizontal loop.
            for (int j = camera_x; j < 20 + camera_x; j++) {
                // Set fixed x and y with camera relative x and y;
                set_bkg_tile_xy(j - camera_x,i - camera_y,map[i][j]);
            }
        }

        if (moving == 0) {
            if (joypad() & J_LEFT)  { 
                if ( get_bkg_tile_xy( 8,8 ) != 0x01) {
                    moving = 1; camera_x -=1; moving = 0; 
                }  
            }
            
            if (joypad() & J_RIGHT) { 
                if ( get_bkg_tile_xy( 11,8 ) != 0x01) {
                    moving = 1; camera_x +=1; moving = 0; 
                }
            }

            if (joypad() & J_UP)    { 
                if ( get_bkg_tile_xy( 9,6) != 0x01) {
                    moving = 1; camera_y -=1; moving = 0; 
                }
            }
            
            if (joypad() & J_DOWN)  { 
                if ( get_bkg_tile_xy( 9, 9) != 0x01) {
                    moving = 1; camera_y += 1; moving = 0; 
                }
            }
        }

    }
    //saveRoom();
}

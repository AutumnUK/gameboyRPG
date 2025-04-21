#include "../res/save_room_map.c"
#include "../res/save_room_tiles.c"

// TODO
// Split to new file.
// Add interaction (PC with menu)
// Add music.
// Fix movement
// More
void saveRoom(void) {
    int x = 48;
    int y = 56;

    set_bkg_data(0,80,SaveRoomTiles);
    set_bkg_tiles(0,0,20,18,SaveRoomMap);
    set_sprite_data(0,4, GoofyGuy);
    
    while(1) {
        set_sprite_tile(0,0);
        set_sprite_tile(1,1);
        set_sprite_tile(2,2);
        set_sprite_tile(3,3);
    
        move_sprite(0,x,y);
        move_sprite(1,x,y+8);
        move_sprite(2,x+8,y);
        move_sprite(3,x+8,y+8);
    
        vsync();

        //160 x 144
        if (joypad() == J_UP) { 
            if (y > 48) {
                y -= 1; 
            }
        }
        if (joypad() == J_DOWN) { 
            if (y < 144) {
                y += 1; 
            }
        }
        if (joypad() == J_RIGHT) { 
            if (x < 152) {
                x += 1; 
            }
        }
        if (joypad() == J_LEFT) {        
            if (x > 8) {
            x -= 1; 
        }
    }
    }
}
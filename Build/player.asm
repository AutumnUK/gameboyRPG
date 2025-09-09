;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module player
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gotogxy
	.globl _gprintf
	.globl _set_sprite_data
	.globl _joypad
	.globl _GoofyGuy
	.globl _playerSpawn
	.globl _handlePlayerInput
	.globl _updatePlayerPosition
	.globl _movePlayerSprites
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_GoofyGuy::
	.ds 64
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src\player.c:9: void playerSpawn(Player* player, int x, int y) {
;	---------------------------------
; Function playerSpawn
; ---------------------------------
_playerSpawn::
	ld	a, c
;src\player.c:10: player -> x             = x;
	ld	(de), a
;src\player.c:11: player -> y             = y;
	ld	c, e
	ld	b, d
	inc	bc
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
;src\player.c:12: player -> is_moving     = 0;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;src\player.c:13: player -> direction     = 0;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;src\player.c:14: player -> move_progress = 0;
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0x00
;src\player.c:15: player -> level         = 1;
	ld	hl, #0x0009
	add	hl, de
	ld	(hl), #0x01
;src\player.c:16: player -> xp            = 0;
	ld	hl, #0x000a
	add	hl, de
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src\player.c:17: player -> xp_for_level  = 15;
	ld	hl, #0x000c
	add	hl, de
	ld	a, #0x0f
	ld	(hl+), a
	ld	(hl), #0x00
;src\player.c:18: player -> player_hp     = 20;
	ld	hl, #0x0005
	add	hl, de
	ld	a, #0x14
	ld	(hl+), a
	ld	(hl), #0x00
;src\player.c:19: player -> player_max_hp = 20;
	ld	hl, #0x000e
	add	hl, de
	ld	a, #0x14
	ld	(hl+), a
	ld	(hl), #0x00
;src\player.c:20: player -> player_speed  = 5;
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x05
;src\player.c:21: player -> player_atk    = 3;
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x03
;src\player.c:22: player -> defence       = 2;
	ld	hl, #0x0010
	add	hl, de
	ld	(hl), #0x02
;src\player.c:23: player -> steps         = 0;
	ld	hl, #0x0011
	add	hl, de
	ld	(hl), #0x00
;src\player.c:25: set_sprite_data(0, 4, GoofyGuy);  // Load sprite tile data
	ld	de, #_GoofyGuy
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src\../Tools/GBDK/include/gb/gb.h:1875: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x02
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x03
;src\player.c:29: set_sprite_tile(3, 3);
;src\player.c:30: }
	pop	hl
	pop	af
	jp	(hl)
;src\player.c:40: void handlePlayerInput(Player* player) {
;	---------------------------------
; Function handlePlayerInput
; ---------------------------------
_handlePlayerInput::
	ld	c, e
	ld	b, d
;src\player.c:41: if (player->is_moving == 0) {
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	ret	NZ
;src\player.c:42: switch (joypad()) {
	push	hl
	call	_joypad
	pop	hl
;src\player.c:43: case J_UP:      player->is_moving = 1; player->direction = 0; break;
	inc	bc
	inc	bc
;src\player.c:42: switch (joypad()) {
	cp	a, #0x01
	jr	Z, 00104$
	cp	a, #0x02
	jr	Z, 00103$
	cp	a, #0x04
	jr	Z, 00101$
	sub	a, #0x08
	jr	Z, 00102$
	ret
;src\player.c:43: case J_UP:      player->is_moving = 1; player->direction = 0; break;
00101$:
	ld	(hl), #0x01
	xor	a, a
	ld	(bc), a
	ret
;src\player.c:44: case J_DOWN:    player->is_moving = 1; player->direction = 1; break;
00102$:
	ld	a,#0x01
	ld	(hl),a
	ld	(bc), a
	ret
;src\player.c:45: case J_LEFT:    player->is_moving = 1; player->direction = 2; break;
00103$:
	ld	(hl), #0x01
	ld	a, #0x02
	ld	(bc), a
	ret
;src\player.c:46: case J_RIGHT:   player->is_moving = 1; player->direction = 3; break;
00104$:
	ld	(hl), #0x01
	ld	a, #0x03
	ld	(bc), a
;src\player.c:47: }
;src\player.c:49: }
	ret
;src\player.c:52: void updatePlayerPosition(Player* player) {
;	---------------------------------
; Function updatePlayerPosition
; ---------------------------------
_updatePlayerPosition::
	add	sp, #-7
	ldhl	sp,	#5
	ld	a, e
	ld	(hl+), a
;src\player.c:53: if (player->is_moving) {
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl), a
	or	a, a
	jp	Z, 00110$
;src\player.c:54: switch (player->direction) {
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;src\player.c:55: case 0: player->y--; break;
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
;src\player.c:54: switch (player->direction) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00101$
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	jr	Z, 00102$
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00103$
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00104$
	jr	00105$
;src\player.c:55: case 0: player->y--; break;
00101$:
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	dec	c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
	jr	00105$
;src\player.c:56: case 1: player->y++; break;
00102$:
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
	jr	00105$
;src\player.c:57: case 2: player->x--; break;
00103$:
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	dec	c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
	jr	00105$
;src\player.c:58: case 3: player->x++; break;
00104$:
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src\player.c:59: }
00105$:
;src\player.c:61: player->move_progress++;
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	inc	a
	ld	(bc), a
;src\player.c:62: if (player->move_progress == MOVE_DISTANCE) {
	sub	a, #0x10
	jr	NZ, 00110$
;src\player.c:63: player->move_progress = 0;
	xor	a, a
	ld	(bc), a
;src\player.c:64: player->is_moving = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
;src\player.c:65: player -> steps ++;
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src\player.c:66: gotogxy( 1, 1);
	ld	hl, #0x101
	push	hl
	call	_gotogxy
	pop	hl
;src\player.c:67: gprintf( "  ");
	ld	de, #___str_0
	push	de
	call	_gprintf
	pop	hl
;src\player.c:68: gotogxy( 1, 1);
	ld	hl, #0x101
	push	hl
	call	_gotogxy
	pop	hl
;src\player.c:69: gprintf( "%d", player -> steps);
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	e, (hl)
	ld	d, #0x00
	push	de
	ld	de, #___str_1
	push	de
	call	_gprintf
	add	sp, #4
00110$:
;src\player.c:73: }
	add	sp, #7
	ret
___str_0:
	.ascii "  "
	.db 0x00
___str_1:
	.ascii "%d"
	.db 0x00
;src\player.c:77: void movePlayerSprites(Player* player) {
;	---------------------------------
; Function movePlayerSprites
; ---------------------------------
_movePlayerSprites::
	add	sp, #-4
	ld	c, e
	ld	b, d
;src\player.c:78: move_sprite(0, player->x, player->y);
	ld	l, c
	ld	h, b
	inc	hl
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	a, (bc)
;src\../Tools/GBDK/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
;src\../Tools/GBDK/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	(hl-), a
	ld	de, #_shadow_OAM+0
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src\player.c:79: move_sprite(1, player->x, player->y + 8);
	pop	de
	push	de
	ld	a, (de)
	add	a, #0x08
	ld	d, a
	ld	a, (bc)
	ld	e, a
;src\../Tools/GBDK/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;src\../Tools/GBDK/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, d
	ld	(hl+), a
	ld	(hl), e
;src\player.c:80: move_sprite(2, player->x + 8, player->y);
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	a, (bc)
	add	a, #0x08
;src\../Tools/GBDK/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
;src\../Tools/GBDK/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	(hl-), a
	ld	de, #_shadow_OAM+8
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src\player.c:81: move_sprite(3, player->x + 8, player->y + 8);
	pop	de
	push	de
	ld	a, (de)
	add	a, #0x08
	ld	e, a
	ld	a, (bc)
	add	a, #0x08
	ld	c, a
;src\../Tools/GBDK/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;src\../Tools/GBDK/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;src\player.c:81: move_sprite(3, player->x + 8, player->y + 8);
;src\player.c:83: }
	add	sp, #4
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__GoofyGuy:
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x8e	; 142
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0xc7	; 199
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x70	; 112	'p'
	.db #0x5f	; 95
	.db #0xf0	; 240
	.db #0x9f	; 159
	.db #0xf0	; 240
	.db #0x9f	; 159
	.db #0x70	; 112	'p'
	.db #0x7f	; 127
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1e	; 30
	.db #0x12	; 18
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x71	; 113	'q'
	.db #0xfd	; 253
	.db #0x03	; 3
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x0e	; 14
	.db #0xfa	; 250
	.db #0x0f	; 15
	.db #0xf9	; 249
	.db #0x0f	; 15
	.db #0xf9	; 249
	.db #0x0e	; 14
	.db #0xfe	; 254
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x78	; 120	'x'
	.db #0x48	; 72	'H'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.area _CABS (ABS)

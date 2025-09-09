;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _clear
	.globl _set_sprite_data
	.globl _get_bkg_tile_xy
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _vsync
	.globl _joypad
	.globl _TestTiles
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
_TestTiles::
	.ds 80
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
;src\main.c:7: void clear(void) {
;	---------------------------------
; Function clear
; ---------------------------------
_clear::
;src\main.c:9: for (int i = 0; i < 18; i++) {
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x12
	ret	NC
;src\main.c:10: for (int j = 0; j < 20; j++) {
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x14
	jr	NC, 00108$
;src\main.c:11: set_bkg_tile_xy(j,i,0);
	ld	e, c
	ld	d, b
	push	bc
	xor	a, a
	push	af
	inc	sp
	ld	a, d
	call	_set_bkg_tile_xy
	pop	bc
;src\main.c:10: for (int j = 0; j < 20; j++) {
	inc	b
	jr	00104$
00108$:
;src\main.c:9: for (int i = 0; i < 18; i++) {
	inc	c
;src\main.c:17: }
	jr	00107$
;src\main.c:19: void main(void) {    
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-14
;src\main.c:20: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src\main.c:21: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src\main.c:22: DISPLAY_ON;    
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src\main.c:23: set_bkg_data(0,4,TestTiles);
	ld	bc, #_TestTiles+0
	push	bc
	ld	hl, #0x400
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src\main.c:24: set_sprite_data(0,4,TestTiles);
	push	bc
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src\../Tools/GBDK/include/gb/gb.h:1875: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x01
;src\main.c:29: clear();
	call	_clear
;src\main.c:39: camera_x = 10;
	ldhl	sp,	#8
	ld	a, #0x0a
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src\main.c:40: camera_y = 10;
	ld	bc, #0x000a
;src\main.c:41: vsync();
	call	_vsync
;src\main.c:42: while (1) {
00122$:
;src\main.c:43: vsync();
	call	_vsync
;src\../Tools/GBDK/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;src\../Tools/GBDK/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, #0x48
	ld	(hl+), a
	ld	(hl), #0x50
;src\../Tools/GBDK/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;src\../Tools/GBDK/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, #0x48
	ld	(hl+), a
	ld	(hl), #0x58
;src\../Tools/GBDK/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;src\../Tools/GBDK/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, #0x50
	ld	(hl+), a
	ld	(hl), #0x50
;src\../Tools/GBDK/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;src\../Tools/GBDK/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, #0x50
	ld	(hl+), a
	ld	(hl), #0x58
;src\main.c:50: for (int i = camera_y; i < 18 + camera_y; i++) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ld	hl, #0x0012
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00136$:
	ldhl	sp,	#10
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00235$
	bit	7, d
	jr	NZ, 00236$
	cp	a, a
	jr	00236$
00235$:
	bit	7, d
	jr	Z, 00236$
	scf
00236$:
	jp	NC, 00102$
;src\main.c:52: for (int j = camera_x; j < 20 + camera_x; j++) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_map
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
00133$:
	ldhl	sp,	#12
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00237$
	bit	7, d
	jr	NZ, 00238$
	cp	a, a
	jr	00238$
00237$:
	bit	7, d
	jr	Z, 00238$
	scf
00238$:
	jr	NC, 00137$
;src\main.c:54: set_bkg_tile_xy(j - camera_x,i - camera_y,map[i][j]);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl+)
	inc	hl
	ld	e, c
	sub	a, e
	ld	e, a
	ld	a, (hl)
	ldhl	sp,	#8
	ld	d, (hl)
	dec	hl
	sub	a, d
	ld	(hl-), a
	push	bc
	ld	a, (hl+)
	push	af
	inc	sp
	ld	a, (hl)
	call	_set_bkg_tile_xy
	pop	bc
;src\main.c:52: for (int j = camera_x; j < 20 + camera_x; j++) {
	ldhl	sp,	#12
	inc	(hl)
	jr	NZ, 00133$
	inc	hl
	inc	(hl)
	jr	00133$
00137$:
;src\main.c:50: for (int i = camera_y; i < 18 + camera_y; i++) {
	ldhl	sp,	#10
	inc	(hl)
	jp	NZ,00136$
	inc	hl
	inc	(hl)
	jp	00136$
00102$:
;src\main.c:59: if (joypad() & J_LEFT)  { 
	call	_joypad
	bit	1, a
	jr	Z, 00106$
;src\main.c:60: if ( get_bkg_tile_xy( 8,8 ) != 0x01) {
	ld	a, #0x08
	push	af
	inc	sp
	ld	a, #0x08
	push	af
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	dec	e
	jr	Z, 00106$
;src\main.c:61: moving = 1; camera_x -=1; moving = 0; 
	ldhl	sp,#8
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	dec	hl
	dec	de
	ld	(hl), e
	inc	hl
	ld	(hl), d
00106$:
;src\main.c:65: if (joypad() & J_RIGHT) { 
	call	_joypad
	rrca
	jr	NC, 00110$
;src\main.c:66: if ( get_bkg_tile_xy( 11,8 ) != 0x01) {
	ld	a, #0x08
	push	af
	inc	sp
	ld	a, #0x0b
	push	af
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	dec	e
	jr	Z, 00110$
;src\main.c:67: moving = 1; camera_x +=1; moving = 0; 
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00245$
	inc	hl
	inc	(hl)
00245$:
00110$:
;src\main.c:71: if (joypad() & J_UP)    { 
	call	_joypad
	bit	2, a
	jr	Z, 00114$
;src\main.c:72: if ( get_bkg_tile_xy( 9,6) != 0x01) {
	ld	a, #0x06
	push	af
	inc	sp
	ld	a, #0x09
	push	af
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	dec	e
	jr	Z, 00114$
;src\main.c:73: moving = 1; camera_y -=1; moving = 0; 
	dec	bc
00114$:
;src\main.c:77: if (joypad() & J_DOWN)  { 
	call	_joypad
	bit	3, a
	jp	Z,00122$
;src\main.c:78: if ( get_bkg_tile_xy( 9, 9) != 0x01) {
	ld	hl, #0x909
	push	hl
	call	_get_bkg_tile_xy
	pop	hl
	dec	e
	jp	Z,00122$
;src\main.c:79: moving = 1; camera_y += 1; moving = 0; 
	inc	bc
	jp	00122$
;src\main.c:86: }
	add	sp, #14
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__TestTiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x8a	; 138
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x1a	; 26
	.db #0xfd	; 253
	.db #0x58	; 88	'X'
	.db #0xbf	; 191
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0x89	; 137
	.db #0xf7	; 247
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa3	; 163
	.db #0xdd	; 221
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.area _CABS (ABS)

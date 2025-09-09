;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module save_room
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _pause_init
	.globl _battle
	.globl _playerSpawn
	.globl _movePlayerSprites
	.globl _updatePlayerPosition
	.globl _handlePlayerInput
	.globl _gotogxy
	.globl _gprintf
	.globl _vsync
	.globl _joypad
	.globl _rng
	.globl _stepsNeeded
	.globl _stepsBase
	.globl _saveRoom
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
_stepsNeeded::
	.ds 1
_rng::
	.ds 1
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
;src\save_room.c:9: void saveRoom(void) {
;	---------------------------------
; Function saveRoom
; ---------------------------------
_saveRoom::
	add	sp, #-33
;src\save_room.c:10: gotogxy(0,0);
	xor	a, a
	rrca
	push	af
	call	_gotogxy
	pop	hl
;src\save_room.c:11: gprintf(" ");
	ld	de, #___str_1
	push	de
	call	_gprintf
	pop	hl
;src\save_room.c:12: stepsNeeded = (stepsNeeded + stepsBase + rng);
	ld	a, (#_stepsNeeded)
	add	a, #0x0a
	ld	hl, #_rng
	add	a, (hl)
	ld	(#_stepsNeeded),a
;src\save_room.c:17: playerSpawn(&player, 40, 80);
	ld	de, #0x0050
	push	de
	ld	bc, #0x0028
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_playerSpawn
;src\save_room.c:19: while (state = 1) {   
00107$:
;src\save_room.c:20: vsync();
	call	_vsync
;src\save_room.c:21: rng ++;
	ld	hl, #_rng
	inc	(hl)
;src\save_room.c:22: if (rng >= 9) { rng = 0; }
	ld	a, (hl)
	sub	a, #0x09
	jr	C, 00102$
	ld	(hl), #0x00
00102$:
;src\save_room.c:24: if ( player.steps > stepsNeeded) {
	ldhl	sp,	#17
	ld	c, (hl)
	ld	a, (#_stepsNeeded)
	sub	a, c
	jr	NC, 00104$
;src\save_room.c:27: Enemy slime = {
	ldhl	sp,	#18
	ld	a, #0x53
	ld	(hl+), a
	ld	a, #0x4c
	ld	(hl+), a
	ld	a, #0x49
	ld	(hl+), a
	ld	a, #0x4d
	ld	(hl+), a
	ld	a, #0x45
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#18
	ld	c, l
	ld	b, h
	ldhl	sp,	#24
	ld	a, #0x05
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a, #0x05
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a,#0x02
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x02
	ld	(hl+),a
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src\save_room.c:37: battle(&player , &slime);
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_battle
;src\save_room.c:38: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
00104$:
;src\save_room.c:41: if ( joypad() & J_SELECT ) {
	call	_joypad
	bit	6, a
	jr	Z, 00106$
;src\save_room.c:42: pause_init(&player);
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_pause_init
00106$:
;src\save_room.c:45: handlePlayerInput(&player);
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_handlePlayerInput
;src\save_room.c:46: updatePlayerPosition(&player);
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_updatePlayerPosition
;src\save_room.c:47: movePlayerSprites(&player);
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_movePlayerSprites
	jp	00107$
;src\save_room.c:50: }
	add	sp, #33
	ret
_stepsBase:
	.db #0x0a	; 10
___str_1:
	.ascii " "
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__stepsNeeded:
	.db #0x01	; 1
__xinit__rng:
	.db #0x00	; 0
	.area _CABS (ABS)

;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module pause
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gotogxy
	.globl _gprintf
	.globl _joypad
	.globl _pause_exit
	.globl _pause_menu
	.globl _pause_init
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
;src\pause.c:4: void pause_exit( void ) {
;	---------------------------------
; Function pause_exit
; ---------------------------------
_pause_exit::
;src\pause.c:5: gotogxy( 0 , 0 );
	xor	a, a
	rrca
	push	af
	call	_gotogxy
	pop	hl
;src\pause.c:7: for ( uint16_t i = 0 ; i < 360 ; i ++ ) {
	ld	bc, #0x0000
00103$:
	ld	e, c
	ld	d, b
	ld	a, e
	sub	a, #0x68
	ld	a, d
	sbc	a, #0x01
	jr	NC, 00101$
;src\pause.c:8: gprintf( " " );
	push	bc
	ld	de, #___str_0
	push	de
	call	_gprintf
	pop	hl
	pop	bc
;src\pause.c:7: for ( uint16_t i = 0 ; i < 360 ; i ++ ) {
	inc	bc
	jr	00103$
00101$:
;src\pause.c:11: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src\pause.c:12: }
	ret
___str_0:
	.ascii " "
	.db 0x00
;src\pause.c:14: void pause_menu( void ) {
;	---------------------------------
; Function pause_menu
; ---------------------------------
_pause_menu::
;src\pause.c:16: while( 1 ) {
00104$:
;src\pause.c:17: if ( joypad() & J_B ) {
	call	_joypad
	bit	5, a
	jr	Z, 00104$
;src\pause.c:18: pause_exit();
;src\pause.c:19: return;
;src\pause.c:22: }
	jp	_pause_exit
;src\pause.c:25: void pause_init( Player * player) {
;	---------------------------------
; Function pause_init
; ---------------------------------
_pause_init::
	push	de
;src\pause.c:26: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src\pause.c:28: gotogxy( 14 , 1 );
	ld	hl, #0x10e
	push	hl
	call	_gotogxy
	pop	hl
;src\pause.c:29: gprintf( "PAUSE" );
	ld	de, #___str_1
	push	de
	call	_gprintf
	pop	hl
;src\pause.c:31: gotogxy( 1 , 1 );
	ld	hl, #0x101
	push	hl
	call	_gotogxy
	pop	hl
;src\pause.c:32: gprintf( "LEVEL : %d", player -> level );
	pop	de
	push	de
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_2
	push	de
	call	_gprintf
	add	sp, #4
;src\pause.c:34: gotogxy( 1 , 2 );
	ld	hl, #0x201
	push	hl
	call	_gotogxy
	pop	hl
;src\pause.c:35: gprintf( "XP %d", player -> xp);
	pop	de
	push	de
	ld	hl, #0x000a
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	de, #___str_3
	push	de
	call	_gprintf
	add	sp, #4
;src\pause.c:36: gprintf( " / %d", player -> xp_for_level);
	pop	de
	push	de
	ld	hl, #0x000c
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	de, #___str_4
	push	de
	call	_gprintf
	add	sp, #4
;src\pause.c:38: gotogxy( 1 , 4 );
	ld	hl, #0x401
	push	hl
	call	_gotogxy
	pop	hl
;src\pause.c:39: gprintf( "STATS" );
	ld	de, #___str_5
	push	de
	call	_gprintf
	pop	hl
;src\pause.c:41: gotogxy( 1 , 5 );
	ld	hl, #0x501
	push	hl
	call	_gotogxy
	pop	hl
;src\pause.c:42: gprintf( "Attack   %d", player -> player_atk);
	pop	de
	push	de
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_6
	push	de
	call	_gprintf
	add	sp, #4
;src\pause.c:44: gotogxy( 1 , 6 );
	ld	hl, #0x601
	push	hl
	call	_gotogxy
	pop	hl
;src\pause.c:45: gprintf( "Defence  %d", player -> defence);
	pop	de
	push	de
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_7
	push	de
	call	_gprintf
	add	sp, #4
;src\pause.c:47: gotogxy( 1 , 7 );
	ld	hl, #0x701
	push	hl
	call	_gotogxy
	pop	hl
;src\pause.c:48: gprintf( "Speed    %d", player -> player_speed);
	pop	de
	push	de
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_8
	push	de
	call	_gprintf
	add	sp, #4
;src\pause.c:50: pause_menu();
	inc	sp
	inc	sp
	jp	_pause_menu
;src\pause.c:51: }
	inc	sp
	inc	sp
	ret
___str_1:
	.ascii "PAUSE"
	.db 0x00
___str_2:
	.ascii "LEVEL : %d"
	.db 0x00
___str_3:
	.ascii "XP %d"
	.db 0x00
___str_4:
	.ascii " / %d"
	.db 0x00
___str_5:
	.ascii "STATS"
	.db 0x00
___str_6:
	.ascii "Attack   %d"
	.db 0x00
___str_7:
	.ascii "Defence  %d"
	.db 0x00
___str_8:
	.ascii "Speed    %d"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)

;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module testament_lib
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gotogxy
	.globl _gprintf
	.globl _joypad
	.globl _delay
	.globl _clearText
	.globl _battleWindowUpdate
	.globl _writeText
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
;src\testament_lib.c:9: void clearText( void ) {
;	---------------------------------
; Function clearText
; ---------------------------------
_clearText::
;src\testament_lib.c:10: gotogxy( 0 , TOPROW);
	ld	hl, #0xf00
	push	hl
	call	_gotogxy
	pop	hl
;src\testament_lib.c:11: for ( uint8_t i = 0; i < BOXLEN; i++ ) {
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x3c
	ret	NC
;src\testament_lib.c:12: gprintf( " " );
	push	bc
	ld	de, #___str_0
	push	de
	call	_gprintf
	pop	hl
	pop	bc
;src\testament_lib.c:11: for ( uint8_t i = 0; i < BOXLEN; i++ ) {
	inc	c
;src\testament_lib.c:14: }
	jr	00103$
___str_0:
	.ascii " "
	.db 0x00
;src\testament_lib.c:16: void battleWindowUpdate( uint16_t hp ) {
;	---------------------------------
; Function battleWindowUpdate
; ---------------------------------
_battleWindowUpdate::
;src\testament_lib.c:17: gotogxy( 0 , 15 );  gprintf( "HP : %d" , hp );
	push	de
	ld	hl, #0xf00
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_1
	push	de
	call	_gprintf
	add	sp, #4
;src\testament_lib.c:18: }
	ret
___str_1:
	.ascii "HP : %d"
	.db 0x00
;src\testament_lib.c:22: uint8_t writeText( char i[20] , char j[20] , char k[18] ) {
;	---------------------------------
; Function writeText
; ---------------------------------
_writeText::
;src\testament_lib.c:23: clearText();
	push	bc
	push	de
	call	_clearText
	ld	hl, #0xf00
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_2
	push	de
	call	_gprintf
	add	sp, #4
	ld	hl, #0x1000
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_2
	push	de
	call	_gprintf
	add	sp, #4
;src\testament_lib.c:32: gotogxy( 0 , BOTROW );
	ld	a, #0x11
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	pop	hl
;src\testament_lib.c:33: gprintf( "%s" , k );
	ldhl	sp,	#2
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	de, #___str_2
	push	de
	call	_gprintf
	add	sp, #4
;src\testament_lib.c:35: while ( wait = 1 ) {
00103$:
;src\testament_lib.c:36: delay(200);
	ld	de, #0x00c8
	call	_delay
;src\testament_lib.c:37: if ( joypad() & J_A ) {
	call	_joypad
	bit	4, a
	jr	Z, 00103$
;src\testament_lib.c:38: delay(200);
	ld	de, #0x00c8
	call	_delay
;src\testament_lib.c:39: clearText();
	call	_clearText
;src\testament_lib.c:40: return 1;
	ld	a, #0x01
;src\testament_lib.c:43: }
	pop	hl
	pop	bc
	jp	(hl)
___str_2:
	.ascii "%s"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)

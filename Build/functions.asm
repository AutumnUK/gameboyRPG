;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module functions
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _systemSetup
	.globl _clear
	.globl _set_bkg_tile_xy
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
;src\functions.c:3: void clear(void) {
;	---------------------------------
; Function clear
; ---------------------------------
_clear::
;src\functions.c:4: for (int i = 0; i < 18; i++) {
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x12
	ret	NC
;src\functions.c:5: for (int j = 0; j < 20; j++) {
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x14
	jr	NC, 00108$
;src\functions.c:6: set_bkg_tile_xy(j,i,0);
	ld	e, c
	ld	d, b
	push	bc
	xor	a, a
	push	af
	inc	sp
	ld	a, d
	call	_set_bkg_tile_xy
	pop	bc
;src\functions.c:5: for (int j = 0; j < 20; j++) {
	inc	b
	jr	00104$
00108$:
;src\functions.c:4: for (int i = 0; i < 18; i++) {
	inc	c
;src\functions.c:9: }
	jr	00107$
;src\functions.c:11: void systemSetup(void) {
;	---------------------------------
; Function systemSetup
; ---------------------------------
_systemSetup::
;src\functions.c:12: clear();
	call	_clear
;src\functions.c:13: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src\functions.c:14: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src\functions.c:15: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src\functions.c:17: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)

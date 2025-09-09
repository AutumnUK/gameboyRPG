;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (MINGW64)
;--------------------------------------------------------
	.module battle
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _inputSelection
	.globl _battleClear
	.globl _victory
	.globl _enemyAttacks
	.globl _enemyHit
	.globl _enemyAppears
	.globl _battleWindowUpdate
	.globl _clearText
	.globl _gotogxy
	.globl _gprintf
	.globl _joypad
	.globl _delay
	.globl _battle
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
;src\battle.c:3: uint8_t enemyAppears( char enemy_name[] ) {
;	---------------------------------
; Function enemyAppears
; ---------------------------------
_enemyAppears::
;src\battle.c:5: clearText();
	push	de
	call	_clearText
	ld	a, #0x0f
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	pop	hl
	ld	de, #___str_0
	push	de
	call	_gprintf
	add	sp, #4
;src\battle.c:8: while ( wait = 1 ) {
00103$:
;src\battle.c:9: delay(200);
	ld	de, #0x00c8
	call	_delay
;src\battle.c:10: if ( joypad() & J_A ) {
	call	_joypad
	bit	4, a
	jr	Z, 00103$
;src\battle.c:11: delay(200);
	ld	de, #0x00c8
	call	_delay
;src\battle.c:12: clearText();
	call	_clearText
;src\battle.c:13: return 1;
	ld	a, #0x01
;src\battle.c:16: }
	ret
___str_0:
	.ascii "ENEMY %s APPEARS!"
	.db 0x00
;src\battle.c:22: uint16_t enemyHit( char enemy_name[] , uint16_t enemyhp, uint8_t damage ) {
;	---------------------------------
; Function enemyHit
; ---------------------------------
_enemyHit::
	dec	sp
	dec	sp
;src\battle.c:24: clearText();
	push	bc
	push	de
	call	_clearText
	ld	hl, #0xf00
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_1
	push	de
	call	_gprintf
	add	sp, #4
	ld	hl, #0x1000
	push	hl
	call	_gotogxy
	pop	hl
	pop	bc
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	dec	hl
	push	bc
	ld	e, (hl)
	ld	d, #0x00
	push	de
	ld	de, #___str_2
	push	de
	call	_gprintf
	add	sp, #4
	pop	bc
;src\battle.c:29: while ( 1 ) {
00108$:
;src\battle.c:30: delay(200);
	push	bc
	ld	de, #0x00c8
	call	_delay
	pop	bc
;src\battle.c:31: if ( joypad() & J_A ) {
	call	_joypad
	bit	4, a
	jr	Z, 00108$
;src\battle.c:32: delay(200);
	push	bc
	ld	de, #0x00c8
	call	_delay
	call	_clearText
	pop	bc
;src\battle.c:34: if (enemyhp >= damage) {
	ldhl	sp,	#4
	ld	e, (hl)
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	a, b
	sbc	a, d
	ld	a, #0x00
	rla
	ld	e, a
	bit	0, e
	jr	NZ, 00102$
;src\battle.c:35: enemyhp -= damage;
	pop	de
	push	de
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
;src\battle.c:36: return enemyhp;
	jr	00110$
00102$:
;src\battle.c:39: if (enemyhp < damage) {
	ld	a, e
	or	a, a
	jr	Z, 00108$
;src\battle.c:40: return 0;
	ld	bc, #0x0000
00110$:
;src\battle.c:44: }
	inc	sp
	inc	sp
	pop	hl
	inc	sp
	jp	(hl)
___str_1:
	.ascii "YOU ATTACKED %s!"
	.db 0x00
___str_2:
	.ascii "%d DAMAGE!"
	.db 0x00
;src\battle.c:46: uint8_t enemyAttacks( char enemy_name[] , uint8_t damage) {
;	---------------------------------
; Function enemyAttacks
; ---------------------------------
_enemyAttacks::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;src\battle.c:48: clearText();
	push	de
	call	_clearText
	ld	hl, #0xf00
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_3
	push	de
	call	_gprintf
	add	sp, #4
;src\battle.c:50: gotogxy( 0 , 16 );  gprintf( "%d DAMAGE!", damage);
	ld	a, #0x10
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	pop	hl
	ldhl	sp,	#0
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	de, #___str_4
	push	de
	call	_gprintf
	add	sp, #4
;src\battle.c:52: while ( wait = 1 ) {
00103$:
;src\battle.c:53: delay(200);
	ld	de, #0x00c8
	call	_delay
;src\battle.c:54: if ( joypad() & J_A ) {
	call	_joypad
	bit	4, a
	jr	Z, 00103$
;src\battle.c:55: delay(200);
	ld	de, #0x00c8
	call	_delay
;src\battle.c:56: clearText();
	call	_clearText
;src\battle.c:57: return 1;
	ld	a, #0x01
;src\battle.c:60: }
	inc	sp
	ret
___str_3:
	.ascii "%s ATTACKS!"
	.db 0x00
___str_4:
	.ascii "%d DAMAGE!"
	.db 0x00
;src\battle.c:62: uint8_t victory( char enemy_name[] , uint8_t xp) {
;	---------------------------------
; Function victory
; ---------------------------------
_victory::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;src\battle.c:64: clearText();
	push	de
	call	_clearText
	ld	hl, #0xf00
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_5
	push	de
	call	_gprintf
	add	sp, #4
;src\battle.c:66: gotogxy( 0 , 16 );  gprintf( "YOU GAIN %d XP!", xp);
	ld	a, #0x10
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	pop	hl
	ldhl	sp,	#0
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	de, #___str_6
	push	de
	call	_gprintf
	add	sp, #4
;src\battle.c:68: while ( wait = 1 ) {
00103$:
;src\battle.c:69: delay(200);
	ld	de, #0x00c8
	call	_delay
;src\battle.c:70: if ( joypad() & J_A ) {
	call	_joypad
	bit	4, a
	jr	Z, 00103$
;src\battle.c:71: delay(200);
	ld	de, #0x00c8
	call	_delay
;src\battle.c:72: clearText();
	call	_clearText
;src\battle.c:73: return 1;
	ld	a, #0x01
;src\battle.c:76: }
	inc	sp
	ret
___str_5:
	.ascii "%s IS DEAD!"
	.db 0x00
___str_6:
	.ascii "YOU GAIN %d XP!"
	.db 0x00
;src\battle.c:78: void battleClear( void ) {
;	---------------------------------
; Function battleClear
; ---------------------------------
_battleClear::
;src\battle.c:79: gotogxy( 0 , 0 );
	xor	a, a
	rrca
	push	af
	call	_gotogxy
	pop	hl
;src\battle.c:80: for (uint16_t i = 0 ; i < 360; i++) {
	ld	bc, #0x0000
00103$:
	ld	e, c
	ld	d, b
	ld	a, e
	sub	a, #0x68
	ld	a, d
	sbc	a, #0x01
	ret	NC
;src\battle.c:81: gprintf(" ");
	push	bc
	ld	de, #___str_7
	push	de
	call	_gprintf
	pop	hl
	pop	bc
;src\battle.c:80: for (uint16_t i = 0 ; i < 360; i++) {
	inc	bc
;src\battle.c:83: }
	jr	00103$
___str_7:
	.ascii " "
	.db 0x00
;src\battle.c:85: void inputSelection( uint8_t select ) {
;	---------------------------------
; Function inputSelection
; ---------------------------------
_inputSelection::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;src\battle.c:87: gotogxy(  1 , 16 );     gprintf( "Attack" ); 
	ld	hl, #0x1001
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_8
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:88: gotogxy( 11 , 16 );     gprintf( "Item" );
	ld	hl, #0x100b
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_9
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:89: gotogxy(  1 , 17 );     gprintf( "Special" );
	ld	hl, #0x1101
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_10
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:90: gotogxy( 11 , 17 );     gprintf( "Escape" );
	ld	hl, #0x110b
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_11
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:92: switch (select) {
	ldhl	sp,	#0
	ld	a, (hl)
	dec	a
	jr	Z, 00101$
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00102$
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x03
	jp	Z,00103$
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x04
	jp	Z,00104$
	jp	00106$
;src\battle.c:93: case 1 : 
00101$:
;src\battle.c:94: gotogxy(  0 , 16 ); gprintf( ">" );     gotogxy( 10 , 16 ); gprintf( " " );
	ld	hl, #0x1000
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_12
	push	de
	call	_gprintf
	pop	hl
	ld	hl, #0x100a
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:95: gotogxy(  0 , 17 ); gprintf( " " );     gotogxy( 10 , 17 ); gprintf( " " );
	ld	hl, #0x1100
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
	ld	hl, #0x110a
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:96: break;
	jp	00106$
;src\battle.c:98: case 2 : 
00102$:
;src\battle.c:99: gotogxy(  0 , 16 ); gprintf( " " );     gotogxy( 10 , 16 ); gprintf( ">" );
	ld	hl, #0x1000
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
	ld	hl, #0x100a
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_12
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:100: gotogxy(  0 , 17 ); gprintf( " " );     gotogxy( 10 , 17 ); gprintf( " " );
	ld	hl, #0x1100
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
	ld	hl, #0x110a
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:101: break;
	jp	00106$
;src\battle.c:103: case 3 : 
00103$:
;src\battle.c:104: gotogxy(  0 , 16 ); gprintf( " " );     gotogxy( 10 , 16 ); gprintf( " " );
	ld	hl, #0x1000
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
	ld	hl, #0x100a
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:105: gotogxy(  0 , 17 ); gprintf( ">" );     gotogxy( 10 , 17 ); gprintf( " " );
	ld	hl, #0x1100
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_12
	push	de
	call	_gprintf
	pop	hl
	ld	hl, #0x110a
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:106: break;
	jr	00106$
;src\battle.c:107: case 4 : 
00104$:
;src\battle.c:108: gotogxy(  0 , 16 ); gprintf( " " );     gotogxy( 10 , 16 ); gprintf( " " );
	ld	hl, #0x1000
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
	ld	hl, #0x100a
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:109: gotogxy(  0 , 17 ); gprintf( " " );     gotogxy( 10 , 17 ); gprintf( ">" );
	ld	hl, #0x1100
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_13
	push	de
	call	_gprintf
	pop	hl
	ld	hl, #0x110a
	push	hl
	call	_gotogxy
	pop	hl
	ld	de, #___str_12
	push	de
	call	_gprintf
	pop	hl
;src\battle.c:111: }
00106$:
;src\battle.c:112: }
	inc	sp
	ret
___str_8:
	.ascii "Attack"
	.db 0x00
___str_9:
	.ascii "Item"
	.db 0x00
___str_10:
	.ascii "Special"
	.db 0x00
___str_11:
	.ascii "Escape"
	.db 0x00
___str_12:
	.ascii ">"
	.db 0x00
___str_13:
	.ascii " "
	.db 0x00
;src\battle.c:114: void battle( Player * player , Enemy * enemy) { 
;	---------------------------------
; Function battle
; ---------------------------------
_battle::
	add	sp, #-23
	ldhl	sp,	#21
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#19
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\battle.c:115: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src\battle.c:116: uint8_t     state       = 1;
	ldhl	sp,	#16
	ld	(hl), #0x01
;src\battle.c:117: uint8_t     selection   = 1;
	ldhl	sp,	#0
	ld	(hl), #0x01
;src\battle.c:119: battleClear();
	call	_battleClear
;src\battle.c:120: enemyAppears(enemy -> name);
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_enemyAppears
;src\battle.c:122: while ( 1) {
	ldhl	sp,#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
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
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
00132$:
;src\battle.c:124: if (state == 1 ) { // Player Turn
	ldhl	sp,	#16
	ld	a, (hl)
	dec	a
	jp	NZ,00128$
;src\battle.c:126: battleWindowUpdate( player -> player_hp );
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#17
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_battleWindowUpdate
;src\battle.c:127: inputSelection(selection);        
	ldhl	sp,	#0
	ld	a, (hl)
	call	_inputSelection
;src\battle.c:128: gotogxy( 1 , 1); gprintf("%d", enemy -> hp);
	ld	hl, #0x101
	push	hl
	call	_gotogxy
	pop	hl
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	push	bc
	ld	de, #___str_14
	push	de
	call	_gprintf
	add	sp, #4
;src\battle.c:130: switch ( selection ) {
	ldhl	sp,	#0
	ld	a, (hl)
	dec	a
	jr	Z, 00101$
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x02
	jp	Z,00111$
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x03
	jp	Z,00116$
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x04
	jp	Z,00121$
	jp	00128$
;src\battle.c:131: case 1: // Attack          
00101$:
;src\battle.c:132: if (joypad() & J_RIGHT  ) { selection = 2; }
	call	_joypad
	rrca
	jr	NC, 00103$
	ldhl	sp,	#0
	ld	(hl), #0x02
00103$:
;src\battle.c:133: if (joypad() & J_DOWN   ) { selection = 3; }
	call	_joypad
	bit	3, a
	jr	Z, 00105$
	ldhl	sp,	#0
	ld	(hl), #0x03
00105$:
;src\battle.c:135: if ( joypad() & J_A ) {
	call	_joypad
	bit	4, a
	jp	Z,00128$
;src\battle.c:136: enemy -> hp = enemyHit(enemy -> name, enemy -> hp, player -> player_atk);
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	ld	b, l
	inc	sp
	ldhl	sp,	#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_enemyHit
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src\battle.c:137: if ( enemy -> hp < 1 )  { 
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, c
	sub	a, #0x01
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00107$
;src\battle.c:138: victory(enemy -> name , enemy -> xp );
	ldhl	sp,#19
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_victory
;src\battle.c:139: player -> xp        += enemy -> xp;
	ldhl	sp,#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#15
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src\battle.c:140: player -> steps     = 0;
	ldhl	sp,#21
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src\battle.c:141: return;
	jp	00134$
00107$:
;src\battle.c:143: else                    { state = 2;}
	ldhl	sp,	#16
	ld	(hl), #0x02
;src\battle.c:145: break;
	jr	00128$
;src\battle.c:147: case 2: // Item
00111$:
;src\battle.c:148: if ( joypad() & J_LEFT  ) { selection = 1; }
	call	_joypad
	bit	1, a
	jr	Z, 00113$
	ldhl	sp,	#0
	ld	(hl), #0x01
00113$:
;src\battle.c:149: if ( joypad() & J_DOWN  ) { selection = 4; }
	call	_joypad
	bit	3, a
	jr	Z, 00128$
	ldhl	sp,	#0
	ld	(hl), #0x04
;src\battle.c:150: break;
	jr	00128$
;src\battle.c:152: case 3: // Special            
00116$:
;src\battle.c:153: if ( joypad() & J_UP    ) { selection = 1; }
	call	_joypad
	bit	2, a
	jr	Z, 00118$
	ldhl	sp,	#0
	ld	(hl), #0x01
00118$:
;src\battle.c:154: if ( joypad() & J_RIGHT ) { selection = 4; }
	call	_joypad
	rrca
	jr	NC, 00128$
	ldhl	sp,	#0
	ld	(hl), #0x04
;src\battle.c:155: break;
	jr	00128$
;src\battle.c:157: case 4: // Escape
00121$:
;src\battle.c:158: if ( joypad() & J_UP    ) { selection = 2; }
	call	_joypad
	bit	2, a
	jr	Z, 00123$
	ldhl	sp,	#0
	ld	(hl), #0x02
00123$:
;src\battle.c:159: if ( joypad() & J_LEFT  ) { selection = 3; }
	call	_joypad
	bit	1, a
	jr	Z, 00128$
	ldhl	sp,	#0
	ld	(hl), #0x03
;src\battle.c:161: }
00128$:
;src\battle.c:164: if ( state == 2 ) {
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x02
	jp	NZ,00132$
;src\battle.c:165: enemyAttacks( enemy -> name , enemy -> attack );
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#19
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_enemyAttacks
;src\battle.c:166: player -> player_hp -= enemy -> attack;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#16
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#18
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#18
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	(de), a
	inc	de
;src\battle.c:167: state = 1;
	ld	a, (hl-)
	dec	hl
	ld	(de), a
	ld	(hl), #0x01
	jp	00132$
00134$:
;src\battle.c:174: }
	add	sp, #23
	ret
___str_14:
	.ascii "%d"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)

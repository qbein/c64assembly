.var continue_basic=$ea31
.var continue_short=$ea81

BasicUpstart2(start)

.const addr_sort_sprite_idx = $81
.const addr_sort_temp = $82
.const addr_sprite_idx = $83
.const addr_chunk_idx = $84

.const sprite_count = 32
.const grace_lines = 6
 
.const DEBUG = false

.macro DebugBg(color) {
    .if (DEBUG) {
        lda #color
        sta $d020
//        sta $d021
    }
}

*= $2000
sprite_circle:
    .byte $03, $AA, $C0
	.byte $06, $AA, $90
	.byte $0A, $AA, $A0
	.byte $1A, $AA, $A4
	.byte $2A, $AA, $A8
	.byte $EA, $AA, $AB
	.byte $6A, $AA, $A9
	.byte $6A, $AA, $A9
	.byte $AA, $AA, $AA
	.byte $AA, $AA, $AA
	.byte $AA, $AA, $AA
	.byte $AA, $AA, $AA
	.byte $AA, $AA, $AA
	.byte $6A, $AA, $A9
	.byte $6A, $AA, $A9
	.byte $EA, $AA, $AB
	.byte $2A, $AA, $A8
	.byte $1A, $AA, $A4
	.byte $0A, $AA, $A0
	.byte $06, $AA, $90
	.byte $03, $AA, $C0

sprite01:
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF


*= $C000

// Center position
// Center = (min + max) / 2
// Center X: (24 + 319) / 2 = 171.5 ≈ 172
// Center Y: (50 + 228) / 2 = 139
// Amplitude
// Amplitude = (max − min) / 2
// Amplitude X: (319 − 24) / 2 = 147.5 ≈ 148
// Amplitude Y: (228 − 50) / 2 = 89


// uv run main.py --wave 0.0,360,172,147,256 --wave 0,1080.0,0,50 --count 256 --suffix x --combine |pbcopy

pathx_lo:
    .byte $48,$4a,$4b,$4d,$4d,$4e,$4d,$4d
    .byte $4c,$4b,$49,$47,$45,$42,$3f,$3c
    .byte $39,$35,$32,$2e,$2a,$26,$22,$1e
    .byte $1a,$15,$11,$0d,$09,$05,$01,$fd
    .byte $f9,$f5,$f2,$ef,$ec,$e9,$e6,$e4
    .byte $e2,$e0,$df,$de,$dd,$dd,$dd,$de
    .byte $df,$e1,$e3,$e5,$e7,$ea,$ed,$f0
    .byte $f4,$f7,$fb,$ff,$02,$06,$0a,$0e
    .byte $12,$15,$19,$1c,$1f,$22,$25,$27
    .byte $29,$2b,$2c,$2d,$2e,$2e,$2d,$2c
    .byte $2b,$29,$28,$25,$23,$20,$1d,$1a
    .byte $17,$14,$10,$0d,$09,$06,$02,$ff
    .byte $fb,$f8,$f5,$f2,$ef,$ed,$ea,$e8
    .byte $e7,$e5,$e4,$e3,$e2,$e1,$e0,$e0
    .byte $df,$de,$dd,$db,$d9,$d7,$d5,$d2
    .byte $d0,$cd,$ca,$c6,$c3,$bf,$bc,$b8
    .byte $b5,$b1,$ae,$aa,$a7,$a3,$a0,$9d
    .byte $9b,$98,$96,$94,$92,$90,$8f,$8e
    .byte $8d,$8d,$8c,$8b,$8a,$89,$88,$86
    .byte $85,$83,$80,$7e,$7b,$78,$75,$72
    .byte $6e,$6b,$67,$64,$60,$5d,$59,$56
    .byte $53,$50,$4d,$4a,$48,$45,$44,$42
    .byte $41,$40,$3f,$3f,$40,$41,$42,$44
    .byte $46,$48,$4b,$4e,$51,$54,$58,$5b
    .byte $5f,$63,$67,$6b,$6e,$72,$76,$79
    .byte $7d,$80,$83,$86,$88,$8a,$8c,$8e
    .byte $8f,$90,$90,$90,$8f,$8e,$8d,$8b
    .byte $89,$87,$84,$81,$7e,$7b,$78,$74
    .byte $70,$6c,$68,$64,$60,$5c,$58,$53
    .byte $4f,$4b,$47,$43,$3f,$3b,$38,$34
    .byte $31,$2e,$2b,$28,$26,$24,$22,$21
    .byte $20,$20,$1f,$20,$20,$22,$23,$26

pathx_hi:
    .byte $01,$01,$01,$01,$01,$01,$01,$01
    .byte $01,$01,$01,$01,$01,$01,$01,$01
    .byte $01,$01,$01,$01,$01,$01,$01,$01
    .byte $01,$01,$01,$01,$01,$01,$01,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$01,$01,$01,$01
    .byte $01,$01,$01,$01,$01,$01,$01,$01
    .byte $01,$01,$01,$01,$01,$01,$01,$01
    .byte $01,$01,$01,$01,$01,$01,$01,$01
    .byte $01,$01,$01,$01,$01,$01,$01,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00
    .byte $00,$00,$00,$00,$00,$00,$00,$00

pathy:
    .byte $f4,$f1,$ed,$ea,$e7,$e4,$e1,$de
    .byte $db,$d8,$d6,$d4,$d1,$cf,$cd,$cb
    .byte $c9,$c7,$c6,$c4,$c2,$c1,$bf,$be
    .byte $bd,$bb,$ba,$b9,$b8,$b7,$b6,$b5
    .byte $b4,$b3,$b2,$b1,$b0,$af,$ae,$ad
    .byte $ac,$ac,$ab,$aa,$a9,$a8,$a7,$a6
    .byte $a5,$a4,$a2,$a1,$a0,$9f,$9e,$9d
    .byte $9b,$9a,$99,$98,$96,$95,$94,$92
    .byte $91,$90,$8f,$8d,$8c,$8b,$8a,$88
    .byte $87,$86,$85,$83,$82,$81,$80,$7f
    .byte $7e,$7d,$7b,$7a,$79,$78,$77,$76
    .byte $74,$73,$72,$70,$6f,$6d,$6b,$6a
    .byte $68,$66,$64,$62,$60,$5e,$5b,$59
    .byte $56,$53,$50,$4e,$4b,$48,$45,$42
    .byte $3f,$3c,$3a,$37,$35,$33,$31,$30
    .byte $2e,$2d,$2c,$2b,$2a,$29,$29,$29
    .byte $29,$29,$29,$2a,$2b,$2c,$2d,$2e
    .byte $30,$31,$33,$35,$37,$3a,$3c,$3f
    .byte $42,$45,$48,$4b,$4e,$50,$53,$56
    .byte $59,$5b,$5e,$60,$62,$64,$66,$68
    .byte $6a,$6b,$6d,$6f,$70,$72,$73,$74
    .byte $76,$77,$78,$79,$7a,$7b,$7d,$7e
    .byte $7f,$80,$81,$82,$83,$85,$86,$87
    .byte $88,$8a,$8b,$8c,$8d,$8f,$90,$91
    .byte $92,$94,$95,$96,$98,$99,$9a,$9b
    .byte $9d,$9e,$9f,$a0,$a1,$a2,$a4,$a5
    .byte $a6,$a7,$a8,$a9,$aa,$ab,$ac,$ac
    .byte $ad,$ae,$af,$b0,$b1,$b2,$b3,$b4
    .byte $b5,$b6,$b7,$b8,$b9,$ba,$bb,$bd
    .byte $be,$bf,$c1,$c2,$c4,$c6,$c7,$c9
    .byte $cb,$cd,$cf,$d1,$d4,$d6,$d8,$db
    .byte $de,$e1,$e4,$e7,$ea,$ed,$f1,$f5
sprite_offsets:
    .fill sprite_count, i*8

sprite_visibility:
    .fill sprite_count, 0
/*
sinx_offset:
    .byte $0

// uv run main.py --wave 0.0,360,139,89,128 --count 128 --suffix=y|pbcopy
// uv run main.py --wave 0.0,360,139,89,256 --count 256 --suffix=y|pbcopy


siny:
    .byte $8B,$8E,$91,$94,$96,$99,$9C,$9F
    .byte $A2,$A4,$A7,$AA,$AC,$AF,$B2,$B4
    .byte $B7,$B9,$BC,$BE,$C0,$C2,$C5,$C7
    .byte $C9,$CB,$CD,$CF,$D1,$D2,$D4,$D6
    .byte $D7,$D9,$DA,$DB,$DC,$DD,$DF,$DF
    .byte $E0,$E1,$E2,$E2,$E3,$E3,$E4,$E4
    .byte $E4,$E4,$E4,$E4,$E4,$E3,$E3,$E2
    .byte $E2,$E1,$E0,$DF,$DF,$DD,$DC,$DB
    .byte $DA,$D9,$D7,$D6,$D4,$D2,$D1,$CF
    .byte $CD,$CB,$C9,$C7,$C5,$C2,$C0,$BE
    .byte $BC,$B9,$B7,$B4,$B2,$AF,$AC,$AA
    .byte $A7,$A4,$A2,$9F,$9C,$99,$96,$94
    .byte $91,$8E,$8B,$88,$85,$82,$80,$7D
    .byte $7A,$77,$74,$72,$6F,$6C,$6A,$67
    .byte $64,$62,$5F,$5D,$5A,$58,$56,$54
    .byte $51,$4F,$4D,$4B,$49,$47,$45,$44
    .byte $42,$40,$3F,$3D,$3C,$3B,$3A,$39
    .byte $37,$37,$36,$35,$34,$34,$33,$33
    .byte $32,$32,$32,$32,$32,$32,$32,$33
    .byte $33,$34,$34,$35,$36,$37,$37,$39
    .byte $3A,$3B,$3C,$3D,$3F,$40,$42,$44
    .byte $45,$47,$49,$4B,$4D,$4F,$51,$54
    .byte $56,$58,$5A,$5D,$5F,$62,$64,$67
    .byte $6A,$6C,$6F,$72,$74,$77,$7A,$7D
    .byte $80,$82,$85,$88


siny_offset:
    .byte $20
    */
sprite_idx:
    .byte $0
sprite_idx_offset:
    .fill sprite_count, i*5
sprite_pos_x:
    .fill sprite_count,0
sprite_pos_x_ub:
    .fill sprite_count,0
sprite_pos_y:
    .fill sprite_count,0

sprite_pos_buffer_x:
    .fill sprite_count,0
sprite_pos_buffer_x_ub:
    .fill sprite_count,0
sprite_pos_buffer_y:
    .fill sprite_count,0


.align $10
sprite_order:
    .fill sprite_count,0

*= $0810
start:
    jsr clear_screen
    jsr init_sprites
    
    lda #0
    sta addr_sprite_idx
    sta addr_chunk_idx

    jsr update_next_sprite_position

    sei

    // disable CIA interrupts:
    lda #%01111111
    sta $dc0d
    sta $dd0d

    // select VIC bank 0 ($0000-$3FFF)
    lda #%00000011
    sta $dd00

    // turn screen on, 25-row text mode
    lda #%00011011
    sta $d011
    // standard horizontal scroll
    lda #%00001000
    sta $d016 

    // update_sprite_position at end of render
    lda #$0
    sta $d012

    // use hardware vectors for setting interrupt
    lda #<irq_demo_main
    sta $fffe
    lda #>irq_demo_main
    sta $ffff

    // enable raster IRQ
    lda #%00000001
    sta $d01a

    // keep IO on, but switch out BASIC+KERNAL
    lda #%00110101
    sta $01

    cli
    jmp *
    
clear_screen:
    lda #$20
    ldx #0
!:   
    sta $0400,x
    sta $0500,x
    sta $0600,x
    sta $0700,x
    dex
    bne !-

    lda #BLUE
    sta $d020
    lda #BLACK
    sta $d021

    rts

init_sprites:
    lda #%11111111
    sta $d015

    lda #$ff
    sta $d01b

    // position all sprites out of view
    ldx #0
    lda #0
!:
    sta $d000, x
    inx
    cpx #8
    bne !-

    lda #50
    sta $d001    
    sta $d000    

    // sprite data in $2000 (0x80 * 64)
    lda #$80
    ldx #0
!:
    sta $07f8, x
    inx
    cpx #8
    bne !-

    lda #$ff
    sta $d01c

    // set sprite colors
    ldx #0
    lda #CYAN
!:
    sta $d027, x
    inx
    cpx #8
    bne !-

.if (DEBUG) {
    lda #WHITE  
    sta $d027
    sta $d028
    sta $d029
    sta $d02a
}

    // set multi color 1
    lda #GREEN
    sta $d025

    // set multi color 2
    lda #BROWN
    sta $d026

    jsr reset_sprite_order

    rts

colors:
    .byte 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4
    .byte 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8

phase_y:
    .byte 1,1,0,1,0,1,1,0

reset_sprite_order:
    // initialize sprite order array
    ldx #0 
!:
    txa
    sta sprite_order, x
    inx
    cpx #sprite_count
    bne !-
    
    rts

ub_mask_set:
    .byte %00000001
    .byte %00000010
    .byte %00000100
    .byte %00001000
    .byte %00010000
    .byte %00100000
    .byte %01000000
    .byte %10000000
ub_mask_unset:
    .byte %11111110
    .byte %11111101
    .byte %11111011
    .byte %11110111
    .byte %11101111
    .byte %11011111
    .byte %10111111
    .byte %01111111
tmp:
    .byte 0
    
irq_sprite_move:
    lda #$01
    sta $d019

    DebugBg(WHITE)

move_next_sprite:
    lda addr_sprite_idx
    tax
    and #%0000111
    tay
    sty tmp

    lda sprite_order, x
    tax
    // x = sw sprite index

    tya
    asl
    tay
    // y = hw sprite position offset

    //ldx addr_sprite_idx
    //lda sprite_order, x
    //tax

    lda sprite_pos_buffer_x, x
    sta $d000, y

    lda sprite_pos_buffer_y, x
    sta $d000+1, y

    ldy tmp
    lda sprite_pos_buffer_x_ub, x
    cmp #1
    beq !set+
!unset:
    lda ub_mask_unset, y
    and $d010
    sta $d010
    jmp !ub_done+
!set:
    lda ub_mask_set, y
    ora $d010
    sta $d010
!ub_done:

    /*
    lda sprite_pos_data_x_ub, x
    sta $d010
    */

    inc addr_sprite_idx
    lda addr_sprite_idx
    cmp #sprite_count

    bne !+
    
    //jsr update_next_sprite_position

    lda $d012
    adc #2
    sta $d012

    lda #<irq_demo_main
    sta $fffe
    lda #>irq_demo_main
    sta $ffff
    
    jmp !done+
    
!done:
    DebugBg(0)

    rti
    /*
    ldx sprite_order
    lda sprite_pos_y, x
    sbc #1 // make sure we have time to move sprite before it renders

    jmp !set_irq+
*/
    //jmp !++
!:

    ldx addr_sprite_idx
    lda sprite_order, x
    tax
    lda sprite_pos_y, x
    sbc #grace_lines

    cmp $d012
    bcc !move_next+
    beq !move_next+

!set_irq:
    sta $d012

    DebugBg(0)

    rti

!move_next:
    jmp move_next_sprite

frame_cnt:
    .byte 0

irq_demo_main:
    lda #$01
    sta $d019

    DebugBg(RED)

    jsr update_next_sprite_position

    ldx #0
    stx addr_sprite_idx
    ldy sprite_order, x
    lda sprite_pos_y, y
    sbc #grace_lines

    sta $d012
    
    lda #<irq_sprite_move
    sta $fffe
    lda #>irq_sprite_move
    sta $ffff

    inc frame_cnt

    DebugBg(BLACK)

    rti

one:
    .byte 1
zero:
    .byte 0

update_next_sprite_position:
    ldx #0

update_sprite_position:
    ldy sprite_offsets, x
    lda pathx_lo, y
    sta sprite_pos_x, x 
    lda pathx_hi, y
    sta sprite_pos_x_ub, x 
    lda pathy, y
    sta sprite_pos_y, x 
    
    inc sprite_offsets, x

    inx
    cpx #sprite_count
    bne update_sprite_position

sort_sprites:
    DebugBg(GREEN)

    // now lets sort sprites by y position
    ldx #1
    stx addr_sort_sprite_idx

sort_sprites__outer:
    // break if we've handeled all sprites
    ldx addr_sort_sprite_idx
    cpx #sprite_count
    beq sort_sprites__done
    
sort_sprites__compare_x:
    ldy sprite_order, x
    lda sprite_pos_y, y

    ldy sprite_order-1, x
    cmp sprite_pos_y, y

    bcc sort_sprites__swap_order

    inc addr_sort_sprite_idx
    jmp sort_sprites__outer

sort_sprites__swap_order:
    lda sprite_order, x
    ldy sprite_order-1, x

    sta sprite_order-1, x
    tya
    sta sprite_order, x
    dex
    cpx #0
    beq sort_sprites__outer
    jmp sort_sprites__compare_x

sort_sprites__done:
    DebugBg(CYAN)

    lda #0
    sta addr_sort_temp

prepare_buffer:
    DebugBg(YELLOW)

    ldx #0
!:
    lda sprite_pos_x, x
    sta sprite_pos_buffer_x, x
    lda sprite_pos_x_ub, x
    sta sprite_pos_buffer_x_ub, x
    lda sprite_pos_y, x
    sta sprite_pos_buffer_y, x
    inx
    cpx #sprite_count
    bne !-

    rts

.macro AddAccAndWrapIdx(add_addr, len) {
    clc
    adc add_addr

    cmp #len
    bcc !+
    sec
    sbc #len
!:
}

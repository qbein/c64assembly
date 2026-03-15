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


sinx:
    .byte $AC,$B5,$BE,$C8,$D1,$D9,$E2,$EB
    .byte $F3,$FB,$02,$0A,$11,$17,$1D,$23
    .byte $28,$2D,$31,$35,$38,$3B,$3D,$3F
    .byte $40,$40,$40,$40,$3F,$3E,$3C,$3A
    .byte $37,$34,$31,$2D,$29,$25,$20,$1B
    .byte $17,$11,$0C,$07,$02,$FC,$F7,$F2
    .byte $EC,$E7,$E2,$DE,$D9,$D5,$D1,$CD
    .byte $CA,$C7,$C4,$C2,$C0,$BF,$BE,$BD
    .byte $BD,$BD,$BE,$BF,$C0,$C2,$C4,$C7
    .byte $CA,$CD,$D1,$D5,$D9,$DE,$E2,$E7
    .byte $EC,$F2,$F7,$FC,$02,$07,$0C,$11
    .byte $17,$1B,$20,$25,$29,$2D,$31,$34
    .byte $37,$3A,$3C,$3E,$3F,$40,$40,$40
    .byte $40,$3F,$3D,$3B,$38,$35,$31,$2D
    .byte $28,$23,$1D,$17,$11,$0A,$02,$FB
    .byte $F3,$EB,$E2,$D9,$D1,$C8,$BE,$B5
    .byte $AC,$A3,$9A,$90,$87,$7F,$76,$6D
    .byte $65,$5D,$56,$4E,$47,$41,$3B,$35
    .byte $30,$2B,$27,$23,$20,$1D,$1B,$19
    .byte $18,$18,$18,$18,$19,$1A,$1C,$1E
    .byte $21,$24,$27,$2B,$2F,$33,$38,$3D
    .byte $41,$47,$4C,$51,$56,$5C,$61,$66
    .byte $6C,$71,$76,$7A,$7F,$83,$87,$8B
    .byte $8E,$91,$94,$96,$98,$99,$9A,$9B
    .byte $9B,$9B,$9A,$99,$98,$96,$94,$91
    .byte $8E,$8B,$87,$83,$7F,$7A,$76,$71
    .byte $6C,$66,$61,$5C,$56,$51,$4C,$47
    .byte $41,$3D,$38,$33,$2F,$2B,$27,$24
    .byte $21,$1E,$1C,$1A,$19,$18,$18,$18
    .byte $18,$19,$1B,$1D,$20,$23,$27,$2B
    .byte $30,$35,$3B,$41,$47,$4E,$56,$5D
    .byte $65,$6D,$76,$7F,$87,$90,$9A,$A3

sinx_ub:
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0


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

    // load and set y position
    lda siny_offset
    AddAccAndWrapIdx(one, 196)
    sta siny_offset

    lda sinx_offset
    AddAccAndWrapIdx(one, 256)
    sta sinx_offset
    
    ldx #0

update_sprite_position:
    // x-position

    lda sinx_offset
    clc
    adc sprite_idx_offset, x

    // wrap around if we've overflowed the sin data
    //and #255
    AddAccAndWrapIdx(zero, 256)
    
    tay

    lda sinx, y
    sta sprite_pos_x, x

    lda sinx_ub, y
    sta sprite_pos_x_ub, x
    
    // y-position
    lda siny_offset
    clc
    adc sprite_idx_offset, x
    
    AddAccAndWrapIdx(zero, 196)

    //and #255
    tay
    
    lda siny, y
    sta sprite_pos_y, x

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

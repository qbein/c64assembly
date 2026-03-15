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
    .byte $AC,$B5,$BF,$C8,$D1,$DA,$E2,$EB
    .byte $F3,$FB,$03,$0A,$11,$17,$1D,$22
    .byte $27,$2B,$2F,$32,$35,$37,$39,$3A
    .byte $3B,$3A,$3A,$39,$37,$35,$32,$2F
    .byte $2B,$27,$23,$1E,$19,$14,$0E,$08
    .byte $02,$FC,$F6,$EF,$E9,$E2,$DC,$D6
    .byte $D0,$CA,$C4,$BE,$B9,$B4,$B0,$AB
    .byte $A7,$A4,$A1,$9E,$9C,$9A,$99,$98
    .byte $98,$98,$99,$9A,$9C,$9E,$A1,$A4
    .byte $A7,$AB,$B0,$B4,$B9,$BE,$C4,$CA
    .byte $D0,$D6,$DC,$E2,$E9,$EF,$F6,$FC
    .byte $02,$08,$0E,$14,$19,$1E,$23,$27
    .byte $2B,$2F,$32,$35,$37,$39,$3A,$3A
    .byte $3B,$3A,$39,$37,$35,$32,$2F,$2B
    .byte $27,$22,$1D,$17,$11,$0A,$03,$FB
    .byte $F3,$EB,$E2,$DA,$D1,$C8,$BF,$B5
    .byte $AC,$A3,$99,$90,$87,$7E,$76,$6D
    .byte $65,$5D,$55,$4E,$47,$41,$3B,$36
    .byte $31,$2D,$29,$26,$23,$21,$1F,$1E
    .byte $1D,$1E,$1E,$1F,$21,$23,$26,$29
    .byte $2D,$31,$35,$3A,$3F,$44,$4A,$50
    .byte $56,$5C,$62,$69,$6F,$76,$7C,$82
    .byte $88,$8E,$94,$9A,$9F,$A4,$A8,$AD
    .byte $B1,$B4,$B7,$BA,$BC,$BE,$BF,$C0
    .byte $C0,$C0,$BF,$BE,$BC,$BA,$B7,$B4
    .byte $B1,$AD,$A8,$A4,$9F,$9A,$94,$8E
    .byte $88,$82,$7C,$76,$6F,$69,$62,$5C
    .byte $56,$50,$4A,$44,$3F,$3A,$35,$31
    .byte $2D,$29,$26,$23,$21,$1F,$1E,$1E
    .byte $1D,$1E,$1F,$21,$23,$26,$29,$2D
    .byte $31,$36,$3B,$41,$47,$4E,$55,$5D
    .byte $65,$6D,$76,$7E,$87,$90,$99,$A3

sinx_ub:
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
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
    .byte $8B,$8F,$94,$98,$9C,$A1,$A5,$A9
    .byte $AD,$B1,$B5,$B9,$BC,$C0,$C3,$C7
    .byte $CA,$CD,$D0,$D2,$D5,$D7,$D9,$DB
    .byte $DD,$DF,$E0,$E1,$E2,$E3,$E4,$E4
    .byte $E4,$E4,$E4,$E3,$E2,$E1,$E0,$DF
    .byte $DD,$DB,$D9,$D7,$D5,$D2,$D0,$CD
    .byte $CA,$C7,$C3,$C0,$BC,$B9,$B5,$B1
    .byte $AD,$A9,$A5,$A1,$9C,$98,$94,$8F
    .byte $8B,$87,$82,$7E,$7A,$75,$71,$6D
    .byte $69,$65,$61,$5D,$5A,$56,$53,$4F
    .byte $4C,$49,$46,$44,$41,$3F,$3D,$3B
    .byte $39,$37,$36,$35,$34,$33,$32,$32
    .byte $32,$32,$32,$33,$34,$35,$36,$37
    .byte $39,$3B,$3D,$3F,$41,$44,$46,$49
    .byte $4C,$4F,$53,$56,$5A,$5D,$61,$65
    .byte $69,$6D,$71,$75,$7A,$7E,$82,$87

siny_offset:
    .byte $40
sprite_idx:
    .byte $0
sprite_idx_offset:
    .fill sprite_count, i*4
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

irq_demo_main:
    lda #$01
    sta $d019
.break

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

    DebugBg(RED)

    jsr update_next_sprite_position

    DebugBg(BLACK)

    rti

update_next_sprite_position:

    // load and set y position
    AddAndWrapIdx(siny_offset, 1, 128)
    AddAndWrapIdx(sinx_offset, 1, 256)
    
    ldx #0

update_sprite_position:
    // x-position

    lda sinx_offset
    clc
    adc sprite_idx_offset, x

    // wrap around if we've overflowed the sin data
    and #255
    tay

    lda sinx, y
    sta sprite_pos_x, x

    lda sinx_ub, y
    sta sprite_pos_x_ub, x
    
    // y-position
    lda siny_offset
    clc
    adc sprite_idx_offset, x
    
    and #127
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
    DebugBg(BROWN)

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

.macro AddAndWrapIdx(addr, increment, len) {
    lda addr
    adc #increment

    // wrap around if we've overflowed the sin data
    cmp #len
    bmi !+
    sbc #len
!:
    sta addr
}

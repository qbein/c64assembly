.var continue_basic=$ea31
.var continue_short=$ea81

BasicUpstart2(start)

.const addr_sort_sprite_idx = $81
.const addr_sort_temp = $82
.const addr_sprite_pos_idx = $83
.const addr_chunk_idx = $84

.const sprite_count = 24
 
.const DEBUG = false

.macro DebugBg(color) {
    .if (DEBUG) {
        lda #color
        sta $d020
        sta $d021
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
    .byte $AC,$B3,$BB,$C2,$C9,$D0,$D7,$DE
    .byte $E4,$EB,$F1,$F7,$FD,$03,$08,$0E
    .byte $12,$17,$1B,$1F,$23,$26,$2A,$2C
    .byte $2F,$31,$33,$34,$35,$36,$37,$37
    .byte $37,$37,$37,$36,$35,$34,$33,$32
    .byte $30,$2E,$2D,$2B,$29,$27,$25,$23
    .byte $21,$1F,$1D,$1B,$19,$17,$16,$14
    .byte $13,$11,$10,$0F,$0E,$0E,$0D,$0D
    .byte $0D,$0D,$0D,$0E,$0E,$0F,$10,$11
    .byte $13,$14,$16,$17,$19,$1B,$1D,$1F
    .byte $21,$23,$25,$27,$29,$2B,$2D,$2E
    .byte $30,$32,$33,$34,$35,$36,$37,$37
    .byte $37,$37,$37,$36,$35,$34,$33,$31
    .byte $2F,$2C,$2A,$26,$23,$1F,$1B,$17
    .byte $12,$0E,$08,$03,$FD,$F7,$F1,$EB
    .byte $E4,$DE,$D7,$D0,$C9,$C2,$BB,$B3
    .byte $AC,$A5,$9D,$96,$8F,$88,$81,$7A
    .byte $74,$6D,$67,$61,$5B,$55,$50,$4A
    .byte $46,$41,$3D,$39,$35,$32,$2E,$2C
    .byte $29,$27,$25,$24,$23,$22,$21,$21
    .byte $21,$21,$21,$22,$23,$24,$25,$26
    .byte $28,$2A,$2B,$2D,$2F,$31,$33,$35
    .byte $37,$39,$3B,$3D,$3F,$41,$42,$44
    .byte $45,$47,$48,$49,$4A,$4A,$4B,$4B
    .byte $4B,$4B,$4B,$4A,$4A,$49,$48,$47
    .byte $45,$44,$42,$41,$3F,$3D,$3B,$39
    .byte $37,$35,$33,$31,$2F,$2D,$2B,$2A
    .byte $28,$26,$25,$24,$23,$22,$21,$21
    .byte $21,$21,$21,$22,$23,$24,$25,$27
    .byte $29,$2C,$2E,$32,$35,$39,$3D,$41
    .byte $46,$4A,$50,$55,$5B,$61,$67,$6D
    .byte $74,$7A,$81,$88,$8F,$96,$9D,$A5

sinx_ub:
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,0,0,0,0
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
    .byte $0
sprite_idx:
    .byte $0
sprite_idx_offset:
    .fill 32, i*5
sprite_pos_x:
    .fill 32,0
sprite_pos_x_ub:
    .fill 32,0
sprite_pos_y:
    .fill 32,0

.align $10
sprite_order:
    .fill 32,0

.align $10
sprite_pos_data:
    .fill sprite_count*2,0
.align $10
sprite_pos_data_x_ub:
    .fill 12,0
ub_offset:
    .byte 0
*= $0810
start:
    jsr clear_screen
    jsr init_sprites
    
    lda #0
    sta addr_sprite_pos_idx
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
    lda #$40
    sta $d012

    // use hardware vectors for setting interrupt
    lda #<irq_sprite_move
    sta $fffe
    lda #>irq_sprite_move
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
    lda #BLUE
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

irq_sprite_move:
    lda #$01
    sta $d019

    DebugBg(WHITE)

    lda addr_sprite_pos_idx
    txa
    
    and #4
    asl
    tay

    txa
    asl
    tax

    lda sprite_pos_data, x
    sta $D000, y
    lda sprite_pos_data+1, x
    sta $D001, y

    lda sprite_pos_data+2, x
    sta $D002, y
    lda sprite_pos_data+3, x
    sta $D003, y

    lda sprite_pos_data+4, x
    sta $D004, y
    lda sprite_pos_data+5, x
    sta $D005, y

    lda sprite_pos_data+6, x
    sta $D006, y
    lda sprite_pos_data+7, x
    sta $D007, y

    ldx ub_offset

    lda sprite_pos_data_x_ub, x
    sta $d010

    clc
    lda addr_sprite_pos_idx
    adc #4
    sta addr_sprite_pos_idx

    inc ub_offset

    cmp #sprite_count
    bcc !+
    lda #0
    sta addr_sprite_pos_idx
    sta ub_offset

    lda $D007, y
    adc #24
    sta $d012

    lda #<irq_update_sprite_positions
    sta $fffe
    lda #>irq_update_sprite_positions
    sta $ffff
    jmp !++
!:

    ldx addr_sprite_pos_idx
    ldy sprite_order, x
    lda sprite_pos_y, y
    sbc #5 // leave a few lines of raster time to reposition sprites

    sta $d012
!:
    DebugBg(0)

    rti

irq_update_sprite_positions:
    // ack interrupt
    lda #$01
    sta $d019

    DebugBg(RED)

    jsr update_next_sprite_position

    irq_update_sprite_positions__done:
    
    ldx addr_sprite_pos_idx
    ldy sprite_order, x
    lda sprite_pos_y, y
    sbc #5 // leave a few lines of raster time to reposition sprites

    sta $d012
    
    lda #<irq_sprite_move
    sta $fffe
    lda #>irq_sprite_move
    sta $ffff

    // reset border color
    DebugBg(BLACK)
    
    rti

increment:
    .byte $02,$02,$03,$03,$03,$03,$03,$02
    .byte $02,$02,$01,$01,$01,$01,$01,$02

render_idx:
    .byte 0

tmp:
    .byte 0

update_next_sprite_position:
    inc render_idx
    lda render_idx
    and #15

    tax
    lda increment, x
    sta tmp

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
    
    // wrap around if we've overflowed the sin data
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

prepare_sprite_position_data:
    lda #0
    sta addr_sort_temp
    ldx #0
!:
    ldy addr_sort_temp
    lda sprite_order, y
    tay

    lda sprite_pos_x, y
    sta sprite_pos_data, x
    lda sprite_pos_y, y
    sta sprite_pos_data+1, x

    inx
    inx
    inc addr_sort_temp
    lda addr_sort_temp
    cmp #sprite_count
    bne !-

prepare_sprite_x_msb_position_data:
    BuildSpriteXMsbChunk(sprite_pos_data_x_ub+1, $7)
    BuildSpriteXMsbChunk(sprite_pos_data_x_ub+3, $f)
    BuildSpriteXMsbChunk(sprite_pos_data_x_ub+5, $17)
    BuildSpriteXMsbChunk(sprite_pos_data_x_ub+7, $1f)
    BuildSpriteXMsbChunk(sprite_pos_data_x_ub+9, $27)
    BuildSpriteXMsbChunk(sprite_pos_data_x_ub+11, $2f)

    PackSpriteXMsbNibbles(sprite_pos_data_x_ub+11, sprite_pos_data_x_ub+1, sprite_pos_data_x_ub)
    PackSpriteXMsbNibbles(sprite_pos_data_x_ub+1, sprite_pos_data_x_ub+3, sprite_pos_data_x_ub+2)    
    PackSpriteXMsbNibbles(sprite_pos_data_x_ub+3, sprite_pos_data_x_ub+5, sprite_pos_data_x_ub+4)
    PackSpriteXMsbNibbles(sprite_pos_data_x_ub+5, sprite_pos_data_x_ub+7, sprite_pos_data_x_ub+6)
    PackSpriteXMsbNibbles(sprite_pos_data_x_ub+7, sprite_pos_data_x_ub+9, sprite_pos_data_x_ub+8)
    PackSpriteXMsbNibbles(sprite_pos_data_x_ub+9, sprite_pos_data_x_ub+11, sprite_pos_data_x_ub+10)

    rts

.macro BuildSpriteXMsbChunk(dstAddr, lastSpriteIdx) {
    lda #0
    sta dstAddr

    ldx #lastSpriteIdx+1
!loop:
    dex
    ldy sprite_order, x
    ora sprite_pos_x_ub, y
    cpx #lastSpriteIdx-7
    beq !done+
    asl
    jmp !loop-
!done:
    sta dstAddr
}

.macro PackSpriteXMsbNibbles(upperSrcAddr, lowerSrcAddr, dstAddr) {
    lda #0
    sta dstAddr

    lda upperSrcAddr
    and #%11110000
    sta dstAddr
    lda lowerSrcAddr
    and #%00001111
    ora dstAddr
    sta dstAddr
}

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

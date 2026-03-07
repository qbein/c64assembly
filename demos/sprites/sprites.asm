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

sinx:
    .byte $AB,$B4,$BD,$C6,$CF,$D8,$E0,$E8
    .byte $F1,$F8,$00,$07,$0E,$14,$1A,$1F
    .byte $24,$29,$2D,$31,$34,$36,$38,$3A
    .byte $3B,$3B,$3B,$3B,$3A,$38,$36,$34
    .byte $31,$2E,$2B,$27,$23,$1E,$1A,$15
    .byte $10,$0B,$05,$00,$FA,$F5,$F0,$EA
    .byte $E5,$E0,$DB,$D6,$D2,$CD,$C9,$C6
    .byte $C2,$BF,$BD,$BA,$B8,$B7,$B6,$B5
    .byte $B5,$B5,$B6,$B7,$B8,$BA,$BD,$BF
    .byte $C2,$C6,$C9,$CD,$D2,$D6,$DB,$E0
    .byte $E5,$EA,$F0,$F5,$FA,$00,$05,$0B
    .byte $10,$15,$1A,$1E,$23,$27,$2B,$2E
    .byte $31,$34,$36,$38,$3A,$3B,$3B,$3B
    .byte $3B,$3A,$38,$36,$34,$31,$2D,$29
    .byte $24,$1F,$1A,$14,$0E,$07,$00,$F8
    .byte $F1,$E8,$E0,$D8,$CF,$C6,$BD,$B4
    .byte $AB,$A2,$99,$90,$87,$7E,$76,$6E
    .byte $65,$5E,$56,$4F,$48,$42,$3C,$37
    .byte $32,$2D,$29,$25,$22,$20,$1E,$1C
    .byte $1B,$1B,$1B,$1B,$1C,$1E,$20,$22
    .byte $25,$28,$2B,$2F,$33,$38,$3C,$41
    .byte $46,$4B,$51,$56,$5C,$61,$66,$6C
    .byte $71,$76,$7B,$80,$84,$89,$8D,$90
    .byte $94,$97,$99,$9C,$9E,$9F,$A0,$A1
    .byte $A1,$A1,$A0,$9F,$9E,$9C,$99,$97
    .byte $94,$90,$8D,$89,$84,$80,$7B,$76
    .byte $71,$6C,$66,$61,$5C,$56,$51,$4B
    .byte $46,$41,$3C,$38,$33,$2F,$2B,$28
    .byte $25,$22,$20,$1E,$1C,$1B,$1B,$1B
    .byte $1B,$1C,$1E,$20,$22,$25,$29,$2D
    .byte $32,$37,$3C,$42,$48,$4F,$56,$5E
    .byte $65,$6E,$76,$7E,$87,$90,$99,$A2

sinx_ub:
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,1,1,1
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

siny:
    .byte $8C,$90,$95,$99,$9E,$A2,$A6,$AA
    .byte $AE,$B2,$B6,$BA,$BE,$C2,$C5,$C8
    .byte $CC,$CF,$D2,$D4,$D7,$D9,$DB,$DD
    .byte $DF,$E1,$E2,$E3,$E4,$E5,$E6,$E6
    .byte $E6,$E6,$E6,$E5,$E4,$E3,$E2,$E1
    .byte $DF,$DD,$DB,$D9,$D7,$D4,$D2,$CF
    .byte $CC,$C8,$C5,$C2,$BE,$BA,$B6,$B2
    .byte $AE,$AA,$A6,$A2,$9E,$99,$95,$90
    .byte $8C,$88,$83,$7F,$7A,$76,$72,$6E
    .byte $6A,$66,$62,$5E,$5A,$56,$53,$50
    .byte $4C,$49,$46,$44,$41,$3F,$3D,$3B
    .byte $39,$37,$36,$35,$34,$33,$32,$32
    .byte $32,$32,$32,$33,$34,$35,$36,$37
    .byte $39,$3B,$3D,$3F,$41,$44,$46,$49
    .byte $4C,$50,$53,$56,$5A,$5E,$62,$66
    .byte $6A,$6E,$72,$76,$7A,$7F,$83,$88
siny_offset:
    .byte $20
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
    lda #BLACK
    sta $d021

    rts

init_sprites:
    lda #%11111111
    sta $d015

    lda #$ff
    sta $d01b

    // set all sprite colors
    ldx #0
    lda #WHITE
!:
    sta $d027, x
    inx
    cpx #8
    bne !-

    lda #YELLOW
    sta $d027
    sta $d028
    sta $d029
    sta $d02a
    
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
    adc #22
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

render_idx:
    .byte 0

update_next_sprite_position:
    inc render_idx
    lda render_idx
    and 1
    bne !+
    // load and set y position
    inc siny_offset
    lda #0
    sta render_idx
!:
    ldx siny_offset
    // wrap around if we've overflowed the sin data
    cpx #127
    bne !+
    ldx #0
    stx siny_offset
!:

    // load and set x position
    inc sinx_offset
    inx
    // wrap around if we've overflowed the sin data
    cpx #256
    bne !+
    ldx #0
    stx sinx_offset
!:

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

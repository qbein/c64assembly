.var continue_basic=$ea31
.var continue_short=$ea81

BasicUpstart2(start)

.const addr_sort_sprite_idx = $81
.const addr_sort_temp = $82
.const addr_sprite_pos_idx = $83
.const addr_chunk_idx = $84

.const color_bg = $0

.const sprite_count = 16

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
    .byte $AB,$B2,$BA,$C1,$C8,$CF,$D6,$DD
    .byte $E4,$EA,$F1,$F7,$FD,$03,$09,$0E
    .byte $14,$19,$1D,$22,$26,$2A,$2E,$31
    .byte $34,$36,$39,$3B,$3C,$3D,$3E,$3F
    .byte $3F,$3F,$3E,$3D,$3C,$3B,$39,$36
    .byte $34,$31,$2E,$2A,$26,$22,$1D,$19
    .byte $14,$0E,$09,$03,$FD,$F7,$F1,$EA
    .byte $E4,$DD,$D6,$CF,$C8,$C1,$BA,$B2
    .byte $AB,$A4,$9C,$95,$8E,$87,$80,$79
    .byte $72,$6C,$65,$5F,$59,$53,$4D,$48
    .byte $42,$3D,$39,$34,$30,$2C,$28,$25
    .byte $22,$20,$1D,$1B,$1A,$19,$18,$17
    .byte $17,$17,$18,$19,$1A,$1B,$1D,$20
    .byte $22,$25,$28,$2C,$30,$34,$39,$3D
    .byte $42,$48,$4D,$53,$59,$5F,$65,$6C
    .byte $72,$79,$80,$87,$8E,$95,$9C,$A4
sinx_ub:
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,1,1,1
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

sinx_offset:
    .byte $0

siny:
/*
    .byte $8B,$91,$97,$9C,$A2,$A8,$AD,$B2
    .byte $B8,$BC,$C1,$C6,$CA,$CE,$D2,$D5
    .byte $D8,$DB,$DD,$DF,$E1,$E2,$E3,$E4
    .byte $E4,$E4,$E3,$E2,$E1,$DF,$DD,$DB
    .byte $D8,$D5,$D2,$CE,$CA,$C6,$C1,$BC
    .byte $B7,$B2,$AD,$A8,$A2,$9C,$97,$91
    .byte $8B,$85,$7F,$7A,$74,$6E,$69,$64
    .byte $5F,$5A,$55,$50,$4C,$48,$44,$41
    .byte $3E,$3B,$39,$37,$35,$34,$33,$32
    .byte $32,$32,$33,$34,$35,$37,$39,$3B
    .byte $3E,$41,$44,$48,$4C,$50,$55,$5A
    .byte $5E,$64,$69,$6E,$74,$7A,$7F,$85
*/
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
    .fill 16, i*5
sprite_pos_x:
    .fill 16,0
sprite_pos_x_ub:
    .fill 16,0
sprite_pos_y:
    .fill 16,0
sprite_order:
    .fill 16,0

.align $100
sprite_pos_data:
    .fill 34,0

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
    lda #$ff
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

    lda color_bg
    sta $d020
    sta $d021

    rts

init_sprites:
    lda #%11111111
    sta $d015

    lda #$ff
    sta $d01b

    // set all sprite colors
    ldx #0
    lda #BROWN
!:
    sta $d027, x
    inx
    cpx #8
    bne !-
    
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
    
    rts

colors:
    .byte 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4
    .byte 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8

irq_sprite_move:
    lda #$01
    sta $d019

    lda addr_sprite_pos_idx
    tax

    lda colors, x
    sta $d020
    sta $d021

    txa
    
    and #4
    asl
    tay

    txa
    asl
    tax

.break

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


/*
    ldx #0
    lda addr_sprite_pos_idx
    cmp #$10

    bcc !+
    inx
!:
*/
    //lda sprite_pos_data+sprite_count*2, x
    //sta $d010

    // lda #0
    // sta $D010

    clc
    lda addr_sprite_pos_idx
    adc #4
    sta addr_sprite_pos_idx

    // load correct up data for sprites


    cmp #sprite_count
    bcc !+
    beq !+
    lda #0
    sta addr_sprite_pos_idx

    //jsr update_sprite_position
!:


    tax
    ldy sprite_order, x
    lda sprite_pos_y, y
    //sbc #30 // leave a few lines of raster time to reposition sprites

    sta $d012
    
    

    /*lda #200
    sta $d012

    lda #<irq_update_sprite_positions
    sta $fffe
    lda #>irq_update_sprite_positions
    sta $ffff
    */

!:
    lda #BLACK
    sta $d020
    sta $d021

    rti

irq_update_sprite_positions:
    // ack interrupt
    lda #$01
    sta $d019

    lda #RED
    sta $d020
    sta $d021

    jsr update_next_sprite_position

    irq_update_sprite_positions__done:
    lda #41
    sta $d012

    lda #<irq_sprite_move
    sta $fffe
    lda #>irq_sprite_move
    sta $ffff

    // reset border color
    lda #BLACK
    sta $d020
    sta $d021

    rti

update_next_sprite_position:
    // load and set y position
    inc siny_offset
    ldx siny_offset
    // wrap around if we've overflowed the sin data
    cpx #127
    bne !+
    ldx #0
    stx siny_offset
!:

    // load and set x position
    inc sinx_offset
    ldx sinx_offset
    inx
    // wrap around if we've overflowed the sin data
    cpx #128
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
    and #127
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
    lda #GREEN
    sta $d020
    sta $d021

    // initialize sprite order array
    ldx #0 
!:
    txa
    sta sprite_order, x
    inx
    cpx #sprite_count
    bne !-

    // now lets sort sprites by y position
    ldx #1
    stx addr_sort_sprite_idx

sort_sprites__outer:
    // break if we've handeled all sprites
    ldx addr_sort_sprite_idx
    cpx #sprite_count+1
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
    jmp sort_sprites__compare_x

tmp:
    .byte $0
bitmask:
    .byte $01,$02,$04,$08,$10,$20,$40,$80
invmask:
    .byte $FE,$FD,$FB,$F7,$EF,$DF,$BF,$7F
sort_sprites__done:

    lda #CYAN
    sta $D020
    sta $D021

    // prepare sprite position data
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

/*
// Try to fix UB!
    lda sprite_pos_x_ub, y
    beq !clear+
!set:
    lda tmp
    ora bitmask, y
    sta tmp
    jmp !+
!clear:
    lda tmp
    and invmask, y
    sta tmp
!:
    inx
    inx
    inc addr_sort_temp

    lda addr_sort_temp
    and #8
    beq !+

    lda tmp
    sta sprite_pos_data+17,  

!:
*/
    inx
    inx
    inc addr_sort_temp
    lda addr_sort_temp
    cmp #sprite_count
    bne !-

    // prepare ub byte chunks
    lda #0
    ldx #7
!:
    asl
    ldy sprite_order, x
    ora sprite_pos_x_ub, y
    //ora sprite_pos_data+sprite_count*2, y
    dex
    bpl !-

    sta sprite_pos_data+sprite_count*2

    // next chunk
    lda #0
    ldx #$f
!:
    asl
    ldy sprite_order, x
    ora sprite_pos_x_ub, y
    dex
    cpx #8
    bpl !-

    sta sprite_pos_data+sprite_count*2+1

    rts
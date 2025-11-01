.var continue_basic=$ea31
.var continue_short=$ea81

BasicUpstart2(start)

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

siny_offset:
    .byte $0
sprite_idx:
    .byte $0
sprite_idx_offset:
    .byte 0,5,10,15,20,25,30,35,40
color_bg:
    .byte $0
color_timing:
    .byte $b
color_sprite:
    .byte $6
sprite_count:
    .byte $10
sprite_x:
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
sprite_x_ub:
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
sprite_y:
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
sprite_order:
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


*= $0810
start:
    jsr clear_screen
    jsr init_sprites

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
    lda #<render_next_8_sprites
    sta $fffe
    lda #>render_next_8_sprites
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

    // set all sprite colors
    ldx #0
    lda color_sprite
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

render_next_8_sprites:
    // ack interrupt
    lda #$01
    sta $d019

    lda sprite_x
    cmp #0
    beq update_sprites

    // reset sprite x upper bits

    ldx #0
    stx $d010
    
move_sprites:
    // multiply sprite index with 2 for correct sprite pos offset
    txa
    asl
    tay

    lda sprite_x, x
    sta $d000, y

    tya
    pha

    // set x pos high bit 
    lda sprite_x_ub, x

    // copy sprite index to y
    pha
    txa
    tay
    pla
!: 
    cpy #0
    beq !+
    dey
    asl
    jmp !-
!:   
    ora $d010
    sta $d010

    pla
    tay

    lda sprite_y, x
    sta $d001, y

    inx
    cpx #8
    bne move_sprites

    // if we're done rendering, calculate new sprite positions for next raster
update_sprites:
    jsr update_sprite_positions
    rti

update_sprite_positions:
    // ack interrupt
    //lda #$01
    //sta $d019

    // set border color
    lda color_timing
    sta $d020

    // load and set y position
    ldx siny_offset
    inx
    // wrap around if we've overflowed the sin data
    cpx #96
    bne !+
    ldx #0
!:
    stx siny_offset

    // load and set x position
    ldx sinx_offset
    inx
    // wrap around if we've overflowed the sin data
    cpx #128
    bne !+
    ldx #0
!:
    stx sinx_offset

    // x now holds next x offset

    lda #0
    sta sprite_idx

sprite_loop:
    // x-position
    lda sinx_offset
    clc
    ldx sprite_idx
    adc sprite_idx_offset, x
    tax
    
    // wrap around if we've overflowed the sin data
    cmp #128
    bcc !+
    sbc #128
!:

    cmp #128
    bne !+
    lda #0
!:
    // move sin offset index to x
    tax

    // multiply sprite index with 2 for correct sprite pos offset
    ldy sprite_idx
    
    // y holds sprites x position offset
    lda sinx, x
    sta sprite_x, y

    lda sinx_ub, x
    sta sprite_x_ub, y
    
    // y-position

    lda siny_offset
    clc
    ldx sprite_idx
    adc sprite_idx_offset, x
    tax
    
    // wrap around if we've overflowed the sin data
    cpx #96
    bcc !+
    txa 
    sbc #96
    tax
!:
    lda siny, x
    sta sprite_y, y

    // move to next sprite index
    inc sprite_idx
    lda sprite_idx
    // exit if all sprintes are handled
    cmp sprite_count
    bne sprite_loop

    // reset border color
    lda color_bg
    sta $d020

    rts

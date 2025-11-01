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
    .byte $AB,$BA,$C8,$D6,$E4,$F1,$FD,$09
    .byte $14,$1D,$26,$2E,$34,$39,$3C,$3E
    .byte $3F,$3E,$3C,$39,$34,$2E,$26,$1D
    .byte $14,$09,$FD,$F1,$E4,$D6,$C8,$BA
    .byte $AB,$9C,$8E,$80,$72,$65,$59,$4D
    .byte $42,$39,$30,$28,$22,$1D,$1A,$18
    .byte $17,$18,$1A,$1D,$22,$28,$30,$39
    .byte $42,$4D,$59,$65,$72,$80,$8E,$9C

sinx_ub:
    .byte 0,0,0,0,0,0,0,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0

sinx_offset:
    .byte $0

siny:
    .byte $8B,$97,$A2,$AD,$B8,$C1,$CA,$D2
    .byte $D8,$DD,$E1,$E3,$E4,$E3,$E1,$DD
    .byte $D8,$D2,$CA,$C1,$B7,$AD,$A2,$97
    .byte $8B,$7F,$74,$69,$5F,$55,$4C,$44
    .byte $3E,$39,$35,$33,$32,$33,$35,$39
    .byte $3E,$44,$4C,$55,$5E,$69,$74,$7F


siny_offset:
    .byte $0

x_pos:
    .byte $0
y_pos:
    .byte $0
sprite_idx:
    .byte $0
tmp01:
    .byte $0

*= $0810
start:
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

    lda #25
    sta $d012

    // use hardware vectors for setting interrupt
    lda #<move_sprites
    sta $fffe
    lda #>move_sprites
    sta $ffff

    // enable raster IRQ
    lda #%00000001
    sta $d01a

    // keep IO on, but switch out BASIC+KERNAL
    lda #%00110101
    sta $01

    cli
    jmp *
    
init_sprites:
    lda #%11111111
    sta $d015

    // set all sprite colors to white
    ldx #0
    lda #$a
    sta $d027, x
    inx
    cpx #8
    bne *-6
    
    // position all sprites out of view
    ldx #0
    lda #0
    sta $d000, x
    inx
    cpx #8
    bne *-6

    lda #50
    sta $d001    
    sta $d000    

    // sprite data in $2000 (0x80 * 64)
    lda #$80
    ldx #0
    sta $07f8, x
    inx
    cpx #8
    bne *-6
    
    rts

move_sprites:
    // ack interrupt
    lda #$01
    sta $d019

    // set border color
    lda #$01
    sta $d020

    // load and set y position
    ldx siny_offset
    inx
    // wrap around if we've overflowed the sin data
    cpx #48
    bne *+4
    ldx #0
    stx siny_offset

    // load and set x position
    ldx sinx_offset
    inx
    // wrap around if we've overflowed the sin data
    cpx #64
    bne *+4
    ldx #0
    stx sinx_offset

    // x now holds next x offset

    // y and $cd holds sprite index
    lda #0
    sta sprite_idx

//    .break

    // reset all sprites upper bit
    lda #0
    sta $d010

sprite_loop:
    // .break
    // x-position
    // $cd holds sprite index
    lda sinx_offset
    adc sprite_idx
    adc sprite_idx
    adc sprite_idx
    adc sprite_idx
    
    // wrap around if we've overflowed the sin data
    cmp #64
    bcc !+
    sbc #64
!:

    cmp #64
    bne *+4
    lda #0

    // move sin offset index to x
    tax

    // multiply sprite index with 2 for correct sprite pos offset
    lda sprite_idx
    asl
    tay
    
    // y holds sprites x position offset
    lda sinx, x
    sta $d000, y

    // set high bit
    lda sinx_ub, x
    // acc now holds upper bit value for sprite
    
    // shift to correct position for sprite index
    sty tmp01
    ldy sprite_idx
    cpy #0
    beq *+7
    dey
    asl
    jmp *-6
    ora $d010
    sta $d010
    ldy tmp01

    // y-position

    // $cd holds sprite index
    lda siny_offset
    adc sprite_idx
    adc sprite_idx
    adc sprite_idx
    adc sprite_idx
    tax
    
    // wrap around if we've overflowed the sin data
    cpx #47
    bcc !+
    pha
    txa 
    sbc #47
    tax
    pla
!:
    lda siny, x
    sta $d001, y

    // move to next sprite index
    inc sprite_idx
    lda sprite_idx
    // exit if all sprintes are handled
    cmp #7
    bne sprite_loop

    // reset border color
    lda #$0e
    sta $d020

    rti

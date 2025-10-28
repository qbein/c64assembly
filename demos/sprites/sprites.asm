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
sin1:
    .byte $AB,$BA,$C8,$D6,$E4,$F1,$FD,$09
    .byte $14,$1D,$26,$2E,$34,$39,$3C,$3E
    .byte $3F,$3E,$3C,$39,$34,$2E,$26,$1D
    .byte $14,$09,$FD,$F1,$E4,$D6,$C8,$BA
    .byte $AB,$9C,$8E,$80,$72,$65,$59,$4D
    .byte $42,$39,$30,$28,$22,$1D,$1A,$18
    .byte $17,$18,$1A,$1D,$22,$28,$30,$39
    .byte $42,$4D,$59,$65,$72,$80,$8E,$9C

sin1_ub:
    .byte 0,0,0,0,0,0,0,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0

sin1_offset:
    .byte $0

sin2:
    .byte $8B,$97,$A2,$AD,$B8,$C1,$CA,$D2
    .byte $D8,$DD,$E1,$E3,$E4,$E3,$E1,$DD
    .byte $D8,$D2,$CA,$C1,$B7,$AD,$A2,$97
    .byte $8B,$7F,$74,$69,$5F,$55,$4C,$44
    .byte $3E,$39,$35,$33,$32,$33,$35,$39
    .byte $3E,$44,$4C,$55,$5E,$69,$74,$7F


sin2_offset:
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
    lda #$01
    ldx #8
    sta $d027, x
    dex
    bne *-4
    
    // position all sprites out of view
    ldx #8
    lda #0
    sta $d000, x
    dex
    bne *-4

    lda #50
    sta $d001    
    sta $d000    

    // sprite data in $2000 (0x80 * 64)
    lda #$80
    sta $07f8

    rts

move_sprites:
    lda #$01
    sta $d019

    lda $6
    sta $d020
    
    ldx sin1_offset
    lda sin1, x
    sta $d000

    lda #0
    sta $d010
    lda sin1_ub, x
    ora $d010
    // x position 8th bit for sprites:
    //lda #%00000001
    sta $d010

    inx
    cpx #64
    bne *+4
    ldx #0
    stx sin1_offset

    ldx sin2_offset
    lda sin2, x
    sta $d001

    inx
    cpx #48
    bne *+4
    ldx #0
    stx sin2_offset

    
    lda $0a
    sta $d020

    rti

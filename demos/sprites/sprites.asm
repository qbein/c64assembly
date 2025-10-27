.var continue_basic=$ea31
.var continue_short=$ea81

BasicUpstart2(start)

*= $C000
sin01:
    .byte $FA,$04,$0E,$17,$20,$29,$32,$39
    .byte $41,$47,$4D,$52,$56,$5A,$5C,$5E
    .byte $5E,$5E,$5C,$5A,$56,$52,$4D,$47
    .byte $41,$39,$32,$29,$20,$17,$0E,$04
    .byte $FA,$F0,$E6,$DD,$D4,$CB,$C2,$BB
    .byte $B3,$AD,$A7,$A2,$9E,$9A,$98,$96
    .byte $96,$96,$98,$9A,$9E,$A2,$A7,$AD
    .byte $B3,$BB,$C2,$CB,$D4,$DD,$E6,$F0

sin01_offset:
    .byte $0

*= $0810
start:
    sei
    lda #%01111111
    sta $dc0d
    sta $dd0d

    lda $d011
    and #%01111111
    sta $d011

    //and $d011
    //sta $d011

    lda #60
    sta $d012

    lda #<set_color
    sta $0314
    lda #>set_color
    sta $0315

    lda #%00000001
    sta $d019
    sta $d01a

    // reset background colors
    lda $0
    sta $d020
    sta $d021

    cli
    rts
    
set_color:
    asl $d019
    
    ldy #$4
before:
    dey
    bne before

    lda #4    
    sta $d020
    sta $d021
    
    ldy #$a
after:
    dey
    bne after

    lda #$0
    sta $d020
    sta $d021


    ldx sin01_offset
    inx
    cpx #65
    bne continue
    ldx #0
continue:
    lda sin01,x
    sta $d012
    stx sin01_offset

    jmp continue_short

show_sprites:
    // enable all sprites
    lda #$ff
    sta $d015
    
    // set all sprite colors to white
    lda #$01
    sta $d027
    sta $d028
    sta $d029
    sta $d02a
    sta $d02b
    sta $d02c
    sta $d02d

    // position sprite #0 - top left
    lda #24
    sta $d000
    lda #50
    sta $d001

    // position sprite #1 - top right (see 8th bit)
    lda #$40
    sta $d002
    lda #50
    sta $d003

    // position sprite #3 - bottom left
    lda #24
    sta $d004
    lda #229
    sta $d005

    // position sprite #3 - bottom right (see 8th bit)
    lda #$40
    sta $d006
    lda #$e5
    sta $d007

    // x position 8th bit for sprites:
    lda #%00001010
    sta $d010




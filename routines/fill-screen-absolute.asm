// fill screen with absolute indexing though zero page pointer
.macro FillScreen(char) {
    // setup screen pointer
    lda #$00
    sta $f7
    lda #$04
    sta $f8

    // x register hold the number of pages to fill
    ldx #$04

    // character to fill (space)
    lda #char
loop: 
    // write character
    sta ($f7),y
    iny
    // continue until we wrap around after 255 chars
    bne loop
    // increment high byte for next page
    inc $f8
    dex
    // continue until all 4 pages are filled
    bne loop
}
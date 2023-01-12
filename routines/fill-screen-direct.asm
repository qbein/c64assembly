    // fill screen with direct indexing

    // character to fill (space)
    lda #$20
loop: 
    sta $0400,x
    sta $0500,x
    sta $0600,x
    sta $0700,x
    dex
    // continue until all 4 pages are filled
    bne loop
    
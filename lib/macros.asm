.const SCROLL_Y=$d011
.const SCROLL_X=$d016

/**
 * Change background color if DEBUG is true.
 */
.macro DebugBg(color) {
    .if (DEBUG) {
        lda #color
        sta $d020
    }
}

/**
 * Move line one char to the left.
 * Inserts char in x-registry as new char on line.
 */
.macro MoveChar(line_start) {
    ldy #$0
!:
    lda line_start+1, y
    sta line_start, y
    iny
    cpy #$27
    bne !-

    txa
    sta line_start+$27
}

.macro Fill(char) {
    ldx #0
    lda #char
loop: 
    sta $0400,x
    sta $0500,x
    sta $0600,x
    sta $0700,x
    dex
    bne loop
}

/**
 * Initialize raster irq as line.
 */
.macro InitIrq(irq_low, irq_high, line) {
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

    lda #line
    sta $d012

    // use hardware vectors for setting interrupt
    lda #irq_low
    sta $fffe
    lda #irq_high
    sta $ffff

    // enable raster IRQ
    lda #%00000001
    sta $d01a

    sta $d019

    // keep IO on, but switch out BASIC+KERNAL
    lda #%00110101
    sta $01

    cli
    jmp *
}
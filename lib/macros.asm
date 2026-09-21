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
    lda line_start+1
    sta line_start
    lda line_start+2
    sta line_start+1
    lda line_start+3
    sta line_start+2
    lda line_start+4
    sta line_start+3
    lda line_start+5
    sta line_start+4
    lda line_start+6
    sta line_start+5
    lda line_start+7
    sta line_start+6
    lda line_start+8
    sta line_start+7
    lda line_start+9
    sta line_start+8
    lda line_start+10
    sta line_start+9
    lda line_start+11
    sta line_start+10
    lda line_start+12
    sta line_start+11
    lda line_start+13
    sta line_start+12
    lda line_start+14
    sta line_start+13
    lda line_start+15
    sta line_start+14
    lda line_start+16
    sta line_start+15
    lda line_start+17
    sta line_start+16
    lda line_start+18
    sta line_start+17
    lda line_start+19
    sta line_start+18
    lda line_start+20
    sta line_start+19
    lda line_start+21
    sta line_start+20
    lda line_start+22
    sta line_start+21
    lda line_start+23
    sta line_start+22
    lda line_start+24
    sta line_start+23
    lda line_start+25
    sta line_start+24
    lda line_start+26
    sta line_start+25
    lda line_start+27
    sta line_start+26
    lda line_start+28
    sta line_start+27
    lda line_start+29
    sta line_start+28
    lda line_start+30
    sta line_start+29
    lda line_start+31
    sta line_start+30
    lda line_start+32
    sta line_start+31
    lda line_start+33
    sta line_start+32
    lda line_start+34
    sta line_start+33
    lda line_start+35
    sta line_start+34
    lda line_start+36
    sta line_start+35
    lda line_start+37
    sta line_start+36
    lda line_start+38
    sta line_start+37
    lda line_start+39
    sta line_start+38
    
    stx line_start+39
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

.macro EnableSprites(sprites) {
    lda #sprites
    sta $d015
}
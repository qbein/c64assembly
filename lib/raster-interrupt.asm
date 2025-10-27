.macro RasterI(line, Fn) {
    sei
    lda #%01111111
    sta $dc0d

    and $d011
    sta $d011

    lda line
    sta $d012

    lda #<Fn
    sta $0314
    lda #>Fn
    sta $0315

    lda #%00000001
    sta $d01a

    cli
}
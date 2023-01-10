.var yScroll=$d011
.var xScroll=$d016

.macro ScrollLeft() {
    lda xScroll,x
    adc #01
    cmp #$08
    beq resetX
    sta xScroll
}



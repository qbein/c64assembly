.var y_scroll=$d011
.var x_scroll=$d016

.macro ScrollLeft() {
    lda x_scroll
    sec
    sbc #$01
    and #$07
    sta $fb
    //sta pixel_offset

    // load current scroll
    lda x_scroll
    // remove current scroll offset
    and #%11111000
    // set new scroll offset keeping other bit values
    clc
    adc $fb
    
    sta x_scroll

    // shift text when jumping back to 7
    and #$07
    cmp #$07
}

.macro SaveLeftOverflowChar(x, y, i) {
    lda x+($28*i)
    sta y+i
}

.macro InsertOverflowCharRight(x, y, i) {
    lda y+i
    sta x+($28*i)+$27
}

.macro MoveCharLeft(y) {
    lda $0400+($28*y)+1,x
    sta $0400+($28*y),x
}


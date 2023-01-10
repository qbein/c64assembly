//#import "routines/scroll.asm"

.var yScroll=$d011
.var xScroll=$d016

:BasicUpstart2(main)

main:
    //lda #$00
    //sta xScroll

    // disable interrupts
    sei           
    // switch off interrupt signals from CIA-1                     
    lda #%01111111
    sta $dc0d

    // clear most significant bit of VIC's raster register
    and $d011
    sta $d011

    // acknowledge pending interrupts from CIA-1
    lda $dc0d
    // acknowledge pending interrupts from CIA-2
    lda $dd0d

    // set rasterline where interrupt shall occur
    lda $0
    sta $d012

    // set interrupt vectors, pointing to interrupt service routine below
    lda #<scroll
    sta $0314
    lda #>scroll
    sta $0315

    // enable raster interrupt signals from VIC
    lda #%00000001
    sta $d01a

    // clear interrupt flag, allowing the CPU to respond to interrupt requests
    cli
    rts
scroll:
    // increment offset
    lda offset
    adc #01
    and #07
    sta offset

    // load current scroll
    lda xScroll
    // remove current scroll offset
    and #%11111000
    // set new scroll offset keeping other bit values
    adc offset
    
    sta xScroll

    and #07
    beq shiftText
continue:
    // ; acknowledge the interrupt by clearing the VIC's interrupt flag
    asl $d019
    jmp $ea31
shiftText:
    
    jmp continue

offset: .byte 00

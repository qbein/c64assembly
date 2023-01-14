#import "routines/scroll.asm"

:BasicUpstart2(main)

.var continue_basic=$ea31
.var continue_short=$ea81

start_char:     .byte   $41
end_char:       .byte   $57
char:           .byte   start_char
pixel_offset:   .byte   00

main:
    jsr disable_cursor
    
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
    lda #$fb // after text
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
    lda #$00
    sta $d020
    
    ScrollLeft()
    beq shift_text
continue:
    // ; acknowledge the interrupt by clearing the VIC's interrupt flag
    asl $d019
    lda #$0e
    sta $d020
    jmp continue_short
shift_text:
    SaveLeftOverflowChar($0400, $5400, 0)
    SaveLeftOverflowChar($0400, $5400, 1)
    SaveLeftOverflowChar($0400, $5400, 2)
    SaveLeftOverflowChar($0400, $5400, 3)
    SaveLeftOverflowChar($0400, $5400, 4)
    SaveLeftOverflowChar($0400, $5400, 5)
    SaveLeftOverflowChar($0400, $5400, 6)
    SaveLeftOverflowChar($0400, $5400, 7)
    SaveLeftOverflowChar($0400, $5400, 8)
    SaveLeftOverflowChar($0400, $5400, 9)
    SaveLeftOverflowChar($0400, $5400, 10)
    SaveLeftOverflowChar($0400, $5400, 11)
    SaveLeftOverflowChar($0400, $5400, 12)
    SaveLeftOverflowChar($0400, $5400, 13)
    SaveLeftOverflowChar($0400, $5400, 14)
    SaveLeftOverflowChar($0400, $5400, 15)
    SaveLeftOverflowChar($0400, $5400, 16)
    SaveLeftOverflowChar($0400, $5400, 17)
    SaveLeftOverflowChar($0400, $5400, 18)
    SaveLeftOverflowChar($0400, $5400, 19)
    SaveLeftOverflowChar($0400, $5400, 20)
    SaveLeftOverflowChar($0400, $5400, 21)
    SaveLeftOverflowChar($0400, $5400, 22)
    SaveLeftOverflowChar($0400, $5400, 23)
    SaveLeftOverflowChar($0400, $5400, 24)
    SaveLeftOverflowChar($0400, $5400, 25)

    ldx #$00
loop1: 
    MoveCharLeft(0)
    MoveCharLeft(1)
    MoveCharLeft(2)
    MoveCharLeft(3)
    MoveCharLeft(4)
    MoveCharLeft(5)
    MoveCharLeft(6)
    MoveCharLeft(7)
    MoveCharLeft(8)
    MoveCharLeft(9)
    MoveCharLeft(10)
    MoveCharLeft(11)
    MoveCharLeft(12)
    MoveCharLeft(13)
    inx
    cpx #$27
    bne loop1
    
    ldx #$00 
loop2:
    MoveCharLeft(14)
    MoveCharLeft(15)
    MoveCharLeft(16)
    MoveCharLeft(17)
    MoveCharLeft(18)
    MoveCharLeft(19)
    MoveCharLeft(20)
    MoveCharLeft(21)
    MoveCharLeft(22)
    MoveCharLeft(23)
    MoveCharLeft(24)
    MoveCharLeft(25)
    inx
    cpx #$27
    bne loop2
    
    InsertOverflowCharRight($0400, $5400, 0)
    InsertOverflowCharRight($0400, $5400, 1)
    InsertOverflowCharRight($0400, $5400, 2)
    InsertOverflowCharRight($0400, $5400, 3)
    InsertOverflowCharRight($0400, $5400, 4)
    InsertOverflowCharRight($0400, $5400, 5)
    InsertOverflowCharRight($0400, $5400, 6)
    InsertOverflowCharRight($0400, $5400, 7)
    InsertOverflowCharRight($0400, $5400, 8)
    InsertOverflowCharRight($0400, $5400, 9)
    InsertOverflowCharRight($0400, $5400, 10)
    InsertOverflowCharRight($0400, $5400, 11)
    InsertOverflowCharRight($0400, $5400, 12)
    InsertOverflowCharRight($0400, $5400, 13)
    InsertOverflowCharRight($0400, $5400, 14)
    InsertOverflowCharRight($0400, $5400, 15)
    InsertOverflowCharRight($0400, $5400, 16)
    InsertOverflowCharRight($0400, $5400, 17)
    InsertOverflowCharRight($0400, $5400, 18)
    InsertOverflowCharRight($0400, $5400, 19)
    InsertOverflowCharRight($0400, $5400, 20)
    InsertOverflowCharRight($0400, $5400, 21)
    InsertOverflowCharRight($0400, $5400, 22)
    InsertOverflowCharRight($0400, $5400, 23)
    InsertOverflowCharRight($0400, $5400, 24)
    InsertOverflowCharRight($0400, $5400, 25)
done:
    jmp continue
disable_cursor:
    // wait for cursor to blink out
    lda $cf
    bne disable_cursor
    lda #$01
    sta $cc
    rts
    
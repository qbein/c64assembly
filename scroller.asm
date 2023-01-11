//#import "routines/scroll.asm"
:BasicUpstart2(main)

.var y_scroll=$d011
.var x_scroll=$d016
.var screen_start=$0400

.var continue_basic=$ea31
.var continue_short=$ea81

start_char:     .byte   $41
end_char:       .byte   $57
char:           .byte   start_char
pixel_offset:   .byte   00
char_pointer:   .word   screen_start

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
    // increment offset
    lda pixel_offset
    adc #$01
    and #$07
    sta pixel_offset

    // load current scroll
    lda x_scroll
    // remove current scroll offset
    and #%11111000
    // set new scroll offset keeping other bit values
    adc pixel_offset
    
    sta x_scroll

    and #$07
    beq shift_text
continue:
    // ; acknowledge the interrupt by clearing the VIC's interrupt flag
    asl $d019
    lda #$0e
    sta $d020
    jmp continue_short
shift_text:
    //inc $d021
    ldx #$00
    lda char
copy_char: 
    sta screen_start,x
    sta screen_start+256,x
    sta screen_start+256*2,x
    sta screen_start+256*3,x
    dex
    bne copy_char
    
    inc char
    lda char
    cmp end_char
    bne done
    lda start_char
    sta char
done:
    jmp continue
disable_cursor:
    // wait for cursor to blink out
    lda $cf
    bne disable_cursor
    lda #$01
    sta $cc
    rts
    
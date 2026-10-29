.const DEBUG = false

#import "../../lib/macros.asm"

:BasicUpstart2(start)

start:
    InitIrq(<main, >main, $2f)

main:
    asl $d019 

    ldy #CYAN

    lda $d011
    // Clear DEN to supress badlines
    and #%11101111
    sta $d011


    lda $d012
!:
    cmp $d012
    beq !-

next:
    sty $d020
    sty $d021
    
    // Burn 42 cycles
    nop
    nop
    nop
    nop
    nop

    nop
    nop
    ldy #LIGHT_BLUE
    nop
    nop
    nop

    sty $d020
    sty $d021

    nop
    nop
    nop
    nop
    nop

    nop

//.fill 21, $ea
    
    lda $d012
    cmp #$ff
    beq done

    ldy #CYAN

    // lda $d011
    // ora #%00010000      // DEN back on before line $30 of the next frame
    // sta $d011

    jmp next
done:
    lda #BLUE
    sta $d020
    sta $d021

    rti

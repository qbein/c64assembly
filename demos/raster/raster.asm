.const DEBUG = false

#import "../../lib/macros.asm"

:BasicUpstart2(start)

*= $2000
text_00: 
    //     ----------------------------------------
    .text " hello world! hello world! hello world! " 
    .text " hello world! hello world! hello world! " 
    .text " hello world! hello world! hello world! " 
    .text " hello world! hello world! hello world! " 

raster_01:
    .byte 0,0,6,6,14,14,9,9,8,8,10,7,7,7,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,7,7,7,10,8,8,9,9,14,14,6,6,0,0

raster_00:
    .fill 10, BLACK
    .byte BLUE
    .byte BLUE, BLUE, LIGHT_BLUE, BLUE, LIGHT_BLUE, LIGHT_BLUE, BLUE, LIGHT_BLUE
    .byte LIGHT_BLUE, LIGHT_BLUE, CYAN, LIGHT_BLUE, CYAN, CYAN, LIGHT_BLUE, CYAN, CYAN
    .byte CYAN, WHITE, WHITE, CYAN, WHITE, WHITE, CYAN, WHITE, WHITE
    .byte WHITE, WHITE, CYAN, WHITE, WHITE, CYAN, WHITE, WHITE, CYAN
    .byte CYAN, CYAN, LIGHT_BLUE, CYAN, CYAN, LIGHT_BLUE, CYAN, LIGHT_BLUE, LIGHT_BLUE
    .byte LIGHT_BLUE, BLUE, LIGHT_BLUE, LIGHT_BLUE, BLUE, LIGHT_BLUE, BLUE, BLUE
    .byte BLUE
    .fill 10, BLACK
    // 27 * 2 = 44


// has to start on badline - 3
.const START_LINE = $88

.macro Delay(cycles) {
    .if (cycles < 0 || cycles == 1) {
        .error "Delay: cannot burn " + cycles + " cycles"
    }
    .if((cycles & 1) == 1) {
        bit $ea
        .fill floor((cycles - 3) / 2), $ea
    } else {
        .fill floor(cycles / 2), $ea
    }
}

*= $c000
start:
    Fill($20)

    ldx #$0
!:
    lda text_00,x
    sta $05b8,x
    inx
    cpx #160
    bne !-

    InitIrq(<irq_sync_arm, >irq_sync_arm, START_LINE)

irq_sync_arm:
    pha
    txa
    pha
    tya
    pha

    lda #<irq_sync_lock
    sta $fffe
    lda #>irq_sync_lock
    sta $ffff

    inc $d012

    lda #$01
    sta $d019

    tsx
    cli

    // add some nop
    .fill 16, $ea

irq_sync_lock:
    txs
    
    ldx #$08
!:  dex
    bne !-

    bit $ea     // 3 cycles

    lda $d012
    cmp $d012
    beq !+      // jitter fix
!:

stable:
    // delay until end of raster line $8a
    :Delay(50)

    // leave 2 + 4 + 4 cycles for color change
    ldy #$0 // 2 cycles

.for (var i=0; i<40; i++) {
    lda raster_01, y // 4 cycles
    sta $d020  // 4 cycles / 8
    sta $d021  // 4 cycles / 12
    iny        // 2 cycles / 14

    // we should be stable on cycle 1 on line $8b, a badline

    //tax // 2 cycles / 12
    //inx // 2 cycles / 14
    //txa // 2 cycles / 16
    .var pad = 63-14
    .if ((i & 7) == 0) {
        .eval pad = 20-14
    }
    :Delay(pad)
}

nop

lda #$0
sta $d020
sta $d021

irq_sync_lock_reset:
    // reset for next match
    lda #$01
    sta $d019
    lda #<irq_sync_arm
    sta $fffe
    lda #>irq_sync_arm
    sta $ffff
    lda #START_LINE
    sta $d012
    
    pla
    tay
    pla
    tax
    pla

    rti

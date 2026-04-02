.const DEBUG = true

#import "../../lib/macros.asm"

:BasicUpstart2(start)

.const ptr_00 = $84
.const ptr_01 = $86
.const ptr_02 = $88
.const ptr_03 = $8a
.const ptr_04 = $8c
.const ptr_05 = $8e
.const ptr_06 = $90
.const ptr_07 = $92
.const ptr_08 = $94
.const ptr_09 = $96
.const ptr_0a = $98
.const ptr_0b = $9a
.const ptr_0c = $9c
.const ptr_0d = $9e
.const ptr_0e = $a0
.const ptr_0f = $a2
.const ptr_10 = $a4
.const ptr_11 = $a6
.const ptr_12 = $a8
.const ptr_13 = $aa
.const ptr_14 = $ac
.const ptr_15 = $ae
.const ptr_16 = $b0
.const ptr_17 = $b2
.const ptr_18 = $b4

.macro ResetPtr(addr_target, ptr) {
    lda #<addr_target
    sta ptr
    lda #>addr_target
    sta ptr+1
}

start:
    ResetPtr(text_00, ptr_00)
    ResetPtr(text_01, ptr_01)
    ResetPtr(text_02, ptr_02)
    ResetPtr(text_03, ptr_03)
    ResetPtr(text_04, ptr_04)
    ResetPtr(text_05, ptr_05)
    ResetPtr(text_06, ptr_06)
    ResetPtr(text_07, ptr_07)
    ResetPtr(text_08, ptr_08)
    ResetPtr(text_09, ptr_09)
    ResetPtr(text_0a, ptr_0a)
    ResetPtr(text_0b, ptr_0b)
    ResetPtr(text_0c, ptr_0c)
    ResetPtr(text_0d, ptr_0d)
    ResetPtr(text_0e, ptr_0e)
    ResetPtr(text_0f, ptr_0f)
    ResetPtr(text_10, ptr_10)
    ResetPtr(text_11, ptr_11)
    ResetPtr(text_12, ptr_12)
    ResetPtr(text_13, ptr_13)
    ResetPtr(text_14, ptr_14)
    ResetPtr(text_15, ptr_15)
    ResetPtr(text_16, ptr_16)
    ResetPtr(text_17, ptr_17)
    ResetPtr(text_18, ptr_18)
    
    InitIrq(<main, >main, $ff)

.macro NextChar(text, ptr, screen) {
    ldy #0
    lda (ptr), y
    cmp #0
    bne !+
    ResetPtr(text, ptr)
    lda (ptr), y
!:
    tax

    MoveChar(screen)

    inc ptr
    bne !done+
    inc ptr+1
!done:
}

next_char:
    NextChar(text_00, ptr_00, $0400)
    NextChar(text_01, ptr_01, $0428)
    NextChar(text_02, ptr_02, $0450)
    NextChar(text_03, ptr_03, $0478)
    NextChar(text_04, ptr_04, $04a0)
    NextChar(text_05, ptr_05, $04c8)
    NextChar(text_06, ptr_06, $04f0)
    NextChar(text_07, ptr_07, $0518)
    NextChar(text_08, ptr_08, $0540)
    NextChar(text_09, ptr_09, $0568)
    NextChar(text_0a, ptr_0a, $0590)
    NextChar(text_0b, ptr_0b, $05b8)
    NextChar(text_0c, ptr_0c, $05e0)
    NextChar(text_0d, ptr_0d, $0608)
    NextChar(text_0e, ptr_0e, $0630)
    NextChar(text_0f, ptr_0f, $0658)
    NextChar(text_10, ptr_10, $0680)
    NextChar(text_11, ptr_11, $06a8)
    NextChar(text_12, ptr_12, $06d0)
    NextChar(text_13, ptr_13, $06f8)
    NextChar(text_14, ptr_14, $0720)
    NextChar(text_15, ptr_15, $0748)
    NextChar(text_16, ptr_16, $0770)
    NextChar(text_17, ptr_17, $0798)
    NextChar(text_18, ptr_18, $07c0)

    jmp done

main:
    lda #1
    sta $d019

scroll:
    DebugBg(WHITE)

    dec SCROLL_X
    lda SCROLL_X
    and #7
    sta SCROLL_X
    cmp #7
    bne done
    jmp next_char
done:    

    DebugBg(BLACK)

    rti

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

text_00: 
    .text "lorem ipsum dolor sit amet,   -  " // consectetur adipiscing elit. nunc convallis, elit at rutrum feugiat, ligula ex tincidunt nulla, sit amet elementum mi nisl sed neque. vivamus ut viverra dolor. quisque vehicula sed felis a volutpat. in posuere sollicitudin lectus, et finibus libero. nulla facilisi. cras ullamcorper ultrices risus, ac mollis est. proin vehicula quam ligula, quis varius libero ultricies sit amet. sed lacinia odio tortor. in venenatis neque nulla. aliquam commodo placerat lacinia. duis tortor nunc, tincidunt a urna vel, tempus bibendum nunc. mauris ultricies luctus finibus. praesent pulvinar auctor mi eget suscipit. vestibulum sem sem, laoreet et molestie quis, tincidunt quis velit. maecenas ornare vel tortor eget egestas. " 
    .byte 0
text_01: 
    .text "nunc pellentesque velit odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_02: 
    .text "pellentesque velit odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_03: 
    .text "velit odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_04: 
    .text "odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_05: 
    .text "sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_06: 
    .text "cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_07: 
    .text "augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_08: 
    .text "tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_09: 
    .text "ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_0a: 
    .text "suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_0b: 
    .text "at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_0c: 
    .text "leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_0d: 
    .text "tesque velit odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_0e: 
    .text "velit odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_0f: 
    .text "odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_10: 
    .text "sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_11: 
    .text "cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_12: 
    .text "augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_13: 
    .text "tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_14: 
    .text "ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_15: 
    .text "suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_16: 
    .text "at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_17: 
    .text "leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
text_18: 
    .text "consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   -  " 
    .byte 0
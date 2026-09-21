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

siny:
    .byte $8C,$8F,$92,$94,$97,$9A,$9D,$A0
    .byte $A2,$A5,$A8,$AB,$AD,$B0,$B3,$B5
    .byte $B8,$BB,$BD,$C0,$C2,$C5,$C7,$CA
    .byte $CC,$CE,$D1,$D3,$D5,$D7,$D9,$DB
    .byte $DD,$DF,$E1,$E3,$E5,$E7,$E8,$EA
    .byte $EC,$ED,$EF,$F0,$F1,$F3,$F4,$F5
    .byte $F6,$F7,$F8,$F9,$FA,$FB,$FC,$FC
    .byte $FD,$FD,$FE,$FE,$FE,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FE,$FE,$FE,$FD
    .byte $FD,$FC,$FC,$FB,$FA,$F9,$F8,$F7
    .byte $F6,$F5,$F4,$F3,$F1,$F0,$EF,$ED
    .byte $EC,$EA,$E8,$E7,$E5,$E3,$E1,$DF
    .byte $DD,$DB,$D9,$D7,$D5,$D3,$D1,$CE
    .byte $CC,$CA,$C7,$C5,$C2,$C0,$BD,$BB
    .byte $B8,$B5,$B3,$B0,$AD,$AB,$A8,$A5
    .byte $A2,$A0,$9D,$9A,$97,$94,$92,$8F
    .byte $8C,$89,$86,$84,$81,$7E,$7B,$78
    .byte $76,$73,$70,$6D,$6B,$68,$65,$63
    .byte $60,$5D,$5B,$58,$56,$53,$51,$4E
    .byte $4C,$4A,$47,$45,$43,$41,$3F,$3D
    .byte $3B,$39,$37,$35,$33,$31,$30,$2E
    .byte $2C,$2B,$29,$28,$27,$25,$24,$23
    .byte $22,$21,$20,$1F,$1E,$1D,$1C,$1C
    .byte $1B,$1B,$1A,$1A,$1A,$19,$19,$19
    .byte $19,$19,$19,$19,$1A,$1A,$1A,$1B
    .byte $1B,$1C,$1C,$1D,$1E,$1F,$20,$21
    .byte $22,$23,$24,$25,$27,$28,$29,$2B
    .byte $2C,$2E,$30,$31,$33,$35,$37,$39
    .byte $3B,$3D,$3F,$41,$43,$45,$47,$4A
    .byte $4C,$4E,$51,$53,$56,$58,$5B,$5D
    .byte $60,$63,$65,$68,$6B,$6D,$70,$73
    .byte $76,$78,$7B,$7E,$81,$84,$86,$89

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

    EnableSprites(%11111111)

    ldx #0
    lda #$40
!:
    sta $d000, x
    adc #$1f
    inx
    inx
    cpx #16
    bne !-

    lda #%10000000
    sta $d010
    
    InitIrq(<main, >main, $f9)

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
frame_idx:
    .byte 0
sprite_offset:
    .byte 0

jmp_next_char:
    jmp next_char

main:
    lda #1
    sta $d019

    DebugBg(RED)

    lda $d011
    and #%11110111
    sta $d011

wait:
    lda $d012
    cmp #$ff
    bne wait

    lda $d011
    ora #%00001000
    sta $d011

    DebugBg(PURPLE)

!:
    lda $d012
    cmp #$0a
    bne !-

    // Disable sprites to prevent y-pos bug between top and bottom borders
    EnableSprites($00)

    DebugBg(GREEN)

!:
    lda $d011
    and #$80
    bne !-
!:
    lda $d012
    cmp #$0f
    bne !-

    // Enable sprites after problematic area
    EnableSprites($ff)

    DebugBg(PURPLE)

scroll:
    DebugBg(WHITE)

    //lda frame_idx
    //and #3
    //cmp #0
    //beq done
    dec SCROLL_X
    lda SCROLL_X
    and #7
    sta SCROLL_X
    cmp #7

    beq jmp_next_char

done:    

    DebugBg(YELLOW)

    lda #$00
    sta $d01b

    ldy #0
!:
    tya
    asl
    asl
    asl
    clc
    adc sprite_offset
    tax

    lda siny, x
    sta $d001, y

    iny
    iny

    cpy #16
    bne !-

    dec sprite_offset
    dec sprite_offset

    DebugBg(BLACK)

    rti

text_00: 
    .text "lorem ipsum dolor sit amet, consectetur adipiscing elit. nunc convallis, elit at rutrum feugiat, ligula ex tincidunt nulla, sit amet elementum mi nisl sed neque. vivamus ut viverra dolor. quisque vehicula sed felis a volutpat. in posuere sollicitudin lectus, et finibus libero. nulla facilisi. cras ullamcorper ultrices risus, ac mollis est. proin vehicula quam ligula, quis varius libero ultricies sit amet. sed lacinia odio tortor. in venenatis neque nulla. aliquam commodo placerat lacinia. duis tortor nunc, tincidunt a urna vel, tempus bibendum nunc. mauris ultricies luctus finibus. praesent pulvinar auctor mi eget suscipit. vestibulum sem sem, laoreet et molestie quis, tincidunt quis velit. maecenas ornare vel tortor eget egestas.   ###  " 
    .byte 0
text_01: 
    .text "nunc pellentesque velit odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_02: 
    .text "pellentesque velit odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_03: 
    .text "velit odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_04: 
    .text "odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_05: 
    .text "sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_06: 
    .text "cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_07: 
    .text "augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_08: 
    .text "tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_09: 
    .text "ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_0a: 
    .text "suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_0b: 
    .text "at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_0c: 
    .text "leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_0d: 
    .text "tesque velit odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_0e: 
    .text "velit odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_0f: 
    .text "odio, sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_10: 
    .text "sed cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_11: 
    .text "cursus augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_12: 
    .text "augue tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_13: 
    .text "tincidunt ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_14: 
    .text "ac. suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_15: 
    .text "suspendisse at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_16: 
    .text "at leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_17: 
    .text "leo consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
text_18: 
    .text "consequat, scelerisque nisi quis, malesuada tellus. lorem ipsum dolor sit amet, consectetur adipiscing elit.   ###  " 
    .byte 0
.const DEBUG = false

#import "../../lib/macros.asm"

:BasicUpstart2(start)

.const ptr = $84

start:
    lda #<text
    sta ptr
    lda #>text
    sta ptr+1
    
    InitIrq(<main, >main, $ff)
    
text:
    .text "   lorem ipsum dolor sit amet, consectetur adipiscing elit. nunc convallis, elit at rutrum feugiat, ligula ex tincidunt nulla, sit amet elementum mi nisl sed neque. vivamus ut viverra dolor. quisque vehicula sed felis a volutpat. in posuere sollicitudin lectus, et finibus libero. nulla facilisi. cras ullamcorper ultrices risus, ac mollis est. proin vehicula quam ligula, quis varius libero ultricies sit amet. sed lacinia odio tortor. in venenatis neque nulla. aliquam commodo placerat lacinia. duis tortor nunc, tincidunt a urna vel, tempus bibendum nunc. mauris ultricies luctus finibus. praesent pulvinar auctor mi eget suscipit. vestibulum sem sem, laoreet et molestie quis, tincidunt quis velit. maecenas ornare vel tortor eget egestas. "
    .byte 0

reset_ptr:
    lda #<text
    sta ptr
    lda #>text
    sta ptr+1

next_char:
    ldy #0
    lda (ptr), y
    tax

    cmp #0
    beq reset_ptr
!:

    MoveChar($0400)
    MoveChar($0428)
    MoveChar($0450)
    MoveChar($0478)
    MoveChar($04A0)
    MoveChar($04C8)
    MoveChar($04F0)

    MoveChar($0518)
    MoveChar($0540)
    MoveChar($0568)
    MoveChar($0590)
    MoveChar($05B8)
    MoveChar($05E0)

    MoveChar($0608)
    MoveChar($0630)
    MoveChar($0658)
    MoveChar($0680)
    MoveChar($06A8)
    MoveChar($06D0)
    MoveChar($06F8)
    
    MoveChar($0720)
    MoveChar($0748)
    MoveChar($0770)
    MoveChar($0798)
    MoveChar($07C0)

    inc ptr
    bne !done+
    inc ptr+1
!done:

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
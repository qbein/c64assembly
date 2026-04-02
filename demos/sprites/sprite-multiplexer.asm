.const DEBUG = false

#import "../../lib/macros.asm"

.var continue_basic=$ea31
.var continue_short=$ea81

BasicUpstart2(start)

.const addr_sort_sprite_idx = $81
.const addr_sort_temp = $82
.const addr_sprite_idx = $83
.const addr_chunk_idx = $84

.const sprite_count = 32
.const grace_lines = 5
.const offset_x = 8
.const offset_y = 8

*= $2000

sprite_circle:
    .byte $03, $AA, $C0
	.byte $06, $AA, $90
	.byte $0A, $AA, $A0
	.byte $1A, $AA, $A4
	.byte $2A, $AA, $A8
	.byte $EA, $AA, $AB
	.byte $6A, $AA, $A9
	.byte $6A, $AA, $A9
	.byte $AA, $AA, $AA
	.byte $AA, $AA, $AA
	.byte $AA, $AA, $AA
	.byte $AA, $AA, $AA
	.byte $AA, $AA, $AA
	.byte $6A, $AA, $A9
	.byte $6A, $AA, $A9
	.byte $EA, $AA, $AB
	.byte $2A, $AA, $A8
	.byte $1A, $AA, $A4
	.byte $0A, $AA, $A0
	.byte $06, $AA, $90
	.byte $03, $AA, $C0

sprite01:
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

// Center position
// Center = (min + max) / 2
// Center X: (24 + 319) / 2 = 171.5 ≈ 172
// Center Y: (50 + 228) / 2 = 139
// Amplitude
// Amplitude = (max − min) / 2
// Amplitude X: (319 − 24) / 2 = 147.5 ≈ 148
// Amplitude Y: (228 − 50) / 2 = 89

// uv run main.py --wave 0.0,360,172,147,256 --wave 0,1080.0,0,50 --count 256 --suffix x --combine |pbcopy

sinx:
    .byte $AC,$B0,$B3,$B7,$BA,$BE,$C2,$C5
    .byte $C9,$CC,$D0,$D3,$D7,$DA,$DE,$E1
    .byte $E4,$E8,$EB,$EE,$F1,$F4,$F8,$FB
    .byte $FE,$01,$04,$06,$09,$0C,$0F,$11
    .byte $14,$16,$19,$1B,$1E,$20,$22,$24
    .byte $26,$28,$2A,$2C,$2E,$2F,$31,$32
    .byte $34,$35,$36,$38,$39,$3A,$3B,$3B
    .byte $3C,$3D,$3D,$3E,$3E,$3F,$3F,$3F
    .byte $3F,$3F,$3F,$3F,$3E,$3E,$3D,$3D
    .byte $3C,$3B,$3B,$3A,$39,$38,$36,$35
    .byte $34,$32,$31,$2F,$2E,$2C,$2A,$28
    .byte $26,$24,$22,$20,$1E,$1B,$19,$16
    .byte $14,$11,$0F,$0C,$09,$06,$04,$01
    .byte $FE,$FB,$F8,$F4,$F1,$EE,$EB,$E8
    .byte $E4,$E1,$DE,$DA,$D7,$D3,$D0,$CC
    .byte $C9,$C5,$C2,$BE,$BA,$B7,$B3,$B0
    .byte $AC,$A8,$A5,$A1,$9E,$9A,$96,$93
    .byte $8F,$8C,$88,$85,$81,$7E,$7A,$77
    .byte $74,$70,$6D,$6A,$67,$64,$60,$5D
    .byte $5A,$57,$54,$52,$4F,$4C,$49,$47
    .byte $44,$42,$3F,$3D,$3A,$38,$36,$34
    .byte $32,$30,$2E,$2C,$2A,$29,$27,$26
    .byte $24,$23,$22,$20,$1F,$1E,$1D,$1D
    .byte $1C,$1B,$1B,$1A,$1A,$19,$19,$19
    .byte $19,$19,$19,$19,$1A,$1A,$1B,$1B
    .byte $1C,$1D,$1D,$1E,$1F,$20,$22,$23
    .byte $24,$26,$27,$29,$2A,$2C,$2E,$30
    .byte $32,$34,$36,$38,$3A,$3D,$3F,$42
    .byte $44,$47,$49,$4C,$4F,$52,$54,$57
    .byte $5A,$5D,$60,$64,$67,$6A,$6D,$70
    .byte $74,$77,$7A,$7E,$81,$85,$88,$8C
    .byte $8F,$93,$96,$9A,$9E,$A1,$A5,$A8

sinx_ub:
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 1,1,1,1,1,1,1,1
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0

// uv run main.py --wave 0.0,360,139,89,128 --count 128 --suffix=y|pbcopy
// uv run main.py --wave 0.0,360,139,89,256 --count 256 --suffix=y|pbcopy


siny:
    .byte $8B,$8D,$8F,$92,$94,$96,$98,$9A
    .byte $9C,$9F,$A1,$A3,$A5,$A7,$A9,$AB
    .byte $AD,$AF,$B1,$B3,$B5,$B7,$B9,$BB
    .byte $BC,$BE,$C0,$C2,$C3,$C5,$C7,$C8
    .byte $CA,$CB,$CD,$CE,$D0,$D1,$D2,$D4
    .byte $D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC
    .byte $DD,$DE,$DF,$E0,$E0,$E1,$E1,$E2
    .byte $E2,$E3,$E3,$E3,$E4,$E4,$E4,$E4
    .byte $E4,$E4,$E4,$E4,$E4,$E3,$E3,$E3
    .byte $E2,$E2,$E1,$E1,$E0,$E0,$DF,$DE
    .byte $DD,$DC,$DB,$DA,$D9,$D8,$D7,$D6
    .byte $D5,$D4,$D2,$D1,$D0,$CE,$CD,$CB
    .byte $CA,$C8,$C7,$C5,$C3,$C2,$C0,$BE
    .byte $BC,$BB,$B9,$B7,$B5,$B3,$B1,$AF
    .byte $AD,$AB,$A9,$A7,$A5,$A3,$A1,$9F
    .byte $9C,$9A,$98,$96,$94,$92,$8F,$8D
    .byte $8B,$89,$87,$84,$82,$80,$7E,$7C
    .byte $7A,$77,$75,$73,$71,$6F,$6D,$6B
    .byte $69,$67,$65,$63,$61,$5F,$5D,$5B
    .byte $5A,$58,$56,$54,$53,$51,$4F,$4E
    .byte $4C,$4B,$49,$48,$46,$45,$44,$42
    .byte $41,$40,$3F,$3E,$3D,$3C,$3B,$3A
    .byte $39,$38,$37,$36,$36,$35,$35,$34
    .byte $34,$33,$33,$33,$32,$32,$32,$32
    .byte $32,$32,$32,$32,$32,$33,$33,$33
    .byte $34,$34,$35,$35,$36,$36,$37,$38
    .byte $39,$3A,$3B,$3C,$3D,$3E,$3F,$40
    .byte $41,$42,$44,$45,$46,$48,$49,$4B
    .byte $4C,$4E,$4F,$51,$53,$54,$56,$58
    .byte $5A,$5B,$5D,$5F,$61,$63,$65,$67
    .byte $69,$6B,$6D,$6F,$71,$73,$75,$77
    .byte $7A,$7C,$7E,$80,$82,$84,$87,$89


sprite_idx:
    .byte $0
sprite_pos_x:
    .fill sprite_count,0
sprite_pos_x_ub:
    .fill sprite_count,0
sprite_pos_y:
    .fill sprite_count,0

.align $10
sprite_order:
    .fill sprite_count,0

frame_idx:
    .byte 0

start:
    jsr clear
    jsr init_sprites
    
    lda #0
    sta addr_sprite_idx
    sta addr_chunk_idx

    jsr update_next_sprite_position

    InitIrq(<irq_demo_main, >irq_demo_main, 0)

clear:
    Fill(' ')

    lda #BLUE
    sta $d020
    lda #BLACK
    sta $d021

    rts

init_sprites:
    lda #%11111111
    sta $d015

    lda #$ff
    sta $d01b

    // position all sprites out of view
    ldx #0
    lda #0
!:
    sta $d000, x
    inx
    cpx #8
    bne !-

    lda #50
    sta $d001    
    sta $d000    

    // sprite data in $2000 (0x80 * 64)
    lda #$80
    ldx #0
!:
    sta $07f8, x
    inx
    cpx #8
    bne !-

    lda #$ff
    sta $d01c

    // set sprite colors
    ldx #0
    lda #CYAN
!:
    sta $d027, x
    inx
    cpx #8
    bne !-

.if (DEBUG) {
    lda #WHITE  
    sta $d027
    sta $d028
    sta $d029
    sta $d02a
}

    // set multi color 1
    lda #GREEN
    sta $d025

    // set multi color 2
    lda #BROWN
    sta $d026

    jsr reset_sprite_order

    rts

colors:
    .byte 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4
    .byte 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8

reset_sprite_order:
    // initialize sprite order array
    ldx #0 
!:
    txa
    sta sprite_order, x
    inx
    cpx #sprite_count
    bne !-
    
    rts

ub_mask_set:
    .byte %00000001
    .byte %00000010
    .byte %00000100
    .byte %00001000
    .byte %00010000
    .byte %00100000
    .byte %01000000
    .byte %10000000
ub_mask_unset:
    .byte %11111110
    .byte %11111101
    .byte %11111011
    .byte %11110111
    .byte %11101111
    .byte %11011111
    .byte %10111111
    .byte %01111111
tmp:
    .byte 0
    
irq_sprite_move:
    lda #$01
    sta $d019

    DebugBg(WHITE)

move_next_sprite:
    lda addr_sprite_idx
    tax
    and #%0000111
    tay
    sty tmp

    lda sprite_order, x
    tax
    // x = sw sprite index

    tya
    asl
    tay
    // y = hw sprite position offset

    lda sprite_pos_x, x
    sta $d000, y

    lda sprite_pos_y, x
    sta $d000+1, y

    ldy tmp
    lda sprite_pos_x_ub, x
    cmp #1
    beq !set+
!unset:
    lda ub_mask_unset, y
    and $d010
    sta $d010
    jmp !ub_done+
!set:
    lda ub_mask_set, y
    ora $d010
    sta $d010
!ub_done:

    inc addr_sprite_idx
    lda addr_sprite_idx
    cmp #sprite_count

    bne !+

    lda $d012
    adc #2
    sta $d012

    lda #<irq_demo_main
    sta $fffe
    lda #>irq_demo_main
    sta $ffff
    
    jmp !done+
    
!done:
    DebugBg(0)

    rti

!:

    ldx addr_sprite_idx
    lda sprite_order, x
    tax
    lda sprite_pos_y, x
    sbc #grace_lines

    cmp $d012
    bcc !move_next+
    beq !move_next+

!set_irq:
    sta $d012

    DebugBg(0)

    rti

!move_next:
    jmp move_next_sprite

irq_demo_main:
    lda #$01
    sta $d019

    inc frame_idx

    ldx #0
    stx addr_sprite_idx
    ldy sprite_order, x
    lda sprite_pos_y, y
    sbc #grace_lines

    sta $d012
    
    lda #<irq_sprite_move
    sta $fffe
    lda #>irq_sprite_move
    sta $ffff

    DebugBg(RED)

    jsr update_next_sprite_position

    DebugBg(BLACK)

    rti

phase_x: .byte 0
phase_y: .byte 30

update_next_sprite_position:
    inc phase_x
    inc phase_y
    inc phase_y

    ldx #0

update_sprite_position:
    // x-position
    ldy phase_x

    tya
    clc
    adc #offset_x
    tay

    sta phase_x

    lda sinx, y
    sta sprite_pos_x, x

    lda sinx_ub, y
    sta sprite_pos_x_ub, x

    // y-position
    ldy phase_y

    tya
    clc
    adc #offset_y
    tay

    sta phase_y

    lda siny, y
    sta sprite_pos_y, x

    inx

    cpx #sprite_count
    bne update_sprite_position

sort_sprites:
    DebugBg(GREEN)

    // now lets sort sprites by y position
    ldx #1
    stx addr_sort_sprite_idx

sort_sprites__outer:
    // break if we've handeled all sprites
    ldx addr_sort_sprite_idx
    cpx #sprite_count
    beq sort_sprites__done
    
sort_sprites__compare_x:
    ldy sprite_order, x
    lda sprite_pos_y, y

    ldy sprite_order-1, x
    cmp sprite_pos_y, y

    bcc sort_sprites__swap_order

    inc addr_sort_sprite_idx
    jmp sort_sprites__outer

sort_sprites__swap_order:
    lda sprite_order, x
    ldy sprite_order-1, x

    sta sprite_order-1, x
    tya
    sta sprite_order, x
    dex
    cpx #0
    beq sort_sprites__outer
    jmp sort_sprites__compare_x

sort_sprites__done:
    DebugBg(CYAN)

    lda #0
    sta addr_sort_temp
    rts


:BasicUpstart2(main)

.pc = $c000
main:
  ldx #0
  lda #24
fill_row_1:
  sta $0400,X
  inx
  cpx #40
  bne fill_row_1

  lda #24
  ldy #6
  ldx #0
  clc
fill_column_1:
  sta $0400,X
  sta $04f0,X
  sta $05e0,X
  sta $06d0,X
  pha
  txa
  adc #40
  tax
  pla
  dey
  bne fill_column_1

  rts

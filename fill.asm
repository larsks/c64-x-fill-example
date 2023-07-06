:BasicUpstart2(main)

.const numrows = 24
.const numcols = 40
.const char_x = 24

.var screen_base = $0400
.var screen_row_01 = screen_base
.var screen_row_24 = $07c0

* = $00fb "ZP" virtual
target: .word 0

* = $c000
main:
  ldx #0
  lda #char_x
fill_row_1:
  sta screen_row_01,X
  sta screen_row_24,X
  inx
  cpx #numcols
  bne fill_row_1

  lda #<screen_base
  sta target
  lda #>screen_base
  sta target+1
  lda #char_x
  ldx #numrows
fill_column_1:
  ldy #0
  sta (target),y
  ldy #(numcols-1)
  sta (target),y
  add(target, numcols)
  dex
  bne fill_column_1

  rts

.macro add(loc, val) {
  clc
  pha
  lda loc
  adc #<val
  sta loc
  lda loc+1
  adc #>val
  sta loc+1
  pla
}

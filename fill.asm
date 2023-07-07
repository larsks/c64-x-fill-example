:BasicUpstart2(main)

.const numrows = 24         // number of rows on screen
.const numcols = 40         // number of columns on screen
.const fill_char = 24       // fill character for border

.var screen_base = $0400
.var screen_row_01 = screen_base
.var screen_row_24 = $07c0

* = $00fb "ZP" virtual
target: .word 0             // define zero page variable for 16 bit addition

* = $c000 "Main"
main:
  ldx #numcols              // x is loop index
  lda #fill_char
fill_row_1:
  dex
  sta screen_row_01,X
  sta screen_row_24,X
  bne fill_row_1                // loop until we reach 0

  lda #<screen_base         // store screen base address in target
  sta target
  lda #>screen_base
  sta target+1
  lda #fill_char
  ldx #numrows              // X is loop index
fill_column_1:
  ldy #0                    // write X to column 1
  sta (target),y
  ldy #(numcols-1)          // write X to column 40
  sta (target),y
  add(target, numcols)      // add one row
  dex                       // decrement loop index
  bne fill_column_1         // loop until we reach 0

  rts

/*
 * Add value `val` to the 16 bit memory location at `loc`
 */
.macro add(loc, val) {
  pha                       // save A register

  clc
  lda loc
  adc #<val
  sta loc
  lda loc+1
  adc #>val
  sta loc+1

  pla                       // restore A register
}

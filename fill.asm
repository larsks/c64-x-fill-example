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

  ldy #0
  ldx #24

  //  Load screen base address ($0400) into location $fb
  lda #$0
  sta $fb
  lda #$04
  sta $fc

  //  Load character "X" into A
  lda #24
fill_column_1:
  //  Save A because add_words_imm changes it
  pha

  //  Increment target address by 40 characters
  add_words_imm($fb, 40, $fb)

  //  Restore A
  pla

  //  Write character to screen location
  sta ($fb),y
  dex
  bne fill_column_1

  rts

.macro add_words_imm(a, b, result) {
    clc
  .for(var byte = 0;  byte < 2; byte++) {
    lda a + byte
    adc #extract_byte(b, byte)
    sta result + byte
  }
}

.function extract_byte(value, byte_id) {
  .var bits = byte_id * 8
  .eval value = value >> bits
  .return value & 255
}


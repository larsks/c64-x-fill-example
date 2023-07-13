#if BASIC_PREAMBLE
:BasicUpstart2(main)
#endif

.const numrows       = 24       // number of rows on screen
.const numcols       = 40       // number of columns on screen
.const space_char    = 32       // fill character for border
.const debug_exit    = $d7ff    // See https://vice-emu.pokefinder.org/wiki/Debugcart

.const DDRB          = $dc03    // port b data direction register
.const PORTB         = $dc01    // port b (keyboard input)

.const screen_base   = $0400
.const fill_char     = 24       // fill character for border

* = $c000 "main"
main:
  jsr clear_screen
  jsr fill_every_5
  jsr wait_for_key
  jsr exit

  rts

exit:
  lda #0                        // this will cause the VICE emulator
  sta debug_exit                // to exit
  rts

fill_every_5:
  lda #fill_char
  ldx #$ff
!:
  dex
  dex
  dex
  dex
  dex
  sta screen_base,x
  sta screen_base+(1*$ff),x
  sta screen_base+(2*$ff),x
  sta screen_base+(3*$ff),x
  bne !-

  rts

wait_for_key:
  pha
  lda #0
  sta DDRB
!:
  lda PORTB
  cmp #$ff
  beq !-
  pla
  rts

clear_screen:
  ldx #255                      // x is loop index
  lda #space_char
!:
  sta screen_base,X
  sta screen_base+256,X
  sta screen_base+256*2,X
  sta screen_base+256*3,X
  dex
  bne !-

  rts

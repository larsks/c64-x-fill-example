%.prg: %.asm
	java -jar KickAss.jar -showmem -vicesymbols $<

all: fill.prg

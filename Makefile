%.prg: %.asm
	java -jar KickAss.jar $<

all: fill.prg

%.prg: %.asm
	java -jar KickAss.jar -showmem -vicesymbols $<

all: fill.prg

run: all
	x64sc fill.prg

clean:
	rm -f fill.prg fill.vs

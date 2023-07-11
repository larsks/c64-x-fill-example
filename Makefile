ASM = java -jar KickAss.jar
ASMDEFS = -define BASIC_PREAMBLE
ASMFLAGS = -showmem -vicesymbols

X64 = x64sc
X64FLAGS = -debugcart

SRCS = $(wildcard *.asm)
PRGS = $(SRCS:.asm=.prg)
VICESYMBOLS = $(SRCS:.asm=.vs)

%.prg: %.asm
	$(ASM) $(ASMFLAGS) $(ASMDEFS) $<

all: $(PRGS)

run: all
	$(X64) $(X64FLAGS) fill.prg

clean:
	rm -f $(PRGS) $(VICESYMBOLS)

ASM = java -jar KickAss.jar
ASMFLAGS = -showmem -vicesymbols -define BASIC_PREAMBLE

X64 = x64sc
X64FLAGS = -debugcart

SRCS = $(wildcard *.asm)
PRGS = $(SRCS:.asm=.prg)
VICESYMBOLS = $(SRCS:.asm=.vs)

%.prg: %.asm
	$(ASM) $(ASMFLAGS) $<

all: $(PRGS)

run: all
	$(X64) $(X64FLAGS) fill.prg

clean:
	rm -f $(PRGS) $(VICESYMBOLS)

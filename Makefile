ASM = java -jar KickAss.jar
ASMFLAGS = -showmem -vicesymbols

SRCS = $(wildcard *.asm)
PRGS = $(SRCS:.asm=.prg)
BINS = $(SRCS:.asm=.bin)
VICESYMBOLS = $(SRCS:.asm=.vs)

%.prg: ASMDEFS = -define BASIC_PREAMBLE

%.prg: %.asm
	$(ASM) $(ASMFLAGS) $(ASMDEFS) $<

%.bin: %.asm
	$(ASM) -binfile $(ASMFLAGS) $(ASMDEFS) $<

all: $(PRGS)

clean:
	rm -f $(PRGS) $(BINS) $(VICESYMBOLS)

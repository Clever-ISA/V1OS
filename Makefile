AS=lcas
ASFLAGS=--target=clever-unknown-cleveros

OBJECTS=main.o pci.o term.o

all: v1os.elf

v1os.elf: $(OBJECTS)
	ld -o $@ $^
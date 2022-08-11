AS=lc-binutils/target/debug/lcas
ASFLAGS=--target=clever-unknown-cleveros

OBJECTS=main.o term.o

.PHONY: $(AS) all clean

all: $(AS) v1os.elf

clean:
	rm -f v1os.elf $(OBJECTS)

v1os.elf: $(OBJECTS)
	ld -o $@ $^

$(AS):
	cd lc-binutils && cargo build
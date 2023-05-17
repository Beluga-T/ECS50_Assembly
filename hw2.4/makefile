all: editDist

editDist: editDist.o
	ld -m elf_i386 -o editDist editDist.o

editDist.o: editDist.s
	as --32 --gstabs -o editDist.o editDist.s

clean:
	rm -f editDist editDist.o

all: clean lib.o main.o driver.o
	gcc -o main lib.o main.o driver.o

lib.o: lib.asm
	nasm -f elf64 lib.asm
	
main.o:	main.asm
	nasm -f elf64 main.asm

driver.o:
	gcc -c driver.c

clean:
	-rm -f *.o
	-rm -f main

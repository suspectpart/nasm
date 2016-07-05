all: clean test.o driver.o
	gcc -o main test.o driver.o
	
test.o:	test.asm
	nasm -f elf64 test.asm

driver.o:
	gcc -c driver.c

clean:
	-rm -f *.o
	-rm -f main

#include <stdio.h>

int main(int argc, char *argv[])
{
	int ret;
	ret = asm_main();
	printf("[exiting c]\n");
	return ret;
}

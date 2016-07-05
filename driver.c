#include <stdio.h>

int main(int argc, char *argv[])
{
	int ret;
	printf("[driver start]\n");
	ret = asm_main();
	printf("[driver end]\n");
	return ret;
}

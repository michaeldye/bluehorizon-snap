#include <stdio.h>
#include <string.h>

char nibbletochar(char c)
{
	if (c >= '0' && c <= '9')
		return c - '0';
	if (c >= 'a' && c <= 'f')
		return c - 'a' + 10;
	if (c >= 'A' && c <= 'F')
		return c - 'A' + 10;
	return 255;
}

int main(int argv, char *argc[])
{
	unsigned int i;
	unsigned char x;

	if (argv == 2)
		for (i = 0; i < strlen(argc[1]); i++) {
			x = nibbletochar(argc[1][i++]) << 4;
			x += nibbletochar(argc[1][i]);
			printf("%c", x);
		}

	return 0;
}

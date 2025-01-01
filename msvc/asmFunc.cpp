#include <stdio.h>

extern "C"
{
	void asmFunc();
}
int main(void)
{
	asmFunc();
}


/*
 * Generic C++ driver program to demonstrate returning funciton results
 * from assembly language to C++. Also includes a "readLine" function that reads
 * a string from the user and passes it to the assembly language code
 *
 * needs to include stdio.h so this program
*/

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern "C"
{
  // The assembly language code's "main program"
  void asmMain(void);

  // getTitle returns a pointer to a string of character
  // from the assembly code that specifies the title of that program
  char *getTitle(void);

  // C++ function that the assembly language program can call
  int readLine(char *dest, int maxLen);
};

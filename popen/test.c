#include "stdio.h"
#include <stdlib.h>
#include <string.h>

int main()
{

   char *line = NULL;
   size_t linecap = 0;
   ssize_t linelen;
   printf("User Input:");
   linelen = getline(&line, &linecap, stdin);
   FILE* myfp=popen("R --vanilla --slave -q", "r+");
   fwrite(line, linelen, 1, myfp);
   linelen = getline(&line, &linecap, myfp);
   fwrite(line, linelen, 1, stdout);


   pclose(myfp);

   return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{

   char *line = NULL;
   size_t linecap = 0;
   ssize_t linelen;
   printf("User Input:");
   linelen = getline(&line, &linecap, stdin);
   FILE* myfp=popen("R --vanilla -q", "r+");
   fwrite(line, linelen, 1, myfp);
   int i;
   for(i=0; i<2 && (linelen = getline(&line, &linecap, myfp))>0; i++)
      fwrite(line, linelen, 1, stdout);


   pclose(myfp);

   return 0;
}

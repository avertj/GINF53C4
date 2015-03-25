#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// arg 1 : svm file
// arg 2 : annotation file
int main(int argc, char *argv[])
{
        char *command;
        FILE *files[2];

        int i;
        for(i = 1; i < 3; i++) {
                if (strstr(argv[i], "http://") == argv[i]) {
                        asprintf(&command, "wget -O - \"%s\" -o /dev/null", argv[i]);
                } else {
                        asprintf(&command, "cat \"%s\"", argv[i]);
                }
                if ((files[i-1] = popen(command, "r")) == NULL) {
                        fprintf(stderr,"Can't open svm file from \"%s\" command, exiting", command);
                        exit(1);
                }
        }

        free(command);

        char * svmline = NULL;
        size_t svmlen = 0;
        char * annline = NULL;
        size_t annlen = 0;

        while (getline(&svmline, &svmlen, files[0]) != -1 &&
               getline(&annline, &annlen, files[1]) != -1) {
                int iann;
                sscanf(annline, "%*s %i\n", &iann);

                if (iann) {
                        printf("%d %s", iann, (svmline + 2));
                }
        }
}

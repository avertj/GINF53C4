#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// arg 1 : svm file
// arg 2 : annotation file
int main(int argc, char *argv[])
{
    FILE *svm;
    FILE *ann;
    char *command;

    if (strstr(argv[1], "http://") == argv[1]) {
        asprintf(&command, "wget -O - \"%s\" -o /dev/null", argv[1]);
    } else {
        asprintf(&command, "cat \"%s\"", argv[1]);
    }
    if ((svm = popen(command, "r")) == NULL) {
        fprintf(stderr,"Can't open svm file from \"%s\" command, exiting", command);
        exit(1);
    }

    if (strstr(argv[2], "http://") == argv[2]) {
        asprintf(&command, "wget -O - \"%s\" -o /dev/null", argv[2]);
    } else {
        asprintf(&command, "cat \"%s\"", argv[2]);
    }
    if ((ann = popen(command, "r")) == NULL) {
        fprintf(stderr,"Can't open ann file from \"%s\" command, exiting", command);
        exit(1);
    }

    free(command);

    char * svmline = NULL;
    size_t svmlen = 0;
    ssize_t svmread;
    char * annline = NULL;
    size_t annlen = 0;
    ssize_t annread;

    while ((svmread = getline(&svmline, &svmlen, svm)) != -1 &&
            (annread = getline(&annline, &annlen, ann)) != -1) {
        int iann;
        sscanf(annline, "%*s %i\n", &iann);

        if (iann)
            printf("%d %s", iann, (svmline + 2));
    }
}

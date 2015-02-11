
// un array de concepts
// une liste d'images (depuis concepts)
// le fichier de probas (.out) propre au concepts

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// arg 1 : nom du concept
// arg 2 : fichier out
// arg 3 : annotation file
int main(int argc, char *argv[])
{
    //char concepts[20] = {"aeroplane", "bicycle", "bird", "boat", "bottle", "bus", "car", "cat", "chair", "cow", "diningtable", "dog", "horse", "motorbike", "person", "pottedplant", "sheep", "sofa", "train", "tvmonitor"};

    char *command;
    FILE *files[2];

    int i;
    for(i = 2; i < 4; i++) {
        if (strstr(argv[i], "http://") == argv[i]) {
            asprintf(&command, "wget -O - \"%s\" -o /dev/null", argv[i]);
        } else {
            asprintf(&command, "cat \"%s\"", argv[i]);
        }
        if ((files[i-2] = popen(command, "r")) == NULL) {
            fprintf(stderr,"Can't open svm file from \"%s\" command, exiting", command);
            exit(1);
        }
    }

    free(command);

    char * outline = NULL;
    size_t outlen = 0;
    char * annline = NULL;
    size_t annlen = 0;

    getline(&outline, &outlen, files[0]);
    while (getline(&outline, &outlen, files[0]) != -1 &&
           getline(&annline, &annlen, files[1]) != -1) {

        char sann[12];
        sscanf(annline, "%s %*i\n", sann);

        float proba;
        sscanf(outline, "%*i %*f %f\n", &proba);

        printf("%s Q0 %s 0 %f R\n", argv[1], sann, proba);
    }
}

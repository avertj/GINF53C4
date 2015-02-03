#include <stdio.h>

#include "rdjpeg.h"

#define BINS 4
#define BINS_STEP (256 / BINS)

uint idx(uint val)
{
    int i = 0;
    int cmp = BINS_STEP;
    while (val >= cmp && i < BINS) {
        i++;
        cmp += BINS_STEP;
    }
    return i;
}

int main(int argc, char *argv[])
{
    int n;
    int i;
    for (i = 0; i < 256; i++)
        printf("%d : %d\n", i, idx(i));
    for(n = 1; n < argc; n++) {
        CIMAGE cim;
        read_cimage(argv[n], &cim);

        uint pixels = cim.nx * cim.ny;
        double h[BINS][BINS][BINS];

        int i, j, k;

        for (k = 0; k < BINS; k++) {
            for (j = 0; j < BINS; j++) {
                for (i = 0; i < BINS; i++) {
                    h[i][j][k] = 0.0;
                }
            }
        }

        for (j = 0; j < cim.ny; j++) {
            for (i = 0; i < cim.nx; i++) {
                h[idx(cim.r[i][j])][idx(cim.g[i][j])][idx(cim.b[i][j])]++;
            }
        }

        for (k = 0; k < BINS; k++) {
            for (j = 0; j < BINS; j++) {
                for (i = 0; i < BINS; i++) {
                    h[i][j][k] = h[i][j][k] / pixels;
                    //printf("  %f", h[i][j][k]);
                }
                //printf("\n");
            }
            //printf("\n");
        }

        int composante = 1;
        printf("%d", (n - 1));
        for (k = 0; k < BINS; k++) {
            for (j = 0; j < BINS; j++) {
                for (i = 0; i < BINS; i++) {
                    if(h[i][j][k] > 0) {
                        printf(" %d:%f", composante, h[i][j][k]);
                    }
                    composante++;
                }
            }
        }
        printf("\n");
    }
}

// editado por f0r34chb3t4
// original http://wurthmann.blogspot.com/2012/12/gerador-de-cpf.html
// 

#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <stdio.h>

#define MAX_GEN 50000 


char cpf[11];

void cpf_generator() {


    memset(&cpf, 0, sizeof (cpf));

    int i, j, dig = 0;

    for (i = 0; i <= 9; i++) {
        cpf[i] = (rand() % 10) + 48;
    }

    for (i = 0, j = 10; i <= strlen(cpf) - 2; i++, j--) {
        dig += (cpf[i] - 48) * j;
    }

    dig %= 11;

    if (dig < 2) {
        cpf[9] = 48;
    } else {
        cpf[9] = (11 - dig) + 48;
    }

    dig = 0;

    for (i = 0, j = 11; i <= strlen(cpf) - 1; i++, j--) {
        dig += (cpf[i] - 48) * j;
    }

    dig %= 11;

    if (dig < 2) {
        cpf[10] = 48;
    } else {
        cpf[10] = (11 - dig) + 48;
    }
}

int main() {

    int i;
    int x;

    srand(time(NULL));

    for (x = 0; x < MAX_GEN; x++) {

        cpf_generator();

        for (i = 0; i < 11; i++) {
            printf("%c", cpf[i]);
        }

        printf("\n");
    }

    return 0;
}

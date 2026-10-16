#include <stdio.h>

void main() {
    const char *exe = "wc -w /usr/share/dict/words";

    asm(
        "mov $1, %%rax\n"
        "mov $1, %%rdi\n"
        "mov %0, %%rsi\n"
        "mov $14, %%rdx\n"
        "syscall\n"
        :
        : "r"(exe)
        : "%rax", "%rdi", "%rsi", "%rdx"
    );

}


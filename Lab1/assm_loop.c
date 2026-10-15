#include <stdio.h>

extern int func(void);
// the definition of func is written in assembly language
__asm__(".globl func\n\t"
        ".type func, @function\n\t"
        "func:\n\t"
        ".cfi_startproc\n\t"
        "movl $7, %eax\n\t"
        "ret\n\t"
        ".cfi_endproc");

int main(void)
{

    // standard inline assembly in C++
    __asm__(
        ".loop:\n\t"
        "	xadd %rax, %rdx\n\t"

        "	loop .loop\n\t"

        "  _start:			 \n\t"
        "          movq $1, %rax 	\n\t"
        "          movq $1, %rdx	\n\t"
        "	  movq $1, %rcx	\n\t"
        "	  call .loop\n\t"
        "          movq $60, %rax 	\n\t"
        "          movq $0, %rdi	\n\t"
        "          syscall		\n\t"
    );
}

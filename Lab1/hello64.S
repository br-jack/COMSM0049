; hello64.S: a first step into assembly programming!
global _start			; tells executable to default start here. global <- nasm specific. Puts _start in object code's export table so linker can use it.  

  section .text			; defines area of executable machine code

  _start:			; 
          mov rax, 1		; copies 1 (write) into rax (general purpose accumilator register)
          mov rdi, 1		; copy 1 (write) into rdi (general purpose register)
          mov rsi, msg		; 
          mov rdx, len		;
          syscall		; entry point into the kernel

          mov rax, 60		; copy 60 (exit) into rax (general purpose accumilator register) 
          mov rdi, 0		;
          syscall		; entry point into the kernel

  section .rodata		; defines area of read only data
  msg: db "Hello, World!", 10	; 10 (mprotect)
  len: equ $ - msg		; 


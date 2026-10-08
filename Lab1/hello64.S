; hello64.S: a first step into assembly programming!
global _start			; tells executable to default start here. global <- nasm specific. Puts _start in object code's export table so linker can use it.  

  section .text			; defines area of executable machine code

  _start:			; 
          mov rax, 1		; copies 1 (write) into rax Return Values: By convention, rax stores the return value of a function if it is 64 bits or smaller. Arithmetic Operations: It serves as the primary accumulator for instructions like multiplication (MUL) and division (DIV).
          mov rdi, 1		; copy 1 (write) into rdi holds the first integer or pointer argument passed to a function
          mov rsi, msg		; copy data at label msg into rsi holds the second integer or pointer argument passed to a function R-> 64bit S-> Second I->Integer
          mov rdx, len		; copy data at label len into rdx 3rd argument
          syscall		; entry point into the kernel

          mov rax, 60		; copy 60 (exit) into rax (general purpose accumilator register) 
          mov rdi, 0		; copy 0 ()
          syscall		; switches into the kernel whoch looks at rax. rax then holds return value

  section .rodata		; defines area of read only data
  msg: db "Hello, World!", 10	; 10 (mprotect)
  len: equ $ - msg		; 


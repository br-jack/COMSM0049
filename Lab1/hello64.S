; hello64.S: a first step into assembly programming!
global _start			; tells executable to default start here. global <- nasm specific. Puts _start in object code's export table so linker can use it.  

  section .text			; defines area of executable machine code

  _start:			; 
          mov rax, 1		; copies 1 (write) into rax (holds the syscall number)
          mov rdi, 1		; copy 1 (file descriptior: stdout) into rdi one of the three syscall argument registers rDi -> destination
          mov rsi, msg		; copy address of msg into rsi (one of the syscall registers?) rSi-> source 
          mov rdx, len		; puts whatever calculated value for len is in rdx (assembler calculates it)
          syscall		; switches into the kernel which looks at rax. rax then holds return value

          mov rax, 60		; copy 60 (exit) into rax (arg for sys_exit) 
          mov rdi, 0		; copy 0 ()
          syscall		; switches into the kernel which looks at rax. rax then holds return value

  section .rodata		; defines area of read only data
  msg: db "Hello, World!", 10	; 10 (newline character) db places byte in executable, msg: label for this spot in memory
  len: equ $ - msg		; $ -> current assm position. Gives string length + newline


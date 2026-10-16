; assm_execve.S: execute command and redirect output to a file
global _start           

section .text           

_start:
        mov rax, 59             ; Syscall number for sys_execve
        mov rdi, shell_path     ; Arg 1: pointer to "/bin/sh"
        mov rsi, argv           ; Arg 2: pointer to the argv pointer array
        mov rdx, envp           ; Arg 3: environment pointer array (NULL)
        syscall                 ; Execute command. Does not return if successful.
                

section .rodata
  shell_path: db "/bin/sh", 0
  flag:       db "-c", 0
  
  command:    db "wc -w /usr/share/dict/words", 0

section .data
  align 8
  ; argv must be an array of pointers matching: [shell_path, flag, command, NULL]
  argv: dq shell_path
        dq flag
        dq command
        dq 0

  ; envp can be empty but must be terminated with a NULL pointer
  envp: dq 0


global _start 

  section .text			

.loop:
	xadd rax, rdx
	loop .loop

  _start:			 
          mov rax, 1		
          mov rdi, 1	
	  mov rcx, 1	
	  call .loop
          mov rax, 60		 
          mov rdi, 0		
          syscall		



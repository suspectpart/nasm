SECTION .data
	sys_write db 1

SECTION .text
	GLOBAL write_message ; make global to reference it elsewhere with 'extern'

write_message:
	enter 0,0 ; push rbp && rbp=rsp

	sub rsp, 8		; make room for one local var
	mov rax, [sys_write] 	; dereference syscall_write
	mov qword [rbp-8], rax 	; local var for syscall number

	mov rax, [rbp-8] 	; syscall 1 = write
	mov rdi, 1 		; 1 = stdout
	mov rsi, [rbp+16] 	; the message fetched from stack
	mov rdx, [rbp+24] 	; the message length fetched from stack
	syscall

	leave 			; set rsp to rbp, then restore rbp
	ret

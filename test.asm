SECTION .data

	hello db "Hello World", 10
	helloLen equ $-hello

SECTION .bss
	input1 resd 1

SECTION .text
	GLOBAL asm_main

asm_main:
	; subroutines should preserve values of rbx, rsi, rdi, rbp, cs, ds, ss, es etc.
	push rbp
	mov rbp, rsp

	push helloLen
	push hello ; push hello to stack

	call write_message
	add rsp, 16 ; remove 2 parameters from stack	

	pop rbp ; restore rbp
	mov rdx, 0 ; return 0 = success
	ret

write_message:
	enter 0,0 ; push rbp && rbp=rsp

	sub rsp, 8	; make room for one local var
	mov qword [rbp-8], 1 ; local var for syscall number

	mov rax, [rbp-8] 	; syscall 1 = write
	mov rdi, 1 	; 1 = stdout
	mov rsi, [rbp+16] ; the message fetched from stack
	mov rdx, [rbp+24] ; the message length fetched from stack
	syscall

	leave ; set rsp to rbp, then restore rbp
	ret

SECTION .data
	fmt db "%s", 0
	hello db "hello world", 10, 0
	helloLen equ $-hello
	syscall_write db 1

SECTION .bss
	input1 resd 1

SECTION .text
	GLOBAL asm_main
	EXTERN write_message, to_upper, printf_wrap

asm_main:
	; subroutines should preserve values of rbx, rsi, rdi, rbp, cs, ds, ss, es etc.
	enter 0,0

	push hello		; push string address on stack

	call to_upper

	push helloLen		; push length on stack - address still there

	call write_message
	add rsp, 16 		; remove 2 parameters from stack	
	
	push fmt 
	push hello	

	call printf_wrap 

	add rsp, 16		; remove 2 parameters from stack

	leave
	mov rax, 0 		; return 0 = success
	ret

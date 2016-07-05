SECTION .data

	hello db "Hello World", 10
	helloLen equ $-hello
	syscall_write db 1

SECTION .bss
	input1 resd 1

SECTION .text
	GLOBAL asm_main
	EXTERN write_message

asm_main:
	; subroutines should preserve values of rbx, rsi, rdi, rbp, cs, ds, ss, es etc.
	enter 0,0

	push helloLen
	push hello 		; push hello to stack

	call write_message
	add rsp, 16 		; remove 2 parameters from stack	
	
	leave
	mov rdx, 0 		; return 0 = success
	ret

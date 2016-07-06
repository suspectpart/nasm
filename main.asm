section .data
	fmt db "%s", 0
	hello db "hello world", 10, 0
	helloLen equ $-hello
	syscall_write db 1

section .bss
	helloCopy resb helloLen

section .text
	global asm_main
	extern write_message, to_upper, printf_wrap, duplicate

asm_main:
	; subroutines should preserve values of rbx, rsi, rdi, rbp, cs, ds, ss, es etc.
	enter 0,0

	; --- call duplicate to copy hello into helloCopy
	push helloLen
	push hello
	push helloCopy	

	call duplicate

	add rsp, 24
	;--- call subsroutine to print copied string
 
	push helloCopy
	push helloLen

	call write_message

	add rsp, 16

	; --- call subroutine to upper case original string
	push hello		; push string address on stack

	call to_upper


	; --- leave message address on stack and print it
	push helloLen		; push length on stack - address still there

	call write_message
	add rsp, 16 		; remove 2 parameters from stack	
	

	;--- call c printf function wrapper with same string
	push fmt 
	push hello	

	call printf_wrap 

	add rsp, 16		; remove 2 parameters from stack

	leave
	mov rax, 0 		; return 0 = success
	ret

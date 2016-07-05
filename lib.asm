extern printf

section .data
	sys_write db 1

section .text
	global write_message, to_upper 	; make global to reference it from outside
	global printf_wrap

write_message:
	enter 8,0 			; push rbp && rbp=rsp && sub rsp, 8

	mov rax, [sys_write]		; dereference syscall_write
	mov qword [rbp-8], rax		; local var for syscall number

	mov rax, [rbp-8]		; syscall 1 = write
	mov rdi, 0x1			; 1 = stdout
	mov rsi, [rbp+24]		; the message fetched from stack
	mov rdx, [rbp+16]		; the message length fetched from stack
	syscall

	leave				; rsp = rbp && pop rbp
	ret

to_upper:
	enter 0,0
	push rbx			; calling conventions wants us to preserve rbx

	mov rbx, [rbp+16] 		; address of first char in string
	mov rcx, 0			; initialize counter
start:
	mov byte al, [rbx+rcx]		; get next byte
	cmp al, 0			; check if string terminator
	je end
	cmp al, 0x20			; skip stuff in 0h - 20h (strange symbols and space)
	jle skip
	sub byte [rbx+rcx], 0x20	; subtract 20h == lower to upper
skip:
	inc rcx				; more chars - increase counter and loop 
	jmp start
end:
	pop rbx				
	leave
	ret

printf_wrap:
	enter 0,0
	
	; first six arguments of a call are in rdi, rsi, rdx, rcx, r8 and r9; 
	; temporary values (like the floating point args flag or the syscall to make) are stored in rax (the temp register);
	; all others must be pushed onto the stack.
	; RBP, RBX, R12-R15 must be restored by the callee, if he wishes to use them. The rest is saved by the caller.
	
	mov rdi, [rbp+16]		; fmt from stack
	mov rsi, [rbp+24]		; msg from stack
	mov rax, 0			; rax=0 tells function that there are no floating point arguments	
	call printf	

	leave
	ret

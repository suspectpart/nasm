SECTION .data
	sys_write db 1

SECTION .text
	; make global to reference it elsewhere with 'extern'
	GLOBAL write_message, to_upper 

write_message:
	enter 0,0 ; push rbp && rbp=rsp

	sub rsp, 8		; make room for one local var
	mov rax, [sys_write] 	; dereference syscall_write
	mov qword [rbp-8], rax 	; local var for syscall number

	mov rax, [rbp-8] 	; syscall 1 = write
	mov rdi, 1 		; 1 = stdout
	mov rsi, [rbp+24] 	; the message fetched from stack
	mov rdx, [rbp+16] 	; the message length fetched from stack
	syscall

	leave 			; set rsp to rbp, then restore rbp
	ret

to_upper:
	enter 0,0
	
	mov rbx, [rbp+16] 		; address of first char in string
	mov rcx, 0			; initialize counter
start:
	mov byte al, [rbx+rcx]		; get next byte
	cmp al, 0			; check if string terminator
	je end
	cmp al, 20h			; skip stuff in 0h - 20h (strange symbols and space)
	jle skip
	sub byte [rbx+rcx], 20h		; subtract 20h == lower to upper
skip:
	inc rcx				; more chars - increase counter and loop 
	jmp start
end:
	leave
	ret

section .data
	msg db 'Hello World:',0
	len equ $-msg

section .bss
	w resb 10
	
section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 80h

	mov eax, 3
	mov ebx, 2
	mov ecx, w
	mov edx, 10
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, w
	mov edx, 10
	int 80h
	
	mov eax, 1
	mov ebx, 0
	int 80h

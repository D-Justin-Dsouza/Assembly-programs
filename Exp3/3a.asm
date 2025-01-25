section .data
    msg db "Enter two numbers: ", 0
    sum_msg db "The sum is: ", 0
    endl db 10, 0

section .bss
    num1 resb 4
    num2 resb 4
    result resb 4

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 20
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 4
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 80h

    mov eax, [num1]
    sub eax, '0'
    mov ebx, [num2]
    sub ebx, '0'

    add eax, ebx

    add eax, '0'
    mov [result], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, sum_msg
    mov edx, 13
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, endl
    mov edx, 1
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h 

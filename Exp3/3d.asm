section .data
    msgEnterNum1 db "Enter first number: ", 0
    msgEnterNum2 db "Enter second number: ", 0
    msgEnterNum3 db "Enter third number: ", 0
    msgResult db "Sum: ", 0
    newline db 10, 0

section .bss
    num1 resb 10
    num2 resb 10
    num3 resb 10
    result resb 10

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgEnterNum1
    mov edx, 19
    int 80h
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, msgEnterNum2
    mov edx, 20
    int 80h
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, msgEnterNum3
    mov edx, 19
    int 80h
    mov eax, 3
    mov ebx, 0
    mov ecx, num3
    mov edx, 10
    int 80h

    mov eax, [num1]
    sub eax, '0'
    
    mov ebx, [num2]
    sub ebx, '0'
    add eax, ebx
    
    mov ecx, [num3]
    sub ecx, '0'
    add eax, ecx

    add eax, '0'
    mov [result], al

    mov eax, 4
    mov ebx, 1
    mov ecx, msgResult
    mov edx, 5
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h

section .bss
    num1 resb 4
    num2 resb 4

section .data
    msg1 db "Enter first number: ", 0
    p1 equ $-msg1
    msg2 db "Enter second number: ", 0
    p2 equ $-msg2
    larger db "The larger number is: ", 0
    equal db "The numbers are equal", 0
    newline db 10, 0

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, p1
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 4
    int 80h

    mov eax, [num1]
    sub eax, '0'
    mov [num1], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, p2
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 80h

    mov eax, [num2]
    sub eax, '0'
    mov [num2], eax

    mov eax, [num1]
    mov ebx, [num2]
    cmp eax, ebx
    jg num1_larger
    jl num2_larger
    je numbers_equal

num1_larger:
    mov eax, [num1]
    add eax, '0'
    mov [num1], eax
    mov eax, 4
    mov ebx, 1
    mov ecx, num1
    mov edx, 1
    int 0x80
    jmp exit

num2_larger:
    mov eax, 4
    mov ebx, 1
    mov ecx, larger
    mov edx, 22
    int 80h

    mov eax, [num2]
    add eax, '0'
    mov [num2], eax
    mov eax, 4
    mov ebx, 1
    mov ecx, num2
    mov edx, 1
    int 80h
    jmp exit

numbers_equal:
    mov eax, 4
    mov ebx, 1
    mov ecx, equal
    mov edx, 21
    int 80h

exit:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    mov eax, 1
    xor ebx, ebx
    int 80h

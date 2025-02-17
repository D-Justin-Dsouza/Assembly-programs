%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro ADD 2
    movzx eax, byte [%1]
    sub al, '0'
    movzx ebx, byte [%2]
    sub bl, '0'
    add eax, ebx
    add al, '0'
    mov [result], al
%endmacro

section .data
    prompt1 db 'Enter n:   '
    len1 equ $-prompt1
    msg db 'Fibonacci-Series:   '
    len2 equ $-msg
    newline db 10

section .bss
    n resb 2
    num1 resb 2
    num2 resb 2
    result resb 2

section .text
    global _start

_start:
    write prompt1, len1
    read n, 2
    write msg, len2
    mov byte [num1], '0'
    mov byte [num2], '1'
    movzx ecx, byte [n]
    sub ecx, '0'

loop:
    push ecx
    write newline, 1
    write num1, 1
    ADD num1, num2

    mov al, [num2]
    mov [num1], al
    mov al, [result]
    mov [num2], al
    pop ecx
    dec ecx
    jnz loop
    mov eax, 1
    xor ebx, ebx
    int 0x80
section .bss
    num resb 1

section .data
    msg db 'Enter a number: ', 0
    msg2 db 'You entered number: ', 0

%macro write 3
    mov eax, 4
    mov ebx, %1
    mov ecx, %2
    mov edx, %3
    int 0x80
%endmacro

%macro read 3
    mov eax, 3
    mov ebx, %1
    mov ecx, %2
    mov edx, %3
    int 0x80
%endmacro

section .text
    global _start
_start:
    write 1, msg, 15

    read 0, num, 1

    write 1, msg2, 23
    write 1, num, 1

    mov eax, 1
    xor ebx, ebx
    int 0x80

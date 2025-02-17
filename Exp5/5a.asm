section .bss
    num resb 1

section .data
    msg db 'Enter a number: ', 0

%macro write 3
    mov eax, 4
    mov ebx, %1
    mov ecx, %2
    mov edx, %3
    int 0x80
%endmacro

section .text
    global _start
_start:
    write 1, msg, 15

    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 1
    int 0x80

    write 1, num, 1

    mov eax, 1
    xor ebx, ebx
    int 0x80

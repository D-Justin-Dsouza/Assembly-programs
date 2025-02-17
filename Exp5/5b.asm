section .data
    msg1 db "Enter a word: ", 0
    len1 equ $-msg1;
    msg2 db "Enter another word: ", 0
    len2 equ $-msg2;    
    msg3 db "You entered: ", 0
    len3 equ $-msg3;    
    newline db 10, 0
    
section .bss
    str1 resb 100
    str2 resb 100

section .text
    global _start

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

_start:
    write msg1, len1
    read str1, 100

    write msg2, len2
    read str2, 100

    write msg3, len3
    write str1, 100
    write str2, 100
    write newline, 1

    mov eax, 1
    xor ebx, ebx
    int 80h

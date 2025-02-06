section .data
    msg_greater db 'The number is greater than 5', 0xA, 0
    g_len equ $-msg_greater
    msg_less db 'The number is less than 5', 0xA, 0
    l_len equ $-msg_less
    msg_equal db 'The number is equal to 5', 0xA, 0
    e_len equ $-msg_equal

section .bss
    num resb 1

section .text
    global _start

_start:
    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 1
    int 80h

    sub byte [num], '0'

    mov al, [num]
    cmp al, 5
    je equal
    jl less
    jg greater

greater:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_greater
    mov edx, g_len
    int 80h
    jmp exit

less:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_less
    mov edx, l_len
    int 80h
    jmp exit

equal:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_equal
    mov edx, e_len
    int 80h
    jmp exit

exit:
    mov eax, 1
    xor ebx, ebx
    int 80h

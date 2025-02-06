section .data
    prompt db 'Enter a number: ', 0
    even_msg db 'The number is even.', 10, 0
    odd_msg db 'The number is odd.', 10, 0
    newline db 10, 0

section .bss
    input resb 4

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 16
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 4
    int 80h

    mov eax, [input]
    sub eax, '0'

    mov ebx, 2
    xor edx, edx
    div ebx
    cmp edx, 0
    je print_even

print_odd:
    mov eax, 4
    mov ebx, 1
    mov ecx, odd_msg
    mov edx, 18
    int 80h
    jmp end_program

print_even:
    mov eax, 4
    mov ebx, 1
    mov ecx, even_msg
    mov edx, 19
    int 80h

end_program:
    mov eax, 1
    mov ebx, 0
    int 80h

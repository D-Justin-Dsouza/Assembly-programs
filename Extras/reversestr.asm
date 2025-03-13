section .data
    str db 'Enter a string: ',0
    buffer times 100 db 0
    len equ $ - str - 1
    buffer_len equ $ - buffer

section .bss
    input resb 100

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, str
    mov edx, len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 100
    int 0x80

    ; Find the length of the input string
    mov ecx, 0
find_len:
    cmp byte [input + ecx], 0
    je push_chars
    inc ecx
    jmp find_len

push_chars:
    dec ecx
    mov ebx, ecx

    ; Push characters onto the stack
push_loop:
    cmp ebx, -1
    je pop_chars
    mov al, [input + ebx]
    push eax
    dec ebx
    jmp push_loop

pop_chars:
    ; Pop characters from the stack and store in buffer
    mov ecx, 0
pop_loop:
    cmp ecx, buffer_len
    je done
    pop eax
    mov [buffer + ecx], al
    inc ecx
    jmp pop_loop

done:
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, ecx
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
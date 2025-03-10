section .bss
    num resb 2
    result resw 1

section .data
    msg db 'The factorial is: ', 0

section .text
    global _start

_start:
    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 2
    int 0x80

    movzx ecx, byte [num]
    sub ecx, '0'

    ; Initialize result to 1
    mov ax, 1

factorial_loop:
    cmp ecx, 1
    jle end_factorial
    mul cx
    dec ecx
    jmp factorial_loop
    ret

end_factorial:
    mov [result], ax

    mov eax, [result]
    add eax, '0'
    mov [result], ax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 17
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 2
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80

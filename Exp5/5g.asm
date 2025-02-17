section .bss
    input1 resb 10
    input2 resb 10

section .data
    prompt1 db "Enter first input: ", 0
    prompt2 db "Enter second input: ", 0
    output db "You entered: ", 0

section .text
    global _start

%macro sys_write 3
    mov eax, 4
    mov ebx, %1
    mov ecx, %2
    mov edx, %3
    int 0x80
%endmacro

%macro sys_read 3
    mov eax, 3
    mov ebx, %1
    mov ecx, %2
    mov edx, %3
    int 0x80
%endmacro

_start:
    sys_write 1, prompt1, 17
    sys_read 0, input1, 10

    sys_write 1, prompt2, 18
    sys_read 0, input2, 10

    sys_write 1, output, 13
    sys_write 1, input1, 10
    sys_write 1, input2, 10

    mov eax, 1
    xor ebx, ebx
    int 0x80

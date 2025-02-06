section .bss
    num1 resb 4
    num2 resb 4
    num3 resb 4

section .data
    prompt1 db "Enter first number: ", 0
    prompt2 db "Enter second number: ", 0
    prompt3 db "Enter third number: ", 0
    larger db "The largest number is: ", 0
    newline db 10, 0

section .text
    global _start

_start:
    ; Prompt and read first number
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt1
    mov edx, 20
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 4
    int 80h

    mov eax, [num1]
    sub eax, '0'
    mov [num1], eax

    ; Prompt and read second number
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 21
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 80h

    mov eax, [num2]
    sub eax, '0'
    mov [num2], eax

    ; Prompt and read third number
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt3
    mov edx, 20
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, num3
    mov edx, 4
    int 80h

    mov eax, [num3]
    sub eax, '0'
    mov [num3], eax

    ; Compare numbers
    mov eax, [num1]
    mov ebx, [num2]
    cmp eax, ebx
    jge compare_num1_num3
    jle compare_num2_num3

compare_num1_num3:
    mov eax, [num1]
    mov ebx, [num3]
    cmp eax, ebx
    jge num1_larger
    jle num3_larger

compare_num2_num3:
    mov eax, [num2]
    mov ebx, [num3]
    cmp eax, ebx
    jge num2_larger
    jle num3_larger

num1_larger:
    mov eax, 4
    mov ebx, 1
    mov ecx, larger
    mov edx, 22
    int 80h

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

num3_larger:
    mov eax, 4
    mov ebx, 1
    mov ecx, larger
    mov edx, 22
    int 80h

    mov eax, [num3]
    add eax, '0'
    mov [num3], eax
    mov eax, 4
    mov ebx, 1
    mov ecx, num3
    mov edx, 1
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
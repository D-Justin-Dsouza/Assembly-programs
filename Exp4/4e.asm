section .data
    msg1 db "Enter first string: ", 0
    msg1_len equ $-msg1
    msg2 db "Enter second string: ", 0
    msg2_len equ $-msg2
    equalMsg db "Strings are equal", 0
    notEqualMsg db "Strings are not equal", 0

section .bss
    str1 resb 100
    str2 resb 100
    len1 resb 1
    len2 resb 1

section .text
    global _start

_start:
    ; Read first string
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msg1_len
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, str1
    mov edx, 100
    int 80h
    mov [len1], al
    mov byte [str1 + eax - 1], 0

    ; Read second string
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msg2_len
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, str2
    mov edx, 100
    int 80h
    mov [len2], al
    mov byte [str2 + eax - 1], 0

    ; Compare strings
    mov esi, str1
    mov edi, str2
    mov ecx, 100
    repe cmpsb
    je strings_equal
    jne strings_not_equal

strings_equal:
    mov eax, 4
    mov ebx, 1
    mov ecx, equalMsg
    mov edx, 17
    int 80h
    jmp exit

strings_not_equal:
    mov eax, 4
    mov ebx, 1
    mov ecx, notEqualMsg
    mov edx, 21
    int 80h

exit:
    mov eax, 1
    xor ebx, ebx
    int 80h
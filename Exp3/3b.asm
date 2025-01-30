section .data
    msg1 db "Enter first number: ", 0
    msg2 db "Enter second number: ", 0
    newline db 10, 0  
    resultAdd db "Sum: ", 0
    resultSub db "Difference: ", 0
    resultMul db "Product: ", 0
    resultQuo db "Quotient: ", 0
    resultRem db "Remainder: ", 0

section .bss
    number1 resb 1
    number2 resb 1
    output resb 1 

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 20
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, number1
    mov edx, 2 
    int 80h

    mov al, [number1]
    sub al, '0'
    mov [number1], al

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, 21
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, number2
    mov edx, 2  
    int 80h

    mov al, [number2]
    sub al, '0'
    mov [number2], al

    mov al, [number1]
    add al, [number2]
    add al, '0'   ; Convert to ASCII
    mov [output], al

    mov eax, 4
    mov ebx, 1
    mov ecx, resultAdd
    mov edx, 5
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    mov al, [number1]
    sub al, [number2]
    add al, '0'  
    mov [output], al

    mov eax, 4
    mov ebx, 1
    mov ecx, resultSub
    mov edx, 11
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    ; ---- Multiplication ----
    mov al, [number1]
    mov bl, [number2]
    mul bl
    add al, '0'   ; Convert to ASCII
    mov [output], al

    mov eax, 4
    mov ebx, 1
    mov ecx, resultMul
    mov edx, 9
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    ; ---- Division ----
    mov al, [number1]
    mov ah, 0
    mov bl, [number2]
    div bl    ; AL = quotient, AH = remainder

    add al, '0'   ; Convert quotient to ASCII
    mov [output], al

    mov eax, 4
    mov ebx, 1
    mov ecx, resultQuo
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    ; ---- Remainder ----
    mov al, ah  ; Remainder is in AH
    add al, '0'   ; Convert remainder to ASCII
    mov [output], al

    mov eax, 4
    mov ebx, 1
    mov ecx, resultRem
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    ; Exit program
    mov eax, 1
    mov ebx, 0
    int 80h

%macro print 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read_input 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
    mov al, [%1]
    sub al, '0'
    mov [%1], al
%endmacro

%macro calc_add 2
    mov al, [%1]
    add al, [%2]
    add al, '0'
    mov [output], al
%endmacro

%macro calc_sub 2
    mov al, [%1]
    sub al, [%2]
    add al, '0'
    mov [output], al
%endmacro

%macro calc_mul 2
    mov al, [%1]
    mov bl, [%2]
    mul bl
    add al, '0'
    mov [output], al
%endmacro

%macro calc_div 2
    mov al, [%1]
    mov ah, 0
    mov bl, [%2]
    div bl
    add al, '0'
    mov [output], al
%endmacro

%macro calc_rem 2
    mov al, [%1]
    mov ah, 0
    mov bl, [%2]
    div bl
    mov al, ah
    add al, '0'
    mov [output], al
%endmacro

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
    print msg1, 20
    read_input number1, 2

    print msg2, 21
    read_input number2, 2

    calc_add number1, number2
    print resultAdd, 5
    print output, 1
    print newline, 1

    calc_sub number1, number2
    print resultSub, 11
    print output, 1
    print newline, 1

    calc_mul number1, number2
    print resultMul, 9
    print output, 1
    print newline, 1

    calc_div number1, number2
    print resultQuo, 10
    print output, 1
    print newline, 1

    calc_rem number1, number2
    print resultRem, 10
    print output, 1
    print newline, 1

    mov eax, 1
    mov ebx, 0
    int 80h

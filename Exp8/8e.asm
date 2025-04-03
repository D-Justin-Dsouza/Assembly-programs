section .data
    nl db "", 10
    nllen equ $-nl

    msg1 db 'Enter number of elements: '
    msg1len equ $-msg1

    msg2 db 'Enter elements'
    msg2len equ $-msg2

    msg3 db 'Sum: '
    msg3len equ $-msg3

    arr times 100 db 0

%macro write 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro read 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro endl 0
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, nllen
    int 80h
%endmacro

section .bss
    cnt resb 1
    n resb 1
    ele resb 1
    sm resb 1

section .text
    global _start
_start:
    write msg1, msg1len
    read n, 2
    mov byte [cnt], 0
    mov esi, arr
    write msg2, msg2len
    endl
    input:
        read ele, 2
        mov ebx, [ele]
        mov [esi], ebx

        inc esi
        inc byte [cnt]

        mov al, [cnt]
        mov bl, [n]
        sub bl, '0'

        cmp al, bl
        je exit
        jmp input
    
    exit:
    mov esi, arr
    mov byte [cnt], 0
    mov byte [sm], 0
    
    fsum:
        mov bl, [esi]
        sub bl, '0'
        add byte [sm], bl

        inc esi
        inc byte[cnt]

        mov al, [cnt]
        mov bl, [n]
        sub bl, '0'
        cmp al, bl
        jl fsum
    
    add byte[sm], '0'
    write msg3, msg3len
    write sm, 1
    endl

    mov eax, 1
    mov ebx, 0
    int 80h

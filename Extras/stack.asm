section .data
    stack db 1,2,3,4,5 ; Define an array of 10 bytes initialized to 0
    top db -1           ; Initialize top of stack to -1 (empty stack)
    newline db 0xA      ; Newline character

section .bss

section .text
    global _start

_start:
    ; Push values onto the stack
    mov al, 5
    call push
    call print_stack
    mov al, 10
    call push
    call print_stack
    mov al, 15
    call push
    call print_stack

    ; Pop values from the stack
    call pop
    call print_stack
    call pop
    call print_stack
    call pop
    call print_stack
    call pop
    call print_stack

    ; Exit program
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; status 0
    int 0x80

push:
    ; Check if stack is full
    mov al, [top]
    cmp al, 9
    jae stack_full

    ; Increment top and push value
    inc byte [top]
    mov bl, [top]
    mov [stack + ebx], al
    ret

pop:
    ; Check if stack is empty
    mov al, [top]
    cmp al, -1
    jbe stack_empty

    ; Pop value and decrement top
    mov bl, [top]
    mov al, [stack + ebx]
    dec byte [top]
    ret

stack_full:
    ; Handle stack full condition
    ; For simplicity, we just return
    ret

stack_empty:
    ; Handle stack empty condition
    ; For simplicity, we just return
    ret

print_stack:
    ; Print the current stack
    mov ecx, stack      ; Point to the start of the stack
    mov edx, 10         ; Number of bytes to print
print_loop:
    mov al, [ecx]
    call print_byte
    inc ecx
    dec edx
    jnz print_loop
    call print_newline
    ret

print_byte:
    ; Print a byte in AL as a decimal number
    ; Convert to ASCII and print
    add al, '0'
    mov [esp-1], al
    mov eax, 4          ; sys_write
    mov ebx, 1          ; file descriptor (stdout)
    lea ecx, [esp-1]    ; address of the byte
    mov edx, 1          ; number of bytes
    int 0x80
    ret

print_newline:
    ; Print a newline character
    mov eax, 4          ; sys_write
    mov ebx, 1          ; file descriptor (stdout)
    lea ecx, [newline]
    mov edx, 1          ; number of bytes
    int 0x80
    ret
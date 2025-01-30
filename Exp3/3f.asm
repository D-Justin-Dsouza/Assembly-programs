section .data
    msg db 'Odd numbers from 0 to 9:', 10, 0 ; Message with newline
    newline db 10, 0                         ; Newline character
    current db 0                             ; Start with 0
    max db 9                                 ; Maximum number (9)

section .bss
    output resb 1                            ; Reserve 1 byte for output

section .text
    global _start

_start:
    ; Print the message
    mov eax, 4          ; sys_write
    mov ebx, 1          ; File descriptor (stdout)
    mov ecx, msg        ; Address of the message
    mov edx, 24         ; Length of the message
    int 80h

    ; Initialize loop
    mov al, [current]   ; Start with 0

check_odd:
    ; Check if the number is odd (current % 2 != 0)
    mov ah, 0           
    mov bl, 2           ; divide by 2
    div bl              
    cmp ah, 1           ; Check if remainder is 1 
    jne skip_number      ; If not \ skip to the next number

    ; Convert the number to ASCII
    mov al, [current]   
    add al, '0'         
    mov [output], al    

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

skip_number:
    ; Move to the next number
    mov al, [current]   ; Load the current number
    inc al              ; Increment the number by 1
    mov [current], al   ; Store the updated number

    ; Check if we've reached the maximum (9)
    cmp al, [max]       ; Compare current number with the maximum
    jg end_program      

    jmp check_odd       

end_program:
    mov eax, 1          
    mov ebx, 0          
    int 80h

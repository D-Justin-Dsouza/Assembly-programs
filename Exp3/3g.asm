section .data
    msg db 'Multiples of 3 from 0 to 9:', 10, 0 
    newline db 10, 0                     
    current db 0                   
    max db 9                              

section .bss
    output resb 1                          

section .text
    global _start

_start:
    mov eax, 4          
    mov ebx, 1          
    mov ecx, msg        
    mov edx, 26      
    int 80h

    mov eax, 4          
    mov ebx, 1          
    mov ecx, newline    
    mov edx, 1          
    int 80h

    mov al, [current] 

check_multiple:
    mov ah, 0           
    mov bl, 3          
    div bl              
    cmp ah, 0       
    jne skip_number 

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
    mov al, [current]   
    inc al              
    mov [current], al   
    cmp al, [max]       
    jg end_program      

    jmp check_multiple  

end_program:
    mov eax, 1          
    mov ebx, 0          
    int 80h

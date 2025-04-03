section .data
    prompt db "Enter number: ", 0
    prompt_len equ $ - prompt
    odd_msg db "Number of odd numbers: ", 0
    odd_len equ $ - odd_msg
    even_msg db "Number of even numbers: ", 0
    even_len equ $ - even_msg
    newline db 10, 0

section .bss
    array resw 5        
    num resb 10       
    odd_count resw 1    
    even_count resw 1    

section .text
    global _start
    extern atoi

_start:
    mov word [odd_count], 0
    mov word [even_count], 0
    mov ecx, 5      
    mov esi, array   
    
input_loop:
    push ecx     
    
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, prompt_len
    int 80h
    
    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 10     
    int 80h
    
    call atoi
    mov ax, dx
    
    mov [esi], ax
    
    mov dx, ax
    and dx, 1    
    cmp dx, 0
    je even
    inc word [odd_count]
    jmp continue
    
even:
    inc word [even_count]
    
continue:
    add esi, 2       
    pop ecx  
    loop input_loop
    
    mov eax, 4
    mov ebx, 1
    mov ecx, odd_msg
    mov edx, odd_len
    int 80h
    
    mov ax, [odd_count]
    add ax, '0'
    mov [num], ax
    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, even_msg
    mov edx, even_len
    int 80h
    
    mov ax, [even_count]
    add ax, '0'
    mov [num], ax
    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h
    
    mov eax, 1
    xor ebx, ebx
    int 80h

atoi:
    xor ax, ax 
    xor dx, dx 
    xor cx, cx 

    mov esi, num

    mov al, [esi]
    cmp al, '-'
    jne convert
    inc esi  
    inc cx   

convert:
    xor bx, bx  

convert_loop:
    mov al, [esi]   
    cmp al, 10      
    je finish
    cmp al, 0        
    je finish
    cmp al, '0'     
    jb finish
    cmp al, '9'      
    ja finish

    sub al, '0'      
    imul bx, bx, 10 
    add bx, ax      

    inc esi        
    jmp convert_loop

finish:
    cmp cx, 0      
    je store_result
    neg bx

store_result:
    mov dx, bx 
    ret

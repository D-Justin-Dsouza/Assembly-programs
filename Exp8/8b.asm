section .data
    prompt db "Enter number: ", 0
    prompt_len equ $ - prompt
    pos_msg db "Number of positive numbers: ", 0
    pos_len equ $ - pos_msg
    neg_msg db "Number of negative numbers: ", 0
    neg_len equ $ - neg_msg
    newline db 10, 0

section .bss
    array resw 5        
    num resb 10       
    pos_count resw 1    
    neg_count resw 1    

section .text
    global _start
    extern atoi

_start:
    mov word [pos_count], 0
    mov word [neg_count], 0
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
    
    cmp ax, 0
    jl negative
    inc word [pos_count]
    jmp continue
    
negative:
    inc word [neg_count]
    
continue:
    add esi, 2       
    pop ecx  
    loop input_loop
    
    mov eax, 4
    mov ebx, 1
    mov ecx, pos_msg
    mov edx, pos_len
    int 80h
    
    mov ax, [pos_count]
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
    mov ecx, neg_msg
    mov edx, neg_len
    int 80h
    
    mov ax, [neg_count]
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

section .data
    prompt db "Enter number: ", 0
    prompt_len equ $ - prompt
    greater_msg db "Number of numbers greater than 5: ", 0
    greater_len equ $ - greater_msg
    less_msg db "Number of numbers less than 5: ", 0
    less_len equ $ - less_msg
    equal_msg db "Number of numbers equal to 5: ", 0
    equal_len equ $ - equal_msg
    newline db 10, 0

section .bss
    array resw 5        
    num resb 10       
    greater_count resw 1    
    less_count resw 1    
    equal_count resw 1

section .text
    global _start
    extern atoi

_start:
    mov word [greater_count], 0
    mov word [less_count], 0
    mov word [equal_count], 0
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
    
    cmp ax, 5
    jg greater
    jl less
    je equal
    jmp continue
    
greater:
    inc word [greater_count]
    jmp continue
equal:
    inc word [equal_count]
    jmp continue
less:
    inc word [less_count]
    
continue:
    add esi, 2       
    pop ecx  
    loop input_loop
    
    mov eax, 4
    mov ebx, 1
    mov ecx, greater_msg
    mov edx, greater_len
    int 80h
    
    mov ax, [greater_count]
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
    mov ecx, less_msg
    mov edx, less_len
    int 80h
    
    mov ax, [less_count]
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
    mov ecx, equal_msg
    mov edx, equal_len
    int 80h
    
    mov ax, [equal_count]
    add ax, '0'
    mov [num], ax
    mov eax, 4
    mov ebx, 1
    mov ecx, num
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

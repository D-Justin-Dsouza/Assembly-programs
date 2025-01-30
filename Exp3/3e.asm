section .data
    msg db 'Enter a number: ', 0
    result_msg db 'Next 4 numbers are: ', 0
    newline db 0x0A, 0
    num_input resb 4 

section .bss
    num resb 1  

section .text
    global _start

_start:
    mov eax, 4        
    mov ebx, 1     
    mov ecx, msg       
    mov edx, 17    
    int 80h

    mov eax, 3      
    mov ebx, 0    
    mov ecx, num_input  
    mov edx, 4    
    int 80h

    mov eax, [num_input]
    sub al, '0'
    mov [num], al     

    mov eax, 4   
    mov ebx, 1       
    mov ecx, result_msg  
    mov edx, 22      
    int 80h

    mov ecx, 4        
    mov al, [num]    

    inc al  
    add al, '0'        
    mov [num], al      

    mov eax, 4         
    mov ebx, 1     
    lea ecx, [num]      
    mov edx, 1       
    int 80h

    mov eax, 4      
    mov ebx, 1          
    mov ecx, newline   
    mov edx, 1      
    int 80h

    mov ecx, 4        
    mov al, [num]    

    inc al         
    mov [num], al      

    mov eax, 4         
    mov ebx, 1     
    lea ecx, [num]      
    mov edx, 1       
    int 80h

    mov eax, 4      
    mov ebx, 1          
    mov ecx, newline   
    mov edx, 1      
    int 80h

    mov ecx, 4        
    mov al, [num]    

    inc al          
    mov [num], al      

    mov eax, 4         
    mov ebx, 1     
    lea ecx, [num]      
    mov edx, 1       
    int 80h

    mov eax, 4      
    mov ebx, 1          
    mov ecx, newline   
    mov edx, 1      
    int 80h

    mov ecx, 4        
    mov al, [num]    

    inc al          
    mov [num], al      

    mov eax, 4         
    mov ebx, 1     
    lea ecx, [num]      
    mov edx, 1       
    int 80h

    mov eax, 4      
    mov ebx, 1          
    mov ecx, newline   
    mov edx, 1      
    int 80h

mov eax, 1   
mov ebx, 0   
int 80h

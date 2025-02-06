section .data
    array db 8,7,9,2,3,1,0,6,5,4  ; Array of elements
    size db 10                                       ; Number of elements
    newline db 10                                    ; Newline character

section .bss
    i resb 1
    j resb 1
    min_index resb 1
    temp resb 1

section .text
    global _start
    extern printf

_start:
    mov byte [i], 0                ; i = 0 (outer loop index)

outer_loop:
    mov al, [i]
    cmp al, [size]                 ; if i >= size, end sorting
    jge end_sort

    mov [min_index], al             ; min_index = i
    mov [j], al                     ; j = i + 1
    inc byte [j]

inner_loop:
    mov al, [j]
    cmp al, [size]                  ; if j >= size, go to swap
    jge swap

    ; Load values from array[j] and array[min_index]
    movzx edx, byte [j]
    movzx eax, byte [array + edx]   ; eax = array[j]

    movzx edx, byte [min_index]
    movzx ebx, byte [array + edx]   ; ebx = array[min_index]

    cmp eax, ebx
    jge skip                        ; if array[j] >= array[min_index], skip

    mov byte [min_index], [j]       ; min_index = j

skip:
    inc byte [j]                    ; j++
    jmp inner_loop

swap:
    movzx edx, byte [i]
    movzx eax, byte [array + edx]   ; temp = array[i]

    movzx edx, byte [min_index]
    movzx ebx, byte [array + edx]   ; ebx = array[min_index]

    mov [array + edx], al           ; array[min_index] = temp

    movzx edx, byte [i]
    mov [array + edx], bl           ; array[i] = array[min_index]

    inc byte [i]                    ; i++
    jmp outer_loop                  ; repeat sorting

end_sort:
    ; Print sorted array
    mov byte [i], 0

print_loop:
    movzx edx, byte [i]
    cmp dl, [size]
    jge exit                        ; If i >= size, exit

    ; Load array[i] and convert to ASCII
    movzx eax, byte [array + edx]
    add eax, '0'                    ; Convert number to ASCII
    mov [temp], al

    ; Print character
    mov eax, 4
    mov ebx, 1
    lea ecx, [temp]
    mov edx, 1
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    inc byte [i]
    jmp print_loop

exit:
    mov eax, 1
    int 0x80

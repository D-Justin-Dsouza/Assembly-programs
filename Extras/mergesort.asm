section .data
    array db 8, 7, 3, 4, 9, 2, 0
    array_len equ 7
    newline db 10        ; newline character

section .bss
    temp resb array_len

section .text
    global _start

_start:
    mov esi, array       ; pointer to array
    xor edi, edi         ; left index = 0
    mov ecx, array_len   ; right index = array_len - 1
    dec ecx

    push ecx
    push edi
    push esi
    call merge_sort
    add esp, 12

    mov esi, array       ; pointer to array
    mov ecx, array_len   ; array length

print_loop:
    mov al, [esi]        ; load byte from array
    add al, '0'          ; convert to ASCII
    mov [temp], al       ; store in temp
    mov eax, 4           ; sys_write
    mov ebx, 1           ; file descriptor (stdout)
    lea ecx, [temp]      ; pointer to temp
    mov edx, 1           ; number of bytes
    int 0x80

    inc esi              ; move to next element
    loop print_loop

    mov eax, 4           ; sys_write
    mov ebx, 1           ; file descriptor (stdout)
    lea ecx, [newline]   ; pointer to newline
    mov edx, 1           ; number of bytes
    int 0x80

    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; exit code 0
    int 0x80

merge_sort:
    push ebp
    mov ebp, esp

    mov eax, [ebp+12]   ; right index
    mov ebx, [ebp+8]    ; left index
    cmp eax, ebx
    jle .done           ; if left >= right, return

    add eax, ebx
    shr eax, 1          ; middle index = (left + right) / 2
    push eax            ; save middle index

    push dword [ebp+16]
    push dword [ebp+8]
    push eax
    call merge_sort
    add esp, 12

    inc eax            ; middle index + 1
    push dword [ebp+16]
    push eax
    push dword [ebp+12]
    call merge_sort
    add esp, 12

    pop eax            ; restore middle index
    push dword [ebp+16]
    push dword [ebp+8]
    push eax
    push dword [ebp+12]
    call merge
    add esp, 16

.done:
    mov esp, ebp
    pop ebp
    ret

merge:
    push ebp
    mov ebp, esp

    mov esi, [ebp+16]   ; pointer to array
    mov edi, [ebp+8]    ; left index
    mov ebx, [ebp+12]   ; middle index
    mov edx, [ebp+20]   ; right index

    mov eax, edi        ; left index
    mov ecx, 0          ; temp index
    mov ebx, ebx        ; middle index
    inc ebx             ; middle index + 1

.merge_loop:
    cmp eax, [ebp+12]
    jg .right_half
    cmp ebx, [ebp+20]
    jg .left_half

    mov dl, [esi+eax]
    mov dh, [esi+ebx]
    cmp dl, dh
    jle .copy_left

    mov [temp+ecx], dh
    inc ebx
    jmp .next

.copy_left:
    mov [temp+ecx], dl
    inc eax

.next:
    inc ecx
    jmp .merge_loop

.left_half:
    cmp eax, [ebp+12]
    jg .done_merge
    mov dl, [esi+eax]
    mov [temp+ecx], dl
    inc eax
    inc ecx
    jmp .left_half

.right_half:
    cmp ebx, [ebp+20]
    jg .done_merge
    mov dh, [esi+ebx]
    mov [temp+ecx], dh
    inc ebx
    inc ecx
    jmp .right_half

.done_merge:
    mov ecx, 0
    mov eax, edi
.copy_back:
    cmp eax, edx
    jg .done_copy
    mov dl, [temp+ecx]
    mov [esi+eax], dl
    inc eax
    inc ecx
    jmp .copy_back

.done_copy:
    mov esp, ebp
    pop ebp
    ret

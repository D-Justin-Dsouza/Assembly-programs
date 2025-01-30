section .data
    msgEnterLength db "Enter rectangle length: ", 0
    msgEnterWidth db "Enter rectangle width: ", 0
    msgRectangleArea db "Rectangle Area: ", 0
    msgRectanglePerimeter db "Rectangle Perimeter: ", 0

    msgEnterA db "Enter triangle side a: ", 0
    msgEnterB db "Enter triangle side b: ", 0
    msgEnterC db "Enter triangle side c: ", 0
    msgEnterH db "Enter triangle height: ", 0
    msgEnterE db "Enter triangle base: ", 0
    msgTriangleArea db "Triangle Area: ", 0
    msgTrianglePerimeter db "Triangle Perimeter: ", 0

    newline db 10, 0
    space db " ", 0

section .bss
    length resb 10
    width resb 10
    rectangleArea resb 10
    rectanglePerimeter resb 10

    sideA resb 10
    sideB resb 10
    sideC resb 10
    height resb 10
    base resb 10
    triangleArea resb 10
    trianglePerimeter resb 10

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgEnterLength
    mov edx, 24
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, length
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, msgEnterWidth
    mov edx, 23
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, width
    mov edx, 10
    int 80h

    mov eax, [length]
    sub eax, '0'
    mov ebx, [width]
    sub ebx, '0'

    mul ebx
    add eax, '0'
    mov [rectangleArea], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, msgRectangleArea
    mov edx, 16
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, rectangleArea
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    mov eax, [length]
    sub eax, '0'
    mov ebx, [width]
    sub ebx, '0'
    add eax, ebx
    shl eax, 1
    add eax, '0'
    mov [rectanglePerimeter], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, msgRectanglePerimeter
    mov edx, 22
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, rectanglePerimeter
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h


    mov eax, 4
    mov ebx, 1
    mov ecx, msgEnterA
    mov edx, 24
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, sideA
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, msgEnterB
    mov edx, 24
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, sideB
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, msgEnterC
    mov edx, 24
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, sideC
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, msgEnterH
    mov edx, 22
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, height
    mov edx, 10
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, msgEnterE
    mov edx, 22
    int 80h

    mov eax, 3
    mov ebx, 0
    mov ecx, base
    mov edx, 10
    int 80h

    mov eax, [sideA]
    sub eax, '0'
    mov ebx, [sideB]
    sub ebx, '0'
    mov ecx, [sideC]
    sub ecx, '0'
    mov edx, [height]
    sub edx, '0'
    mov edx, [base]
    sub edx, '0'

    add eax, ebx
    add eax, ecx
    add eax, '0'
    mov [trianglePerimeter], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, msgTrianglePerimeter
    mov edx, 20
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, trianglePerimeter
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    mov eax, [base]  
    sub eax, '0'
    mov ebx, [height]
    sub ebx, '0'
    mul ebx
    shr eax, 1 
    add eax, '0'
    mov [triangleArea], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, msgTriangleArea
    mov edx, 15
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, triangleArea
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

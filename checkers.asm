; Copyright 2023 Nastase Cristian-Gabriel 315CA

section .data

i:  ; i <- x
    dd 0
j:  ; j <- y
    dd 0
pos:
    dd 0

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ; storing in i and j, x and y
    mov [i], eax
    mov [j], ebx

    xor ebx, ebx
    mov ebx, 8
    mul ebx

    mov ebx, [j]
    add eax, ebx
    mov [pos], eax
    ; I calculated the position in the table


    if_1: ; if (x - 1 >= 0 && y - 1 >= 0)

        mov eax, [i]
        dec eax
        cmp eax, 0
        jl if_2

        mov eax, [j]
        dec eax
        cmp eax, 0
        jl if_2

        ; check[x - 1][y - 1] = 1;
        mov eax, [pos]
        mov BYTE [ecx + eax - 9], 1

    if_2: ; if(x - 1 >= 0 && y + 1 <= 7)

        mov eax, [i]
        dec eax
        cmp eax, 0
        jl if_3

        mov eax, [j]
        inc eax
        cmp eax, 7
        jg if_3

        ; check[x - 1][y + 1] = 1
        mov eax, [pos]
        mov BYTE [ecx + eax - 7], 1

    if_3: ; if(x + 1 <= 7 && y - 1 >= 0)

        mov eax, [i]
        inc eax
        cmp eax, 7
        jg if_4

        mov eax, [j]
        dec eax
        cmp eax, 0
        jl if_4

        ; check[x + 1][y - 1] = 1
        mov eax, [pos]
        mov BYTE [ecx + eax + 7], 1

    if_4: ; if(x + 1 <= 7 && y + 1 <= 7)

        mov eax, [i]
        inc eax
        cmp eax, 7
        jg end_ifs

        mov eax, [j]
        inc eax
        cmp eax, 7
        jg end_ifs

        ; check[x + 1][y + 1] = 1;
        mov eax, [pos]
        mov BYTE [ecx + eax + 9], 1

    end_ifs:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

;             For a easier implementation i wrote the solution in C,
;     and guided myself with this code:
;
;     if(x - 1 >= 0 && y - 1 >= 0) {
;         check[x - 1][y - 1] = 1;
;     }
;     if(x - 1 >= 0 && y + 1 <= 7) {
;         check[x - 1][y + 1] = 1;
;     }
;     if(x + 1 <= 7 && y - 1 >= 0) {
;         check[x + 1][y - 1] = 1;
;     }
;     if(x + 1 <= 7 && y + 1 <= 7) {
;         check[x + 1][y + 1] = 1;
;     }
;
;         I went through this code line by line and
;     tried to implement in asm as well as I could.
;         The principle of this code is verifying if every corner
;     exists. If so, write 1 at the correspondant position

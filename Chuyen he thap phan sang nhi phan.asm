.model small
.stack 100h

.data
    ms1 db 'Nhap so thap phan (0-255): $'
    ms2 db 13, 10, 'So nhi phan: $'

.code
main proc
    ; HEADER: Initialize DS
    mov ax, @data
    mov ds, ax

    ; Print the prompt
    mov ah, 9
    lea dx, ms1
    int 21h

    ; Prepare decimal input
    mov bh, 0
    mov bl, 10

read_again:
    mov ah, 1
    int 21h

    cmp al, 13
    je input_done

    sub al, 48
    mov cl, al          ; save the new digit

    mov al, bh
    mul bl              ; old number * 10
    add al, cl          ; add the new digit
    mov bh, al

    jmp read_again

input_done:
    ; Print the result message
    mov ah, 9
    lea dx, ms2
    int 21h

    ; Prepare binary conversion
    mov al, bh
    mov bl, 2           ; binary base
    mov cx, 0           ; bit count

divide_again:
    mov ah, 0
    div bl              ; remainder is always 0 or 1

    push ax             ; save the remainder inside AH
    inc cx

    cmp al, 0
    jne divide_again

print_again:
    pop dx              ; saved remainder is now in DH
    mov dl, dh
    add dl, 48          ; 0 -> '0', 1 -> '1'

    mov ah, 2
    int 21h

    loop print_again

    ; FOOTER: Exit
    mov ah, 4ch
    int 21h
main endp
end main
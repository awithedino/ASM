.model small
.stack 100h

.data
    ms1 db 'Nhap so (0-255): $'
    ms2 db 13, 10, 'So vua nhap: $'

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
    mov bh, 0           ; accumulated number
    mov bl, 10          ; decimal base

read_again:
    mov ah, 1
    int 21h

    cmp al, 13
    je input_done

    sub al, 48          ; ASCII -> numeric digit
    mov cl, al          ; save the new digit

    ; New number = old number * 10 + digit
    mov al, bh
    mul bl              ; AX = AL * BL
    add al, cl
    mov bh, al

    jmp read_again

input_done:
    ; Print the output message
    mov ah, 9
    lea dx, ms2
    int 21h

    ; Prepare repeated division
    mov al, bh
    mov bl, 10
    mov cx, 0           ; number of digits pushed

divide_again:
    mov ah, 0
    div bl              ; AL = quotient, AH = remainder

    push ax             ; save quotient AND remainder
    inc cx              ; count one saved digit

    cmp al, 0
    jne divide_again    ; continue if quotient is not zero

print_again:
    pop dx              ; saved AH -> DH, saved AL -> DL
    mov dl, dh          ; retrieve the remainder
    add dl, 48          ; digit -> ASCII

    mov ah, 2
    int 21h

    loop print_again    ; decrease CX; repeat if not zero

    ; FOOTER: Exit
    mov ah, 4ch
    int 21h
main endp
end main
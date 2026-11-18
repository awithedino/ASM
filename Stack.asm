.model small
.stack 100h

.data

.code
main proc
    ; HEADER: Initialize DS
    mov ax, @data
    mov ds, ax

    ; Push three character values
    mov ax, 0041h       ; 'A'
    push ax

    mov ax, 0042h       ; 'B'
    push ax

    mov ax, 0043h       ; 'C'
    push ax

    ; Print three values from the stack
    mov cx, 3

print_again:
    pop dx              ; retrieve the latest saved word
                        ; DL contains its character code
    mov ah, 2
    int 21h

    loop print_again

    ; FOOTER: Exit
    mov ah, 4ch
    int 21h
main endp
end main
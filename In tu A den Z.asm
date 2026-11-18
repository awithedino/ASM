; In tu A den Z dung loop
.model small
.stack 100h

.data

.code
main proc
    ; HEADER: Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Set the loop counter: CX = 26
    mov ch, 0       ; clear the high byte of CX
    mov cl, 26      ; 26 letters to print

    ; Prepare character output
    mov ah, 2       ; DOS service: print the character in DL
    mov dl, 'A'     ; start with uppercase A

intiep:
    ; Print the current letter
    int 21h

    ; Save the letter and print a space
    mov bl, dl      ; copy the current letter into BL
    mov dl, 32      ; ASCII 32 = space
    int 21h

    ; Restore the letter and advance to the next one
    mov dl, bl      ; retrieve the saved letter
    add dl, 1       ; next ASCII character: A -> B -> C...

    ; Decrease CX by 1; repeat if CX is not zero
    loop intiep

    ; FOOTER: Exit to DOS
    mov ah, 4ch
    int 21h
main endp
end main
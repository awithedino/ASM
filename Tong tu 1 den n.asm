; Read n and calculate S = 1 + 2 + ... + n
; Input: one digit, 0–9
.model small
.stack 100h

.data
    ms1 db 'Nhap n: $'
    ms2 db 10, 13, 'S = $'

.code
main proc
    ; HEADER: Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Print the input prompt
    mov ah, 9
    lea dx, ms1
    int 21h

    ; Read one digit, convert it, and save n
    mov ah, 1
    int 21h             ; AL = ASCII character
    sub al, 48          ; convert character into numeric value
    mov bl, al          ; BL = n

    ; Print the result message
    mov ah, 9
    lea dx, ms2
    int 21h

    ; Initialize the calculation
    mov cl, 1           ; CL = i, the next number to add
    mov al, 0           ; AL = S, the running sum

    ; If n is zero, skip addition and print S = 0
    cmp bl, 0
    je print_result

addition:
    ; Add i to the running sum
    add al, cl          ; S = S + i
    inc cl              ; i = i + 1

    ; Continue while the next i is less than or equal to n
    cmp cl, bl
    jle addition ; le = less or equal

print_result:
    ; Split the sum into tens and units
    mov ah, 0           ; clear AH so AX contains only the sum
    mov bh, 10          ; divisor = 10
    div bh              ; AL = quotient, AH = remainder
    mov bh, ah          ; save units before changing AH

    ; Print the tens digit
    mov ah, 2
    mov dl, al          ; copy the quotient into DL
    add dl, 48          ; convert digit into ASCII
    int 21h

    ; Print the units digit
    mov dl, bh          ; retrieve the saved remainder
    add dl, 48          ; convert digit into ASCII
    int 21h             ; AH is still 2

    ; FOOTER: Exit to DOS
    mov ah, 4ch
    int 21h
main endp
end main
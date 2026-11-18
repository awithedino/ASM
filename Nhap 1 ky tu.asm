.model small
.stack 100h
.data
    ms1 db 'Nhap ky tu: $'
    ms2 db 13, 10, 'Ky tu vua nhap la: $'
.code
main proc
    ; Chuan bi truy cap data
    mov ax, @data
    mov ds, ax
    
    ; In prompt
    mov ah, 9
    lea dx, ms1
    int 21h
    
    ; Doc ky tu
    mov ah, 1
    int 21h
    mov bl, al
    
    ; In ket qua
    mov ah, 9
    lea dx, ms2
    int 21h
    
    ; In ky tu da luu
    mov ah, 2
    mov dl, bl
    int 21h
    
    ; Thoat
    mov ah, 4ch
    int 21h
main endp
end main
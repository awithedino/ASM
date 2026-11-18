.model small
.stack 100h
.data
    ms1 db 'Nhap so thu nhat: $'
    ms2 db 10, 13, 'Nhap so thu hai: $'
    ms3 db 10, 13, 'Tong cua hai so la: $'
.code
main proc
    ; HEADER: Init
    mov ax, @data
    mov ds, ax
    
    ; Print ms1
    mov ah, 9
    lea dx, ms1
    int 21h
    
    ; Read and convert
    mov ah, 1
    int 21h
    sub al, 48
    mov bl, al
    
    ; Print ms2 
    mov ah, 9
    lea dx, ms2
    int 21h
    
    ; Read and convert
    mov ah, 1
    int 21h
    sub al, 48
    add al, bl
    
    ; Division
    mov ah, 0
    mov bh, 10
    div bh
    
    mov cl, ah ; Move the remainder to cl
    mov bl, al ; Move the result to bl
    
    ; Print ms3
    mov ah, 9
    lea dx, ms3
    int 21h
    
    ; Check if one digit or not
    cmp bl, 0
    je print_units
    
    ; Rebuild the number
    mov dl, bl
    add dl, 48
    mov ah, 2
    int 21h
    
print_units:
    ; Unit number
    mov dl, cl
    add dl, 48
    mov ah, 2
    int 21h
    
    ; FOOTER: Exit
    mov ah, 4ch
    int 21h
main endp
end main
   
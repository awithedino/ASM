.model small
.stack 100h
.data
    ms1 db 'Nhap so thu nhat: $'
    ms2 db 10, 13, 'Nhap so thu hai: $'
    ms3 db 13, 10, 'Tong hai so: $'
    ms4 db 13, 10, 'Hieu hai so: $'
.code
main proc
    ; HEADER: Init
    mov ax, @data
    mov ds, ax
    
    ; Print ms1
    mov ah, 9
    lea dx, ms1
    int 21h
    
    ; Read, convert and save
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
    mov cl, al
    
    ; Print ms3
    mov ah, 9
    lea dx, ms3
    int 21h
    
    ; Calculate and print the sum
    mov dl, bl
    add dl, cl
    add dl, 48
    mov ah, 2
    int 21h
    
    ; Print ms4
    mov ah, 9
    lea dx, ms4
    int 21h
    
    ; Calculate and print diff
    mov dl, bl
    sub dl, cl
    add dl, 48
    mov ah, 2
    int 21h
    
    ; FOOTER: Exit
    mov ah, 4ch
    int 21h
main endp
end main

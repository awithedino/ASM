.model small
.stack 100h
.data
    ms1 db 'Nhap ky tu: $'
    ms2 db 13, 10, 'Ky tu dung truoc: $'
    ms3 db 13, 10, 'Ky tu dung sau: $'
.code
main proc
    ; HEADER: Init
    mov ax, @data
    mov ds, ax
    
    ; Print ms1
    mov ah, 9
    lea dx, ms1
    int 21h
    
    ; Read and save letter
    mov ah, 1
    int 21h
    mov bl, al
    
    ; Print ms2
    mov ah, 9
    lea dx, ms2
    int 21h
    
    ; Print the letter[n-1]
    mov ah, 2
    mov dl, bl
    dec dl
    int 21h
    
    ; Print ms3
    mov ah, 9
    lea dx, ms3
    int 21h
    
    ; Print the letter[n+1]
    mov ah, 2
    mov dl, bl
    inc dl
    int 21h
    
    ; FOOTER: Exit
    mov ah, 4ch
    int 21h
main endp
end main
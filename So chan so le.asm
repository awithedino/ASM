.model small
.stack 100h
.data
    ms1 db 13, 10, 'Nhap mot chu so (Enter de thoat): $'
    ms2 db 13, 10, 'So chan$'
    ms3 db 13, 10, 'So le$'
.code
main proc
    ; HEADER: Init
    mov ax, @data
    mov ds, ax
    
read_again: ; Nhap lai so    
    ; Print ms1
    mov ah, 9
    lea dx, ms1
    int 21h
    
    ; Read and convert
    mov ah, 1
    int 21h
    cmp al, 13
    je finish
    sub al, 48
    
    ; Division
    mov ah, 0
    mov bh, 2
    div bh
    
    ; Comparison
    cmp ah, 0
    je even_number
    
    ;If odd number
    mov ah, 9
    lea dx, ms3
    int 21h
    jmp loop_again
    
even_number: ; If even number
    mov ah, 9
    lea dx, ms2
    int 21h
    
loop_again: ; Loop   
    jmp read_again    

finish: ; FOOTER: Exit    
    mov ah, 4ch
    int 21h
main endp
end main   
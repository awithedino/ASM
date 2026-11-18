.model small
.stack 100h
.data
    ms1 db 10, 13, 'Nhap so (Enter de thoat):$'
    ms2 db 10, 13, 'So chan$'
    ms3 db 10, 13, 'So le$'
    ms4 db 10, 13, 'So cac so le:$'
    ms5 db 10, 13, 'So cac so chan:$'
    demchan db 0;
    demle db 0;
.code
main proc
    ; HEADER: Init
    mov ax, @data
    mov ds, ax
    
read_again: ; Repeat    
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
    
    ; If odd number
    mov ah, 9
    lea dx, ms3
    int 21h
    inc demle ; tang len 1
    jmp loop_again
    
    ; If even number
even_number:
    mov ah, 9
    lea dx, ms2
    int 21h
    inc demchan ; tang len 1
    
loop_again: ; Loop
    jmp read_again
    
finish: 
    ; Print ms4
    mov ah, 9
    lea dx, ms4
    int 21h
    
    ; Print the counting result for odd
    mov dl, demle
    add dl, 48
    mov ah, 2
    int 21h
    
    ; Print ms5
    mov ah, 9
    lea dx, ms5
    int 21h
    
    ; Print the counting result for even
    mov dl, demchan
    add dl, 48
    mov ah, 2
    int 21h
    
    
    ; FOOTER: Exit
    mov ah, 4ch
    int 21h
main endp
end main
  
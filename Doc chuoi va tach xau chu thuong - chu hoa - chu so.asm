.model small
.stack 100h

.data
    input_prompt  db 'Enter a string: $'
    original_msg  db 13, 10, 'Original string: $'
    lowercase_msg db 13, 10, 'Lowercase letters: $'
    uppercase_msg db 13, 10, 'Uppercase letters: $'
    digits_msg    db 13, 10, 'Digits: $'
    empty_msg     db 'Empty!$'

    input_string     db 50 dup(?)
    lowercase_string db 50 dup(?)
    uppercase_string db 50 dup(?)
    digit_string     db 50 dup(?)

    digit_count dw 0

.code
main proc
    ; HEADER: Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Print the input prompt
    mov ah, 9
    lea dx, input_prompt
    int 21h

    xor bx, bx              ; BX = input position

read_input:
    mov ah, 1
    int 21h

    cmp al, 13
    je prepare_strings

    mov input_string[bx], al
    inc bx
    jmp read_input

prepare_strings:
    ; Terminate and print the original string
    mov input_string[bx], '$'

    mov ah, 9
    lea dx, original_msg
    int 21h

    lea dx, input_string
    int 21h

    ; Prepare the indexes for character separation
    dec bx
    mov cx, bx              ; CX = last input index
    mov bx, 0               ; BX = current input index
    mov si, 0               ; SI = lowercase index/count
    mov di, 0               ; DI = uppercase index/count

classify_character:
    ; Assumes input contains only ASCII letters and digits
    cmp input_string[bx], 'A'
    jl store_digit

    cmp input_string[bx], 'a'
    jge store_lowercase

    ; Store an uppercase letter
    mov al, input_string[bx]
    mov uppercase_string[di], al
    inc di
    jmp next_character

store_digit:
    ; Save the input index while BX indexes the digit string
    push bx

    mov al, input_string[bx]
    mov bx, digit_count
    mov digit_string[bx], al
    inc digit_count

    pop bx                  ; restore the input index
    jmp next_character

store_lowercase:
    mov al, input_string[bx]
    mov lowercase_string[si], al
    inc si

next_character:
    inc bx
    cmp bx, cx
    jle classify_character

    ; Terminate all three output strings
    push bx
    mov bx, digit_count

    mov lowercase_string[si], '$'
    mov uppercase_string[di], '$'
    mov digit_string[bx], '$'

    pop bx

    ; Print the lowercase heading
    mov ah, 9
    lea dx, lowercase_msg
    int 21h

    cmp si, 0
    jne print_lowercase

    ; No lowercase letters were stored
    lea dx, empty_msg
    int 21h
    jmp show_uppercase

print_lowercase:
    mov ah, 9
    lea dx, lowercase_string
    int 21h

show_uppercase:
    ; Print the uppercase heading
    mov ah, 9
    lea dx, uppercase_msg
    int 21h

    cmp di, 0
    jne print_uppercase

    ; No uppercase letters were stored
    lea dx, empty_msg
    int 21h
    jmp show_digits

print_uppercase:
    mov ah, 9
    lea dx, uppercase_string
    int 21h

show_digits:
    ; Print the digit heading
    mov ah, 9
    lea dx, digits_msg
    int 21h

    cmp digit_count, 0
    jne print_digits

    ; No digits were stored
    lea dx, empty_msg
    int 21h
    jmp program_exit

print_digits:
    mov ah, 9
    lea dx, digit_string
    int 21h

program_exit:
    ; FOOTER: Exit to DOS
    mov ah, 4ch
    int 21h
main endp
end main
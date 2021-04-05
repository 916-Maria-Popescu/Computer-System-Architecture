;Problema 19 lab 8
;Sa se citeasca de la tastatura un octet si un cuvant. Sa se afiseze pe ecran daca bitii octetului citit 
;se regasesc consecutiv printre bitii cuvantului. Exemplu:
;a = 10 = 0000 1010b
;b = 256 = 0000 0001 0000 0000b
;Pe ecran se va afisa NU.
;a = 0Ah = 0000 1010b
;b = 6151h = 0110 0001 0101 0001b

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start

extern exit, printf, scanf             
import exit msvcrt.dll    
import printf msvcrt.dll    
import scanf msvcrt.dll     

segment data use32 class=data
    a dd 0
    b dd 0
    format_decimal dd "%d", 0
    print_a db "a(byte)=", 0
    print_b db "b(word)=", 0
    format_a db "a = %d(decimal) = %d%d%d%d %d%d%d%d (binary)", 10, 13, 0
    format_b db "b = %d(decimal) = %d%d%d%d %d%d%d%d %d%d%d%d %d%d%d%d (binary)", 10, 13, 0
    print_yes db "Yes", 10, 13, 0
    print_no db "No", 0
    binary_representation_a times 8 dd 0 
    binary_representation_b times 16 dd 0
    

; our code starts here
segment code use32 class=code
    start:
    
    ; printf (format, value1, value2,....) for a = 
    push dword print_a
    call [printf]
    add esp, 4
    
    ;scanf (format, variable-offset) for a
    push dword a
    push dword format_decimal
    call [scanf]
    add esp, 4*2
    
    ;printf for b = 
    push dword print_b
    call [printf]
    add esp, 4
    
    ; scanf for b
    push dword b
    push dword format_decimal
    call [scanf]
    add esp, 4*2
  
    ;---------------------binary for a
    mov esi, binary_representation_a
    mov bl, 00000001b                                ; 00000...00001 (32 digits)
    mov ecx, 8                                      ; prepare ecx for the loop, we have 32 digits in number a, so we'll check everyone of them
    
    myloop:
        mov al, byte[a]
        and al, bl
        cmp al, 0 
        je zero
        
        ; one
        mov [esi], dword 1
        jmp continue_loop
        
        zero:
        mov [esi], dword 0
        
        continue_loop:
        add esi , 4
        shl ebx, 1
      
    loop myloop  

    ; printf "a = %d = %d"
    push dword [binary_representation_a]
    push dword [binary_representation_a+4]
    push dword [binary_representation_a+8]
    push dword [binary_representation_a+12]
    push dword [binary_representation_a+16]
    push dword [binary_representation_a+20]
    push dword [binary_representation_a+24]
    push dword [binary_representation_a+28]
    push dword [a]
    push dword format_a
    call [printf]
    add esp, 4 * 10
    
    
    ;---------------------------------binary for b
    mov edi, binary_representation_b
    mov bx, 0000000000000001b                       ; 00000...00001 (16 digits)
    mov ecx, 16                                      ; prepare ecx for the loop, we have 16 digits in number a, so we'll check everyone of them
    
    myloop2:
        mov ax, word[b]
        and ax, bx
        cmp ax, 0 
        je zero2
        
        ; one
        mov [edi], dword 1
        jmp continue_loop2
        
        zero2:
        mov [edi], dword 0
        
        continue_loop2:
        add edi , 4
        shl ebx, 1
      
    loop myloop2  

    ; printf "b = %d = %d"
    push dword [binary_representation_b]
    push dword [binary_representation_b+4]
    push dword [binary_representation_b+8]
    push dword [binary_representation_b+12]
    push dword [binary_representation_b+16]
    push dword [binary_representation_b+20]
    push dword [binary_representation_b+24]
    push dword [binary_representation_b+28]
    push dword [binary_representation_b+32]
    push dword [binary_representation_b+36]
    push dword [binary_representation_b+40]
    push dword [binary_representation_b+44]
    push dword [binary_representation_b+48]
    push dword [binary_representation_b+52]
    push dword [binary_representation_b+56]
    push dword [binary_representation_b+60]
    push dword [b]
    push dword format_b
    call [printf]
    add esp, 4 * 18
    
    ;-------------------------------------
    mov ecx, 8 
    mov ebx, 0
    mov bx, word[b]
    
    compare:
    
        mov al, byte[a]
        xor al, bl              
        je yes
        shr bx, 1
        
    loop compare
        
    
   ; call printf for NO
    push dword print_no
    call [printf]
    add esp, 4
    jmp final
        
    yes:
        ; capp printf for YES
        push dword print_yes
        call [printf]
        add esp, 4
      

    final:
    push dword 0
    call [exit]
    
    
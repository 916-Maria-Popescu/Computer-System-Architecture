;Problema 18 lab 8
;Sa se citeasca de la tastatura un numar in baza 10 si un numar in baza 16. 
;Sa se afiseze in baza 10 numarul de biti 1 ai sumei celor doua numere citite. Exemplu:
;a = 32 = 0010 0000b
;b = 1Ah = 0001 1010b
;32 + 1Ah = 0011 1010b
;Se va afisa pe ecran valoarea 4.

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
    sum dd 0
    result dd 0
    format_decimal dd "%d", 0
    format_hexadecimal dd "%x", 0
    print_a db "a (decimal)=", 0
    print_b db "b (hexadecimal)=", 0
    format_a db "a = %d(decimal) = %d%d%d%d%d%d%d%d (binary)", 10, 13, 0
    format_b db "b = %d(decimal) = %d%d%d%d%d%d%d%d (binary)", 10, 13, 0
    print_sum db "a + b = %d + %d = %d = %d%d%d%d%d%d%d%d", 10, 13, 0
    print_result db "There are %d bits '1' in the sum", 0
    binary_representation times 8 dd 0 
    

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
    push dword format_hexadecimal
    call [scanf]
    add esp, 4*2
  
    ;---------------------binary for a
    mov esi, binary_representation
    mov ebx, 000000000000000000000000000000001b      ; 00000...00001 (32 digits)
    mov ecx, 32                                      ; prepare ecx for the loop, we have 32 digits in number a, so we'll check everyone of them
    
    myloop:
        mov eax, dword[a]
        and eax, ebx
        cmp eax, 0 
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
    push dword [binary_representation]
    push dword [binary_representation+4]
    push dword [binary_representation+8]
    push dword [binary_representation+12]
    push dword [binary_representation+16]
    push dword [binary_representation+20]
    push dword [binary_representation+24]
    push dword [binary_representation+28]
    push dword [a]
    push dword format_a
    call [printf]
    add esp, 4 * 10
    
    
    
    ;---------------------------------------binary for b
    mov esi, binary_representation
    mov ebx, 000000000000000000000000000000001b      ; 00000...00001 (32 digits)
    mov ecx, 32                                      ; prepare ecx for the loop, we have 32 digits in number a, so we'll check everyone of them
    
    myloop2:
        mov eax, dword[b]
        and eax, ebx
        cmp eax, 0 
        je zero2
        
        ; one
        mov [esi], dword 1
        jmp continue_loop2
        
        zero2:
        mov [esi], dword 0
        
        continue_loop2:
        add esi , 4
        shl ebx, 1
      
    loop myloop2  

    ; printf "b = %d = %d"
    push dword [binary_representation]
    push dword [binary_representation+4]
    push dword [binary_representation+8]
    push dword [binary_representation+12]
    push dword [binary_representation+16]
    push dword [binary_representation+20]
    push dword [binary_representation+24]
    push dword [binary_representation+28]
    push dword [b]
    push dword format_b
    call [printf]
    add esp, 4 * 10
    
    
    ; ------------------------------------------------------------- compute the sum and print the binary representation
    mov eax, dword[a]     ; eax = a
    add eax, dword[b]     ; eax = a+b 
    mov dword [sum], eax ; sum = a+b 

        
    mov esi, binary_representation
    mov ebx, 000000000000000000000000000000001b      ; 00000...00001 (32 digits)
    mov ecx, 32                                      ; prepare ecx for the loop, we have 32 digits in number a, so we'll check everyone of them
 
    myloop3:
        mov eax, dword[sum]
        and eax, ebx
        cmp eax, 0 
        je zero3
        
        ; one
        mov [esi], dword 1
        inc dword[result]
        jmp continue_loop3
        
        zero3:
        mov [esi], dword 0
        
        continue_loop3:
        add esi , 4
        shl ebx, 1
      
    loop myloop3  

    ; " a + b = %d +%d = %d = %d%d%d%d%d%d%d%d"
    push dword [binary_representation]
    push dword [binary_representation+4]
    push dword [binary_representation+8]
    push dword [binary_representation+12]
    push dword [binary_representation+16]
    push dword [binary_representation+20]
    push dword [binary_representation+24]
    push dword [binary_representation+28]
    push dword [sum]
    push dword [b]
    push dword [a]
    push dword print_sum
    call [printf]
    add esp, 4 * 12
    
    ; print the result "There are %d one bits in the sum"
    push dword [result]
    push dword print_result
    call [printf]
    add esp, 4*2
    
    
    push dword 0
    call [exit]
    
  

  

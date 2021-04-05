;A number a (integer in decimal) is given from the keyboard. Print the number in base 10 and then in base 16 (signed representation)
;in urmatorul format: "a = <base_10> (baza 10), a = <base_16> (baza 16)"

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf             
import exit msvcrt.dll    
import printf msvcrt.dll    
import scanf msvcrt.dll     

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    print_decimal dd "Decimal: %d", 0
    print_hexa dd "       Hexadecimal: %x", 0    ; unsigned !!! hexadecimal
    print_minus dd "      Hexadecimal: -%x", 0
    format_decimal dd "%d", 0
    format1 dd "a=", 0
; our code starts here
segment code use32 class=code
    start:
        ;call printf(format, value1, ...)
        push dword format1
        call [printf]
        add esp, 4*1
        
        ;call scanf(format, variable-offset)
        push dword a 
        push dword format_decimal
        call [scanf]
        add esp, 4*2
        
        ;call printf for printing a in decimal
        push dword [a]
        push dword print_decimal
        call [printf]
        add esp, 4*2
        
        mov eax, dword[a]
        cmp eax, 0
        jge positive
        neg eax         ; eax = - eax
        
        ;call printf
        push dword eax
        push dword print_minus
        call [printf]
        add esp, 4*2
        jmp final
        
        positive:
        
        ; call printf for hexadecimal
        push dword eax
        push dword print_hexa
        call [printf]
        add esp, 4*2
        
        final:
        push dword 0
        call [exit]
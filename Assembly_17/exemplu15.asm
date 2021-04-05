;Se citeste de la tastatura un sir de numere in baza 10 fara semn. Sa se determine valoarea maxima din sir si sa se afiseze in fisierul max.txt ;(fisierul va fi creat) valoarea maxima, in baza 16



bits 32
global start
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import exit msvcrt.dll
extern printf,scanf, fclose, fopen, exit

;extern max_value

segment data use32 class=data
    mod_access dd "w", 0
    text_afisare dd "How many numbers do you want to add: ", 0
    text_number dd "Number: ", 0
    format_un_decimal dd "%u", 0
    aux dd 0
    number dd 0
    sir times 10 dd 0
    
  
segment code use32 class=code
start:
    ; printf for "how many numbers do you want to add?"
    push dword text_afisare
    call [printf]
    add esp, 4*1
    
    ; scanf 
    push dword aux 
    push dword format_un_decimal
    call [scanf]
    add esp, 4*2 
    
    mov edi, sir
    add_number:
        cmp dword[aux], 0
        je final

        ;printf
        push dword text_number
        call [printf]
        add esp, 4*1
        
        ;scanf
        push dword number
        push dword format_un_decimal
        call [scanf]
        add esp, 4*2
        
        mov eax, dword[number]
        stosd
        dec dword[aux]
        
        jmp add_number
   
    final:
    push dword 0
    call [exit]
    
    
    




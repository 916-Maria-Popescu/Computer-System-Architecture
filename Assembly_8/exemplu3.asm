;being given a string of bytes containing lowercase letters, build a new string of bytes containing the corresponing uppercase letters

bits 32
global start
extern exit
import exit msvcrt.dll


segment data use32 class = data:
    string1 db ''
    len equ $-string1
    string2 times len db 0
    
segment code use32 class = code:

start:
    mov esi, string1      ; the source string is saved in esi
    mov edi, string2      ; the destination string is saved in edi
    
    mov ecx, len          ; in ecx is stored the lenght of the string 
                          ; we prepare ecx for the loop
    jecxz final       
    lower_to_upper:
    
        mov al, [esi]
        sub al, 'a'- 'A'
        mov [edi], al 
        
        inc esi
        inc edi 
        
    loop lower_to_upper

    final:
    push dword 0
    call [exit]
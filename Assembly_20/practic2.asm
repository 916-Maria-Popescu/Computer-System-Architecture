; Se citeste un mesaj de la tastatura codat prin rotirea literelor o data la stanga, iar apoi prin tranformarea fiecarei lit in codul ascii
; sa se afiseze 

bits 32 
global start
extern exit, fprintf, fopen, scanf, fclose, fread, printf

import exit msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fwrite msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class = data 

    file_name db 'text2.txt', 0
    write_mod db 'w', 0
    handler dd -1
    format db "%s", 0
    s resb 100
    d resb 100
    message dd 'word = ', 0
    

segment code use32 class = code
start:
 
    ; fopen(file_name, mod)
    push dword write_mod
    push dword file_name
    call [fopen]
    add esp, 4 * 2
    
    mov dword [handler], eax
    cmp eax, 0 
    je final
    
    ;call printf (message, value)
    push dword message
    call [printf]
    add esp, 4
    
    ;call scanf(format, variablia)
    push dword s
    push dword format
    call [scanf]
    add esp, 4 * 2
    
    
    mov esi, s
    mov edi, d
    myloop:
        lodsb
        cmp al, 0
        je stop
        
        mov cl, 1
        ror al, cl 
        stosb
    jmp myloop
    stop:
    
    
    ; call fprinf (desc, mod , value)
    push dword d
    push dword format
    push dword [handler]
    call [fprintf]
    add esp, 4 *3
        
    
    close:
    ; call fclose for the file 
    ; fclose(handler)
    push dword [handler]
    call [fclose]
    add esp, 4


    final:
    push dword 0
    call [exit]


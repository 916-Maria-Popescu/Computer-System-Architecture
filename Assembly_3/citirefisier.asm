
bits 32
global start

extern exit, fopen, fclose, fread, printf , scanf
import printf msvcrt.dll
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import scanf msvcrt.dll

segment data use32 class = data
    file_name db 'text.txt', 0
    read_mode db 'r', 0 
    wrtie_mode db 'w', 0
    handler dd -1 
    len equ 100
    mytext times len db 0 
    format db "%c" , 0
    result dw 0
    n dd 0
    
segment code use32 class = code
 start:
    ; call fopen (file_name, mod)
    push dword wrtie_mode
    push dword file_name
    call [fopen]
    add esp, 4 * 2
    
    mov [handler], eax ; the descriptor is returned form fopen in eax is now saved in handler
    cmp eax, 0
    je final
    
    mov ecx, 5
    loop:
        ; call scanf (format, variabila)
        push dword n
        push dword format
        call [scanf]
        add esp, 4 * 2
        
        ; call fprintf(desc, mod, value)
        push n
        push format
        push handler
        add esp, 4 * 2
        
        
    

    final :
    push dword 0
    call [exit]
    
    
    
    
    
    
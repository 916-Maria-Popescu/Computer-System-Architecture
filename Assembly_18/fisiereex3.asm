; se citeste din fisierul, se adauga 1 la fiecare octet citit si apoi se scriu octetii rezultati intr-un fisier nou si apoi se redenumeste
;acest nou fisier cu numele fisierului vechi

bits 32
global start

extern exit, fopen, fclose, fread, printf, rename, remove, fwrite, perror

import exit msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import rename msvcrt.dll
import remove msvcrt.dll
import fwrite msvcrt.dll
import fopen msvcrt.dll
import perror msvcrt.dll

segment data use32 class = data

    file_name1 db 'text1.txt', 0
    file_name2 db 'text2.txt', 0
    read_mod db 'r', 0
    write_mod db 'w', 0
    c db 0
    handler1 dd -1
    handler2 dd -1
   
segment code use32 class = code

start:
        
    ;call fopen(file_name, mod)
    push dword read_mod
    push dword file_name1
    call [fopen]
    add esp, 4 * 2
    
    mov dword [handler1], eax 
    cmp eax, 0
    je final
    
    ; call fopen for file 2 with write_mod
    push dword write_mod
    push dword file_name2
    call [fopen]
    add esp, 4 * 2
    
    mov dword [handler2], eax 
    cmp eax, 0
    je final
    
    
    loop:
        ; call fread for file 1
        ; fread(string to load data in, 1, n, handler)
        push dword [handler1]
        push dword 1
        push dword 1
        push c 
        call [fread]
        add esp, 4 * 4
        
        cmp eax, 0 
        je close
        
        add byte [c] , 1
        
        ; call fprintf(handler, mod, value)
        ;push dword[c]
        ;push dword "%d"
        ;push dword [handler2]
        ;call [fprintf]
        
        ; call fwrite(string de unde se citeste, 1, n, handler)
        push dword [handler2]
        push dword 1
        push dword 1
        push dword c 
        call [fwrite]
        add esp, 4 * 4 
        
        cmp eax, 0 
        je close 
        
    jmp loop 
    
    close:
        ; call fclose(handler)
        
        push dword [handler1]
        call [fclose]
        add esp, 4 
        
        push dword [handler2]
        call [fclose]
        add esp, 4 
        
        ; call fprint(format, value)
        push dword "aici"
        call [printf]
        add esp, 4
        
    
    final: 
    push dword 0
    call [exit]
    

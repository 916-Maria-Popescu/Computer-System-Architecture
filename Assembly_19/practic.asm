; Se da un fisier cu propozitii, propozitiile se termina in "\". Sa se scrie in celalat fisier doar propozitiile impare

bits 32
global start

extern exit, fopen, fclose, fread, printf, rename, remove, fwrite, perror, fprintf

import exit msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import rename msvcrt.dll
import remove msvcrt.dll
import fwrite msvcrt.dll
import fopen msvcrt.dll
import perror msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class = data

    file_name1 db 'text1.txt', 0
    file_name2 db 'text2.txt', 0
    read_mod db 'r', 0
    write_mod db 'w', 0
    sentence times 100 db 0 
    format db " My even sentence is : %s", 0
    c times 1 db 0
    handler1 dd -1
    handler2 dd -1
    counter db 1
    two db 2
   
segment code use32 class = code

start:
    ; call fopen (file_name, mod) for the file with the sentences
    push dword read_mod
    push dword file_name1
    call [fopen]
    add esp, 4 *2
    
    mov dword [handler1], eax 
    cmp eax, 0 
    je final 
    
    ; call fopen for the dest file
    push write_mod
    push file_name2
    call [fopen]
    add esp, 4 * 2
    
    mov dword [handler2], eax
    cmp eax, 0
    je final 
  
    mov edi, sentence
    
    mainloop:
        myloop:
        ; call fread for first file, fread (the adress od the dest string, 1, n times, handler
            push dword [handler1]
            push dword 1
            push dword 1
            push c
            call [fread]
            add esp, 4 * 4 
        
            cmp eax, 0 ; verfies if eax read something
            je close 
        
            mov al , byte [c]
            cmp al, '/'
            je end_sentence
            
            STOSB
        
        jmp myloop  
        
        end_sentence:
        inc byte [counter]
        mov al, byte [counter]
        div byte [two]   ; AL ← AX / 2, AH ← AX % 2 ( 1 or 0 )
        cmp ah, 0
        je even_sentence
        
        ;call fprintf(handler, mod, value)
        
        push dword sentence
        push dword format
        push dword [handler2]
        call [fprintf]
        add esp, 4 * 3
       
        cmp eax, 0
        je close
        
        even_sentence:
    jmp mainloop
     
    close:
        ; call fclose for both files
        
        push dword [handler1]
        call [fclose]
        add esp, 4
        
        push dword[handler2]
        call [fclose]
        add esp, 4

    final :
    push dword 0
    call [exit]
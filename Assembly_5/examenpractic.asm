;Fie un fisier -numele dat in segmentaul de date- ce contine mai multe note separate prin spatiu (notele sunt de la 1 la 10). Sa se citeasca ;aceste note si sa se calculeze suma celor mai mici decat 8 iar rezultatul se scrie la finalul fisierului./

bits 32 

global start        

extern exit, fopen, fread, fclose, fprintf, printf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fread msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    nume_fisier db "examenptext.txt", 0  
    mod_acces db "a+", 0                        
    handler dd -1         
    len equ 100                                             
    text times len db 0  
    format dd "    Suma: %d", 0
    result dd 0


segment code use32 class=code
    start:
        ; fopen 
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2                

        mov [handler], eax   
        
       
        cmp eax, 0
        je final
        
        ;fread 
        push dword [handler]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4                 
        
        ; fclose(descriptor)
        push dword [handler]
        call [fclose]
        add esp, 4
        
        ; acum avem in 'text' toate notele si spatiile libere
        mov esi, text 
        mov ebx, 0
        cld
        
        myloop:
            
            mov eax, 0
            lodsb ; al = primul caracter salvat in text
            
            cmp al, 0
            je stop
            
            cmp al, ' '
            je space
            
            cmp al, '8'
            jae space
            
            sub al, 30h
            add ebx, eax
            
            space:
            
        jmp myloop
        ; the sum is stored in ebx 
        
        stop:
        
        add dword [result], ebx 
        ;call fprintf in order to print the sum in the file
        ; fprintf(desc, mod, value)
        push dword result 
        push dword format
        push dword [handler]
        call [fprintf]
        add esp, 4 * 3
        
        cmp eax, 0
        je close
        
        
        close: 
        
        ; fclose (descriptor)
        push dword [handler]
        call [fclose]
        
      final:
        ; exit(0)
        push    dword 0      
        call    [exit]     
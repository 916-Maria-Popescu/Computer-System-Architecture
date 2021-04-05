bits 32

global start        

extern exit, printf, scanf, fopen, fclose, fprintf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

; 617269614D

segment data use32 class=data
        len db 0
        array times 100 db 0

        number dd 0
        read_format db "%c", 0
        print_format db "%c", 0
        
        no_of_digits db 0
        
        file_descriptor dd -1
        file_name db "text2.txt", 0
        access_mode db "a", 0
segment code use32 class=code
    start:
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4 * 2
        
        cmp eax, 0
        je final
        
        mov [file_descriptor], eax
        
        mov edi, array
        read_nos:
            mov dword [number], 0
        
            push number
            push read_format
            call [scanf]
            add esp, 4 * 2
            
            cmp byte [number], '0'
            jb end_loop
            cmp byte [number], '9'
            jbe is_digit
            cmp byte [number], 'A'
            jb end_loop
            cmp byte [number], 'Z'
            jbe is_letter
            jmp end_loop
            
            is_digit:
                sub byte [number], '0'
                jmp continue
            is_letter:
                sub byte [number], 'A'
                add byte [number], 10   
            continue:
            
            inc byte [no_of_digits]
            cmp byte [no_of_digits], 2
            jne skip_processing
            
            mov al, 16
            mul bl
            add al, byte [number]
            stosb
            inc byte [len]
            
            mov byte [no_of_digits], 0
            
            skip_processing:
            
            mov bl, [number] ; this is the last number, here it will be saved
        jmp read_nos
            
        end_loop:
        
        dec byte [len]
        
        mov eax, 0
        mov al, byte [len]
        
        pushad
        mov ebx, 0
        mov bl, byte [array + eax]
        push ebx
        push print_format
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4 * 3
        popad
        
        mov byte [array + eax], 0
        
        mov esi, array
        loop_code:
            mov eax, 0
            lodsb
            
            cmp al, 0
            je exit_loop
            
            pushad
            push eax
            push print_format
            push dword [file_descriptor]
            call [fprintf]
            add esp, 4 * 3
            popad
        jne loop_code
        
        exit_loop:
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4 * 1
        
        final:
        
        push    dword 0
        call    [exit]

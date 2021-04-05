;Se da un sir de numere. Sa se afiseze valorile in baza 16 si in baza 2.
bits 32
global start
import printf msvcrt.dll
import exit msvcrt.dll
extern printf, exit
extern binary_base

segment  data use32 class=data ; the data segment where the variables are declared 

     s db 5,25,55,122,34
     len equ $-s
     ;dhex times len db 0
     ;dbin times len db 0
     format_hex db '%x, ', 0
     format_bin db '%s, ', 0
     format_initial_bin db '        Binary: ', 0
     format_initial_hexa db 'Hexadecimal: ', 0
    
segment  code use32 class=code ; code segment
    start:
     
        push dword format_initial_hexa
        call [printf]
        add esp, 4 
    ;---------------------------------------------------------------------------------Hexadecimal

        mov esi, s   
        mov ecx, len ; we store the value of the lenght of the string in ecx

        cld          ; clear direction flag, so DF = 0
    
        ; the loop for the hexadecimal string
        .hexadecimal_loop:
    
            mov eax, 0                  ; clear eax
            lodsb                       ; The byte from the address <DS:ESI> is loaded in AL
            mov ebx, ecx                ; save ecx
        
            push eax
            push dword format_hex
            call [printf]
            add esp, 4 * 2
            
            mov ecx, ebx 
        loop .hexadecimal_loop    
        
    ;-----------------------------------------------------------------------------------Binary
        push dword format_initial_bin
        call [printf]
        add esp, 4 
        
        mov ecx, len ; we store the value of the lenght of the string in ecx
        mov esi, s   
        cld          ; clear direction flag, so DF = 0
        
        ; the loop for the binary string
        .binary_loop:
        
            mov eax,0
            lodsb                   ; load in al the byte stored at the offset indicated by esi
            
            push eax                ; push the parameter on the stack for the function
            call binary_base        ; call the function that returns the number into its binary form
                                    ; the function saves the result in eax
            
            mov ebx, ecx
            
            push eax
            push dword format_bin
            call [printf]
            add esp, 4 * 2          
           
            mov ecx, ebx            ;move back the initial value of ecx 
        
        loop .binary_loop       ; loop until ecx = 0

        
        ; exit(0)
        push    dword 0      
        call    [exit]       
        
        
        
        
        
        
    
bits 32 

global start        

extern exit,printf       
extern base_2   

import exit msvcrt.dll      
import printf msvcrt.dll 


segment data use32 class=data

    
    s db 101 , 111 , 121 , 131 , 141 , 151
    lens equ $-s
    format1 db '%x, ',0
    format2 db '%s, ',0
    
    
segment code use32 class=code
    start:
        ; A string of numbers is given. Show the values in base 16 and base 2.
        
        mov esi, s                  ; esi is the pointer to the start of the string
        mov ecx, lens               ; ecx take the leght of my string
        cld                         ; clear direction flag, DF = 0
        
        print_in_base_16:           ; the loop that prints the bumbers in base 16
        
            mov eax,0 
            lodsb                   ; load in al the byte stored at the offset indicated by esi
            
            mov ebx,ecx             ; save the counter ecx in ebx as ecx will be modified by the function printf
                                    
            ; call printf() to print in the console
            ; printf(the_printing_format, the_value_that_needs_to_be_printed)
            push eax
            push dword format1
            call [printf]
            add esp, 4 * 2          ; clean-up the stack
            
            mov ecx,ebx             ; restore the saved value of ecx
        
        loop print_in_base_16       ; loop until ecx = 0
        
        
        ;----------------------------------------------------------------------------------------------------------------------------------
        
        mov ecx, lens               ; ecx take the leght of my string        
        mov esi, s                  ; esi is the pointer to the start of the string
        cld                         ; clear direction flag, DF = 0
        
        print_in_base_2:            ; the loop that prints the bumbers in base 2
        
            mov eax,0
            lodsb                   ; load in al the byte stored at the offset indicated by esi
            
            push eax                ; push "parameter" of the function
            call base_2             ; call the function that calculates the number in base 2
            
                                    ; when coming back the value obtained in the fucntion is stored in eax
            
            mov ebx, ecx            ; save the counter ecx in ebx as ecx will be modified by the function printf
            
            ; call printf() to print in the console
            ; printf(the_printing_format, the_value_that_needs_to_be_printed)
            push eax
            push dword format2
            call [printf]
            add esp, 4 * 2          ; clean-up the stack
            
            mov ecx, ebx            ; restore the saved value of ecx
        
        loop print_in_base_2        ; loop until ecx = 0

        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

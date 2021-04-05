;being given a string of bytes containing uppercase letters, build a new string of bytes containing the corresponing lowercase letters

bits 32
global start
extern exit
import exit msvcrt.dll


segment data use32 class = data:
    string1 db 'ABCDEF'
    len equ $-string1
    string2 times len db 0
    
segment code use32 class = code:

start:
    mov esi, 0
    
    upper_to_lower:
        mov al, [string1 + esi]   ;the byte from the offset [string1 + esi] is stored in ax
                                  ; esi will be 1, 2, 3,....., len
        add al, 'a' - 'A'
        mov [string2+esi], al     ; al is stored in the offset [string2 + 1]
        
        inc esi                   ; esi = esi + 1
        cmp esi, len 
        jb upper_to_lower       ; will jump to the label if esi is bellow the lenght of the string 
        
        
    push dword 0
    call [exit]
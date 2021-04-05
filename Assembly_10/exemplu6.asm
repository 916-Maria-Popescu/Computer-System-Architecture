;being given a string of bytes containing lowercase letters, build a new string of bytes containing the corresponing uppercase letters

bits 32 
global start 
extern exit
import exit msvcrt.dll

segment data use32 class = data:
    source_string db 'a','b','c','d','e','f','g'
    lens equ $-source_string
    destination_string times lens db 0
    
segment code use32 class = code:
start:
    mov esi, source_string          ; we move the offset of the source_string in esi
    mov edi, destination_string     ; we move the offset of the destination_string in edi 
    mov ecx, lens                   ; prepare ecx for the loop
    jecxz final                     ;we check if ecx is zero
    cld                             ; clear the direction flag, now df = 0
                                    ; if DF=0, the string'll bw rewad from left to right, if DF=1, the string'll be read from right to left
    myloop:
        lodsb                       ; the first byte from the source_string(esi) is loaded in AL
                                    ; mov al, [esi], inc esi
        sub al, 'a' - 'A'           ; we transform the letter from lowercase into uppercase using the ASCII code
        stosb                       ; AL is save in the destination_string (edi)
                                    ; mov [edi], al,  inc edi 
        
    loop myloop
    
    final:
    push dword 0
    call [exit]
























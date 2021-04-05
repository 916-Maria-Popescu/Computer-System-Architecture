;being given a string of bytes, build a new string of bytes, with the same bytes from the forst string, but in a reverse order
; ex: string1 = 12h, 20h, 1234h, 444h
;     string2 = 444h, 1234h, 20h, 12h

bits 32 
global start 
extern exit
import exit msvcrt.dll

segment data use32 class = data:
    source_string db 12h, 77h, 12h, 88h, 0h
    lens equ $-source_string
    destination_string times lens db 0
    
segment code use32 class = code:
start:
    mov esi, source_string          ; we move the offset of the source_string in esi
    mov edi, destination_string     ; we move the offset of the destination_string in edi 
    add edi, lens-1                 ; we need to travers the string from right to left, so the offset of edi needs to be at the last elem
    mov ecx, lens                   ; prepare ecx for the loop
    jecxz final                     ;we check if ecx is zero
    
    myloop:
        cld                         ; DF (direction flag) = 0, so the string'll bw traversed from left to right
        lodsb                       ; the first byte from the source_string(esi) is loaded in AL
                                    ; mov al, [esi], inc esi
                                    
        std                         ; DF (direction flag) = 1, so the string'll bw traversed from right to left
        stosb                       ; AL is save in the destination_string (edi)
                                    ; mov [edi], al,  inc edi
     
    loop myloop
    final:
    push dword 0
    call [exit]

; Se citeste un numar n de la tastatura n 


bits 32
global start
extern exit, printf, scanf 

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class = data
    n dd 0
    message dd "n = ", 0
    format dd "%d", 0
    format2 dd " n este %d", 0
    
segment code use32 class = code 

start :
    ; call printf (format, value)
    push message
    call [printf]
    add esp, 4 * 1
    
    ; call scanf (format, variable)
    push n
    push format
    call [scanf]
    add esp, 4 * 2
    
    mov eax, [n]
    
    push eax
    push format2
    call [printf]
    add esp, 4 * 2
    
    push dword 0
    call [exit]
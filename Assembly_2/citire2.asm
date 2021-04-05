; Citeste a si apoi b si afiseaza a + b = rezultatul

bits 32 
global start

extern printf, scanf, exit
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class = data
    message1 dd "a = ", 0
    message2 dd "b = ", 0
    message3 dd "a+b= %d", 0
    a dd 0
    b dd 0
    format dd "%d"
    rez dd 0


segment code use32 class = code

start:
        
    ; call printf (format, value)
    push message1
    call [printf]
    add esp, 4 * 1
    
    ; call scanf(format, variable) pt citirea lui a
    
    push a 
    push format
    call [scanf]
    add esp, 4 * 2
    
    ; call printf
    push message2
    call [printf]
    add esp, 4 * 1
    
   
    ; call scanf pt citirea lui b
    push b
    push format
    call [scanf]
    add esp, 4 * 2
    
    mov eax, [a]
    add eax, [b]
    ; eax este egal cu a + b
    
    push eax
    push message3
    call [printf]
    add esp, 4 * 2
    
    push dword 0
    call [exit]
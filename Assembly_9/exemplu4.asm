;compute the value of the expression x = ((a+b) * c)/ d where all numbers are unsigned numbers and a,b,c,d are all bytes
bits 32
global start 

extern exit
import exit msvcrt.dll


segment data use32 class = data
    a db 10
    b db 12
    c db 3
    d db 9
    x dw 0

segment code use32 class = code
start:
    
    mov al, [a]
    add al, [b]         ; al = a + b 
    mul byte [c]        ; ax = al * c = (a+b)*c 
    div byte [d]        ; al = ax/d (quotient) and ah = ax%d (remainder)
    mov ah, 0           ; convert byte al into word ah (unsigned)
    mov [x], ax 
    
    push dword 0
    call [exit]
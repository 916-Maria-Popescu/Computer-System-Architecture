; x = a * b + c * d
; Write a program that computes the expresion x = a * b + c * d where all numbers are unsigned and represented on a word
bits 32 

global start        

extern exit
import exit msvcrt.dll  

segment data use32 class=data
    a dw 3
    b dw 6 
    c dw 1
    d dw 8
    x dd 0
    
segment code use32 class=code
    start:
    mov ax, [a]
    mul word [b]     ; dx:ax = a*b, in dx is stored the high part, and in ax is stored the low part
    mov word[x], ax  
    mov [x+2], dx    
    
    mov ax, [c]
    mul word [d]  ; dx:ax = c*d, in dx is stored the high part, and in ax is stored the low part
    add [x], ax
    adc [x+2], dx
        
    push    dword 0      
    call    [exit]    
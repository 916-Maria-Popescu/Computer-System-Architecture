;compute the value of the expression x = ((a-b)*c)/(d-a) ehre all numbers are unsigned numbers and a,b,c,d are words
; for the given values this should be x = ((10+12)*2)/(d-a) = 44/(-1) = -44 (in decimal) = -2C
bits 32
global start 
extern exit
import exit msvcrt.dll

segment data use32 class = data
    a dw 10
    b dw -12
    c dw 2
    d dw 14
    x dd 0

segment code use32 class = code
start:
    mov ax, [a]
    sub ax, [b]
    imul dword [c]      ; dx:ax = ax * c (in dx is saved the high part, and in ax is saved in the low part)
                        ; we use imul because we taka the numbers in the signed version
                        
    mov bx, [d]
    sub bx, [a]         ; bx = d-a
    
    
    mov dx, 0           ; to avoid integer overflow error we must clear de dx first 
    idiv bx             ; ax = dx:ax/bx (quotient) and dx = dx:ax%bx (remainder)
    mov ax, bx 
    cwd                 ; convert word to doubleword for signed version
    mov [x], eax
    
    push dword 0
    call [exit]
    
 
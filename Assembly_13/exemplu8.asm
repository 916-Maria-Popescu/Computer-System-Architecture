; Beign given two strings of words, build a new string by the concatination of the higher byte from the fisrt string and the lower byte from
; the second string, in ascending order (in the signed representation)
; ex: string1: 1224h, 9800h, 23h, 1h
;     string2: 4375h, 1100h, 26h
;     the string after the concatination: 12h, 98h, 00h, 00h, 75h, 00h, 26h 
;     the strinf sorted: 
      
      
bits 32 
global start 
extern exit
import exit msvcrt.dll

segment data use32 class = data:
    string1 dw 1224h, 9800h, 23h, 1h
    len1 equ ($-string1)/2
    string2 dw 4375h, 1100h, 26h
    len2 equ ($-string2)/2
    string3 times len1+len2 db 0
    
segment code use32 class = code:
start:

    mov edi, string3

    ; first we store all the higher bytes from the first string in string3
    mov esi, string1
    mov ecx, len1
    cld 
    loop1:
    
        lodsw               ; AX = [esi], esi + 2
                            ; AH = higher byte (which we need)    AL = lower byte
        mov al, ah
        mov ah, 0           ; clear ah, now ax = al = the higher byte
        
        stosb               ; [edi] = al, edi + 1
 
    loop loop1
    
    ; now we store all the lower bytes from the second string in string 3
    mov esi, string2
    mov ecx, len2
    cld
    loop2:       
    
        lodsw                           ; AX = [esi], esi + 2
                                        ; AH = higher byte   AL = lower byte(which we need)
        stosb                           ; [edi] = al, edi + 1

    loop loop2
    
    ; now we need to sort the string
    
    mov dx, 1
    check_order:
    
        cmp dx, 0                       ;dx = 0 means that in there was no change in the string, so the string is sorted
        je final
        mov dx, 0
        mov esi, string3
        mov ecx, len1 + len2
        cld 
        
        loop_sort:
        
            lodsb                       ; al = [esi], inc esi 
            mov bl, byte[esi]           ; bl = [esi+1]
            cmp al, bl
            jle already_sorted          ; if esi <= esi +1 jump to already_sorted
            mov [esi], al
            mov [esi-1], bl 
            mov dx, 1
            
         already_sorted:
        loop loop_sort
        
        jmp check_order
        
    
    final:
    push dword 0
    call [exit]
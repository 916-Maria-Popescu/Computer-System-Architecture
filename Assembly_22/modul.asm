bits 32     
  
global base_2  

segment data use32 class=data
    
    
    a db 2
    b db 10
    r resb 8
           

segment code use32 public code
    base_2:
        
        ; this function repeatedly dived the given value with 0 until the quotient is 0 and we save the remainders as we obtain them as their string representation
        ; little endian does it's job
        
        mov eax, [esp+4]                ; take from the stack the "parameter" of the function located on the second line of the stack
        mov ebx, 7                      ; use the register ebs as a counter, it is set to 7 so we can proceed through the string rep in base 2 of the number from right to left
        
        create_nr_in_base_2:            ; the loop that creates the numbers in base 2
            
            cmp al, 0                   ; compare the right most part of eax, al with 0
            je final                    ; we stop the toop when al is 0
            
            div byte [a]                ; then we divide it with 2
            
            add ah, 30h                 ; add 30h to the remainder to transform it into its string representation
            mov [r + ebx], ah           ; add to the string the new char
            sub ebx, 1                  ; decrease ebx so we can move to the left             
            mov ah, 0                   ; make sure ah is 0, we need only the quotient for the next parts
            
        jmp create_nr_in_base_2
        
        final:
        
        mov ebx, 0                      ; make sure ebx is empty
        
        clean:                          ; we have to trasform into their string representation also the left most 0's in the binary representation of our numbers, if they exist
            
            cmp byte [r + ebx], 0       ; compare the byte of our string from the left most position in the memory with 0
            jne final2                  ; if not equal we are done
            
            add byte [r + ebx], 30h     ; else transform it into its string representation
            add ebx, 1                  ; increase ebx to go through all the zeros
            jmp clean
            
        
        final2:
        mov eax, r                      ; let eax, the "parameter" of this function hold the pointer to the start of the newly created string
        
        ret 4                           ; return to the main program and clean 4 bytes from the stack

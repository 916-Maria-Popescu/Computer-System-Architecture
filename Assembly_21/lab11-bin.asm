bits 32 
global  binary_base
segment  data use32 class=data ; the data segment where the variables are declared 

    two dd 2
    result resb 8
    
segment  code use32 public code ; code segment
    binary_base:
        mov eax, [esp + 4]                    ; eax takes the parameter from the function
        mov ebx, 7

        convert_to_base_2:
            cmp al, 0
            je finish
        
            div byte [two]                     ; AL ← AX / 2, AH ← AX % 2 ( 1 or 0 )
            add ah, 30h                         ; transform the remainder into its string representation
                                               ; 1 into '1' and 0 into '0'
            mov [result + ebx], ah             ; add the new char ('0' or '1') to the string
            sub ebx, 1
            mov ah, 0                          ; clear ah (we don't need the remainder anymore)
            
        jmp convert_to_base_2
        
        finish:
        
        ; we stil need to transform the leftmost 0 into '0' (because when the binary form of the number contains only zeros, it's equal to zero and the loop stops 
        mov ebx, 0
        zero:
            cmp byte [result + ebx], 0               
            jne final
            
            add byte [result + ebx], 30h            ; transform from 0 into '0'
            add ebx, 1
            jmp zero
            
        final:
        mov eax, result                      ; let eax, the "parameter" of this function hold the pointer to the start of the newly ;created string
        
        ret 4                           ; return to the main program and clean 4 bytes from the stack
         

bits 32                         
segment code use32 public code
global max_value

max_value:
    ; in esp + 4 we have the offset of 'sir'
    mov esi, [esp+4]
    

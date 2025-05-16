%define SYS_READ  0x03 ; ebx:fd ecx:pbuf edx:count
%define SYS_WRITE 0x04 ; ebx:fd ecx:pbuf edx:count
%define SYS_EXIT  0x01 
%define STD_IN    0x0
%define STD_OUT   0x1

%define SYSCALL int 80h

section .data
inputBuf:  db  0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A

section .bss
outputBuf: resb 80

section .text
global _start

_start:
    mov esi, inputBuf
    mov edi, outputBuf

    mov ecx, 8

process_bytes:
    cmp ecx, 0
    je done_processing 

    mov al, [esi]     
    mov bl, al
    shr bl, 4
    call nibble_to_ascii 
    mov [edi], al
    inc edi

    mov bl, al
    mov bl, [esi]
    and bl, 0x0F
    mov al, bl
    call nibble_to_ascii
    mov [edi], al
    inc edi

    dec ecx
    cmp ecx, 0
    je space

    mov byte [edi], ' '
    inc edi

space:
    inc esi
    jmp process_bytes

done_processing:
    mov byte [edi], 0x0A
    inc edi

    mov edx, edi
    sub edx, outputBuf

    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, outputBuf
    mov edx, edx
    SYSCALL

    mov eax, SYS_EXIT
    mov ebx, 0
    SYSCALL

nibble_to_ascii:
    cmp bl, 9
    jle is_digit

    add bl, 55       
    mov al, bl
    ret

is_digit:
    add bl, '0'   
    mov al, bl
    ret

[ORG 0x7c00]      ; add to offsets
  jmp start

  %include "print.inc"

start:
  xor ax, ax
  mov ss, ax
  mov sp, 0x9c00

  mov ax, 0xb800
  mov es, ax

  mov si, welcome_msg
  call printf

  cli
  mov bx, 0x09
  shl bx, 2
  xor ax, ax
  mov gs, ax
  mov [gs:bx], word key_int
  mov [gs:bx+2], ds 
  sti

  jmp $ 

key_int:
  in al, 0x60
  mov bl, al
  mov byte [port60], al

  in al, 0x61
  mov ah, al
  or al, 0x80 
  out 0x61, al
  xchg ah, al
  out 0x61, al

  mov al, 0x20
  out 0x20, al
  
  and bl, 0x80
  jnz done

  mov ax, [port60]
  mov word [reg16], ax
  call printreg16

done: 
  iret

port60 dw 0 
welcome_msg dw "Welcome to LeafOS Bootloader v0.1!", 0

  times 510-($-$$) db 0 
  dw 0xAA55

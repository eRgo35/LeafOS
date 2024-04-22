bits 16
org 0x7C00 ; after 0xAA55 is detected, CPU jumps to 0x7C00
boot:
  mov si, msg
  call print
  mov si, copy
  call print
  mov si, copy2
  call print

halt:
  cli
  hlt

print:
  mov ah, 0x0E
  lodsb 
  or al, al 
  jz end 
  int 0x10
  jmp print
end:
  mov al, 10
  int 0x10
  mov al, 13
  int 0x10
  ret

msg: db "Welcome to Leaf Bootloader v1.0", 0
copy: db "Copyright(c) 2024 Michael Czyz", 0 
copy2: db "All rights reserved.", 0

times 510 - ($-$$) db 0 ; pad remaining bytes with zeroes
dw 0xAA55 ; magic jump sequence

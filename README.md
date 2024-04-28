# LeafOS Kernel

To develop and build the source code, you can use

```sh 
nix develop
```
to get all required dependencies up and running

To build bootloader:
```sh 
cd boot
```

```sh 
nasm -f bin boot.asm -o boot.bin
```

To test using qemu:
```sh 
qemu-system-x86_64 -fda boot.bin 
```

To burn onto your usb device:
```sh 
dd if=boot.bin of=/dev/{device} bs=1M
```

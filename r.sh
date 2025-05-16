 nasm -g -f elf ascii_print.asm &&
 ld -m elf_i386 ascii_print.o -o ascii_print  &&
 ./ascii_print 5A 6C 0A 1B 2C 3D 4E 5F
 read -p "..."

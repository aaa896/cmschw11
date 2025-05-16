 nasm -g -f elf ascii_print.asm &&
 ld -m elf_i386 ascii_print.o -o ascii_print  &&
 ./ascii_print
 read -p "..."

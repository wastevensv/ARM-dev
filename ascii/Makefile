TARGET=main

all: $(TARGET).bin

%.o: %.s
	arm-none-eabi-as -mcpu=arm926ej-s -g $< -o $@
%.o: %.c
	arm-none-eabi-gcc -c -mcpu=arm926ej-s -g $< -c -o $@
%.elf: %.o startup.o
	arm-none-eabi-ld -T startup.ld $< startup.o -o $@
%.bin: %.elf
	arm-none-eabi-objcopy -O binary $< $@
.PRECIOUS: %.elf

clean-all:
	rm -vf *.o
	rm -vf *.elf
	rm -vf *.bin

run: $(TARGET).bin
	qemu-system-arm -M versatilepb -m 128M -nographic -kernel $< -s

debug: $(TARGET).bin
	qemu-system-arm -M versatilepb -m 128M -nographic -kernel $< -s -S

PROGRAM=main
TARGET=msp432
ARM_FLAGS=-mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb
INCLUDES=-I $(TARGET) -I $(TARGET)/CMSIS

all: $(PROGRAM).bin

%.o: %.s
	arm-none-eabi-as $(ARM_FLAGS) -g $< -o $@
%.o: %.c
	arm-none-eabi-gcc $(INCLUDES) -c $(ARM_FLAGS) -g $< -c -o $@
$(PROGRAM).elf: $(PROGRAM).o startup_gcc.o msp432/system_msp432p401r.o
	arm-none-eabi-ld -T $(TARGET).ld $^ -o $@
$(PROGRAM).bin: $(PROGRAM).elf
	arm-none-eabi-objcopy -O binary $< $@
.PRECIOUS: %.elf

clean-all:
	rm -vf *.o
	rm -vf *.elf
	rm -vf *.bin

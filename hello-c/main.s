	.cpu arm7tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.arm
	.syntax divided
	.file	"main.c"
	.text
	.align	2
	.global	print_uart0
	.type	print_uart0, %function
print_uart0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrb	r3, [r0]	@ zero_extendqisi2
	cmp	r3, #0
	bxeq	lr
	ldr	r2, .L7
.L3:
	str	r3, [r2]
	ldrb	r3, [r0, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L3
	bx	lr
.L8:
	.align	2
.L7:
	.word	270471168
	.size	print_uart0, .-print_uart0
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #72
	ldr	r2, .L12
	ldr	r1, .L12+4
.L10:
	str	r3, [r1]
	ldrb	r3, [r2, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L10
	bx	lr
.L13:
	.align	2
.L12:
	.word	.LC0
	.word	270471168
	.size	main, .-main
	.global	UART0DR
	.section	.rodata
	.align	2
	.type	UART0DR, %object
	.size	UART0DR, 4
UART0DR:
	.word	270471168
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Hello world!\012\000"
	.ident	"GCC: (Fedora 5.2.0-4.fc24) 5.2.0"

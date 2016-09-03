# ARM Assembly Language Development Environment
This is a development environment that I use for learning GNU Assembler syntax for ARM CPUs (and some C as well). I'm doing this in addition to my coursework in RIT's CMPE250 Assembly Language course.

## Folders
* hello - (only in C) Prints Hello World over the UART.
* case - (also in C) Takes in a character over UART, outputs character of opposite case over UART.
* echo - (also in C) Takes in a character over UART, outputs character over UART.
* ascii - Outputs printable ASCII characters over UART. Demonstrates loops and subroutines in ARM Assembly.

## Dependencies
* qemu
* arm-none-eabi-{gcc,as,newlib}

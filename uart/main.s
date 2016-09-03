.equ    UART_DR_OFFSET, 0x00      @ UART Data Register Offset
.equ    UART_FR_OFFSET, 0x18      @ UART Flag Register Offset
.equ    UART_RXFE_MASK, 0x10      @ UART Flag Register RX Empty Mask
.equ    UART_TXFF_MASK, 0x20      @ UART Flag Register TX Full Mask
.equ    OUT_CHAR,       0x20

.text
@ --- Main Program Code
.global main
main:
        MOV   R4, #90
        MOV   R0, #OUT_CHAR           @ Load R0 with value to send.
ploop:  ADD   R0, R0, #1
        BL    putc
        SUBS  R4, R4, #1
        BNE   ploop
        B     .

putc:   PUSH  {R1, R2, R3}
        LDR   R1, =UART0_ADDR         @ Load R1 with UART0_ADDR.
        LDR   R1, [R1]
        MOV   R3, #UART_TXFF_MASK
wait:   LDR   R2, [R1,#UART_FR_OFFSET]
        TST   R2, R3                  @ Check [R1:UART_FR_OFFSET] & UART_TXFF_MASK == 0.
        BNE   wait                    @ Loop till UART0 is ready to TX.
        STR   R0, [R1]                @ Store value R0 in [R1:UART_DR_OFFSET].
        POP   {R1, R2, R3}
        BX    LR                      @ Repeat.

.data
@ UART Address constants.
UART0_ADDR:     .word   0x101f1000  @ UART0 Base address
UART1_ADDR:     .word   0x101f2000  @ UART1 Base address
UART2_ADDR:     .word   0x101f3000  @ UART2 Base address
.end

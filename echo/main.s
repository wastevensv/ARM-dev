@ --- Equates
.equ    UART_DR_OFFSET, 0x00      @ UART Data Register Offset
.equ    UART_FR_OFFSET, 0x18      @ UART Flag Register Offset
.equ    UART_RXFE_MASK, 0x10      @ UART Flag Register RX Empty Mask
.equ    UART_TXFF_MASK, 0x20      @ UART Flag Register TX Full Mask
.equ    OUT_CHAR,       0x20      @ First printable ASCII character - 1.

.text
.global main
main:
/* Prints ASCII characters from 0x21 (!) - 0x7A (z) over UART0
 */
        LDR   R1, =UART0_ADDR         @ Load R1 with UART0_ADDR.
        LDR   R1, [R1]
ploop:  BL    getc                    @ Advance to next character.
        BL    putc
        SUBS  R2, R2, #1              @ Decrement counter.
        B     ploop
        B     .

putc:
/*  Prints the contents of R0 out of the UART pointed to by R1.
 *  Preconditions:
 *    R0 contains the character to send over the UART.
 *    R1 contains the address of the UART to send the character over.
 *  Modifies: None
 */
        PUSH  {R2, R3}                  @ Preserve used registers in stack.
        MOV   R3, #UART_TXFF_MASK
pwait:  LDR   R2, [R1,#UART_FR_OFFSET]  @ Check [R1:UART_FR_OFFSET] & UART_TXFF_MASK == 0.
        TST   R2, R3
        BNE   pwait                     @ Loop till UART0 is ready to TX.
        STR   R0, [R1,#UART_DR_OFFSET]  @ Store value R0 in [R1:UART_DR_OFFSET].
        POP   {R2, R3}                  @ Return used registers from stack.
        BX    LR                        @ Return to main.

getc:
/*  Prints the contents of R0 out of the UART pointed to by R1.
 *  Preconditions:
 *    R1 contains the address of the UART to send the character over.
 *  Modifies:
 *    R0 will contain the value in the UART buffer.
 */
        PUSH  {R2, R3}                  @ Preserve used registers in stack.
        MOV   R3, #UART_RXFE_MASK
gwait:  LDR   R2, [R1,#UART_FR_OFFSET]  @ Check [R1:UART_FR_OFFSET] & UART_TXFF_MASK == 0.
        TST   R2, R3
        BNE   gwait                     @ Loop till UART0 is ready to TX.
        LDR   R0, [R1,#UART_DR_OFFSET]  @ Store value R0 in [R1:UART_DR_OFFSET].
        POP   {R2, R3}                  @ Return used registers from stack.
        BX    LR                        @ Return to main.

.data
@ --- UART Address constants.
UART0_ADDR:     .word   0x101f1000  @ UART0 Base address
UART1_ADDR:     .word   0x101f2000  @ UART1 Base address
UART2_ADDR:     .word   0x101f3000  @ UART2 Base address

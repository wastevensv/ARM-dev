@ --- Equates
.equ    UART_DR_OFFSET, 0x00      @ UART Data Register Offset
.equ    UART_FR_OFFSET, 0x18      @ UART Flag Register Offset
.equ    UART_RXFE_MASK, 0x10      @ UART Flag Register RX Empty Mask
.equ    UART_TXFF_MASK, 0x20      @ UART Flag Register TX Full Mask

.text
.global main
main:
/* Prints ASCII characters from 0x21 (!) - 0x7A (z) over UART0
 */
        LDR   R1, =UART0_ADDR         @ Load R1 with UART0_ADDR.
        LDR   R1, [R1]
1$:     BL    getc                    @ Advance to next character.
        BL    case                    @ Swap case of character
        BL    putc                    @ Output character.
        B     1$
        B     .

case:
/*  Swaps the case of the character in R0.
 *  Preconditions:
 *    R0 contains the character to case swap.
 *  Modifies:
 *    R0 contains the case swapped character.
 */
        PUSH {R1}
        MOV   R1, #0b01000000
        TST   R0, R1
        BEQ   1$
        MOV   R1, #0b00100000
        EORS  R0, R0, R1
1$:     POP  {R1}
        BX    LR

putc:
/*  Prints the contents of R0 out of the UART pointed to by R1.
 *  Preconditions:
 *    R0 contains the character to send over the UART.
 *    R1 contains the address of the UART to send the character over.
 *  Modifies: None
 */
        PUSH  {R2, R3}                  @ Preserve used registers in stack.
        MOV   R3, #UART_TXFF_MASK
1$:     LDR   R2, [R1,#UART_FR_OFFSET]  @ Check [R1:UART_FR_OFFSET] & UART_TXFF_MASK == 0.
        TST   R2, R3
        BNE   1$                        @ Loop till UART0 is ready to TX.
        STR   R0, [R1,#UART_DR_OFFSET]  @ Store value R0 in [R1:UART_DR_OFFSET].
        POP   {R2, R3}                  @ Return used registers from stack.
        BX    LR                        @ Return to main.

getc:
/*  Reads a byte from the UART pointed to by R1 into R0.
 *  Preconditions:
 *    R1 contains the address of the UART to send the character over.
 *  Modifies:
 *    R0 will contain the value in the UART buffer.
 */
        PUSH  {R2, R3}                  @ Preserve used registers in stack.
        MOV   R3, #UART_RXFE_MASK
1$:     LDR   R2, [R1,#UART_FR_OFFSET]  @ Check [R1:UART_FR_OFFSET] & UART_RXFE_MASK == 0.
        TST   R2, R3
        BNE   1$                        @ Loop till UART0 is ready to RX.
        LDR   R0, [R1,#UART_DR_OFFSET]  @ Store value R0 in [R1:UART_DR_OFFSET].
        POP   {R2, R3}                  @ Return used registers from stack.
        BX    LR                        @ Return to main.

.data
@ --- UART Address constants.
UART0_ADDR:     .word   0x101f1000  @ UART0 Base address
UART1_ADDR:     .word   0x101f2000  @ UART1 Base address
UART2_ADDR:     .word   0x101f3000  @ UART2 Base address

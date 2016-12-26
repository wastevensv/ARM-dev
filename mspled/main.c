#include "msp432/msp432p401r.h"

int main(void) {
  int i = 0;
  /* Disable watchdog timer */
  WDT_A->CTL = WDT_A_CTL_PW | WDT_A->CTL | WDT_A_CTL_HOLD;

  /* Set P1.0 as output */
  P1->SEL0 &= ~BIT(0);
  P1->SEL1 &= ~BIT(0);
  P1->DIR  |=  BIT(0);

  while(1) {
    P1->OUT  |= BIT(0);
    for(i = 0; i < 5000; i++){}
    P1->OUT &= ~BIT(0);
    for(i = 0; i < 5000; i++){}
  }
}

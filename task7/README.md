# Task 7: External Interrupt (EIC) – Flashing an LED

In this task, you will learn how to configure the **External Interrupt Controller (EIC)** on the SAM microcontroller.  
The goal is to trigger an **interrupt** when a button is pressed, and inside the interrupt handler, toggle or flash an LED.

This builds on what you learned in Task 2 (interrupts on AVR) but now uses the **EIC peripheral** available on the ATSAM series.

---

## 1. What is the EIC?

- The **External Interrupt Controller (EIC)** allows the MCU to respond to external events (like button presses or sensor signals).  
- Each EIC line is mapped to one or more GPIO pins.  
- You can configure the interrupt to trigger on:
  - Rising edge (low → high)
  - Falling edge (high → low)
  - Both edges
  - Low or high level  

Using the EIC is more efficient than constantly polling a pin in your main loop.

---

## 2. Example: Configure Button on PB19, LED on PC5

For this example:
- **PB19** = button input (connected to EIC channel)  
- **PC5** = LED output  

Check your development board’s schematics/datasheet to confirm which pins are available for EIC input.

---

## 3. Initialization Steps

1. **Enable EIC clock** via the Generic Clock Controller (GCLK).  
2. **Configure the GPIO pin** (e.g., PA15) as an input with pull-up enabled.  
3. **Connect the pin to an EIC channel** using the Port Multiplexer (PMUX).  
4. **Configure the EIC** to detect rising or falling edges.  
5. **Enable the EIC interrupt** in the NVIC.  
6. **Write an interrupt handler (ISR)** to toggle the LED.

---

## 4. Example Code

```c
#include "sam.h"

void eic_init(void) {

    /* Selection of the Generator and write Lock for EIC */
    GCLK_REGS->GCLK_PCHCTRL[2] = GCLK_PCHCTRL_GEN(0x0UL)  | GCLK_PCHCTRL_CHEN_Msk;

    while ((GCLK_REGS->GCLK_PCHCTRL[2] & GCLK_PCHCTRL_CHEN_Msk) != GCLK_PCHCTRL_CHEN_Msk)
    {
        /* Wait for synchronization */
    }

    // Enable the pullup resistors for PB19
    PORT_REGS->GROUP[1].PORT_OUT = 0x80000U;
    PORT_REGS->GROUP[1].PORT_PINCFG[19] = 0x7U;

    PORT_REGS->GROUP[1].PORT_PMUX[9] = 0x0U;


    PORT_REGS->GROUP[2].PORT_DIR = 0x20U;
    PORT_REGS->GROUP[2].PORT_PINCFG[5] = 0x0U;

    PORT_REGS->GROUP[2].PORT_PMUX[2] = 0x0U;




    EIC_REGS->EIC_CTRLA |= (uint8_t)EIC_CTRLA_SWRST_Msk;

    while((EIC_REGS->EIC_SYNCBUSY & EIC_SYNCBUSY_SWRST_Msk) == EIC_SYNCBUSY_SWRST_Msk)
    {
        /* Wait for sync */
    }

    /* EIC is by default clocked by GCLK */

    /* NMI Control register */

    /* Interrupt sense type and filter control for EXTINT channels 8 to 15 */
    EIC_REGS->EIC_CONFIG[1] |= EIC_CONFIG_SENSE7_RISE;

    /* External Interrupt enable*/
    EIC_REGS->EIC_INTENSET = 0x8U;


    __DMB();
    __enable_irq();

    NVIC_SetPriority(EIC_IRQn, 3);
    NVIC_EnableIRQ(EIC_IRQn);
}


int main(void) {
    // Initialize EIC
    eic_init();

    while (1) {
        // main loop does nothing, LED toggling handled in ISR
    }
}

void __attribute__((used)) EIC_15_Handler(void) { // Important the function name has to match 
    // Clear interrupt flag
    EIC_REGS->INTFLAG = (1 << 15);

    // Toggle LED
    PORT_REGS->GROUP[0].PORT_OUTTGL = (1 << 5);
}
```
---
## Optional Challenges

- Use Event Systems instead of EIC to use button interrupt without CPU 


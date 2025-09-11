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

## 2. Example: Configure Button on PA15, LED on PA5

For this example:
- **PA15** = button input (connected to EIC channel)  
- **PA5** = LED output  

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
    // Step 1: Enable the EIC clock (GCLK0 by default)

    /* Selection of the Generator and write Lock for EIC */
    GCLK_REGS->GCLK_PCHCTRL[2] = GCLK_PCHCTRL_GEN(0x0UL)  | GCLK_PCHCTRL_CHEN_Msk;

    while ((GCLK_REGS->GCLK_PCHCTRL[2] & GCLK_PCHCTRL_CHEN_Msk) != GCLK_PCHCTRL_CHEN_Msk)
    {
        /* Wait for synchronization */
    }

    // Step 2: Configure PA15 as input with pull-up
    PORT_REGS->GROUP[0].PORT_DIRCLR = (1 << 15);       // input
    PORT_REGS->GROUP[0].PORT_PINCFG[15] = PORT_PINCFG_PULLEN | PORT_PINCFG_PMUXEN;
    PORT_REGS->GROUP[0].PORT_OUTSET = (1 << 15);       // enable pull-up

    // Step 3: Connect PA15 to EIC channel 15 (check datasheet for mapping)
    PORT_REGS->GROUP[0].PMUX[15 >> 1] = MUX_PA15A_EIC_EXTINT15;

    // Step 4: Configure EIC for falling edge detection
    EIC_REGS->EIC_CTRLA |= (uint8_t)EIC_CTRLA_SWRST_Msk;

    while((EIC_REGS->EIC_SYNCBUSY & EIC_SYNCBUSY_SWRST_Msk) == EIC_SYNCBUSY_SWRST_Msk)
    {
        /* Wait for sync */
    }

    /* EIC is by default clocked by GCLK */

    /* NMI Control register */

    /* Interrupt sense type and filter control for EXTINT channels 0 to 7*/
    EIC_REGS->EIC_CONFIG[0] =  EIC_CONFIG_SENSE0_NONE  |
                              EIC_CONFIG_SENSE1_NONE  |
                              EIC_CONFIG_SENSE2_NONE  |
                              EIC_CONFIG_SENSE3_RISE  |
                              EIC_CONFIG_SENSE4_NONE  |
                              EIC_CONFIG_SENSE5_NONE  |
                              EIC_CONFIG_SENSE6_NONE  |
                              EIC_CONFIG_SENSE7_NONE  ;

    /* Interrupt sense type and filter control for EXTINT channels 8 to 15 */
    EIC_REGS->EIC_CONFIG[1] =  EIC_CONFIG_SENSE0_NONE 
         |  EIC_CONFIG_SENSE1_NONE  
         |  EIC_CONFIG_SENSE2_NONE  
         |  EIC_CONFIG_SENSE3_NONE  
         |  EIC_CONFIG_SENSE4_NONE  
         |  EIC_CONFIG_SENSE5_NONE  
         |  EIC_CONFIG_SENSE6_NONE  
         |  EIC_CONFIG_SENSE7_NONE   ;

    /* External Interrupt enable*/
    EIC_REGS->EIC_INTENSET = 0x8U;


    __DMB();
    __enable_irq();

    NVIC_SetPriority(EIC_IRQn, 3);
    NVIC_EnableIRQ(EIC_IRQn);
}

void __attribute__((used)) EIC_15_Handler(void) { // Important the function name has to match 
    // Clear interrupt flag
    EIC_REGS->INTFLAG = (1 << 15);

    // Toggle LED
    PORT_REGS->GROUP[0].PORT_OUTTGL = (1 << 5);
}

int main(void) {
    // Configure LED pin PA5 as output
    PORT_REGS->GROUP[0].PORT_DIR |= (1 << 5);

    // Initialize EIC
    eic_init();

    while (1) {
        // main loop does nothing, LED toggling handled in ISR
    }
}

```
---
## Optional Challenges

- Use Event Systems instead of EIC to use button interrupt without CPU 


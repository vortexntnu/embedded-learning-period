# Task 6: Clock Configuration

So far, we’ve been relying on the **default clock configuration** that comes after reset.  
But in real embedded projects, you often need to configure the **system clock** to achieve the right performance, enable certain peripherals, or reduce power consumption.  

In this task, you will learn how to:
- Understand the clock system in the SAM series
- Select a clock source (internal oscillator, external crystal, etc.)
- Configure the Generic Clock Controller (GCLK)
- Route the clock to a peripheral (example: Timer/Counter)

---

## 1. Why Clocks Matter

Every operation inside a microcontroller is driven by a clock signal.  
- The **CPU clock** determines how fast instructions execute.  
- Peripheral clocks (timers, ADC, USART, CAN, etc.) must be configured correctly to generate accurate timings.  
- Power consumption depends heavily on the clock source and frequency.  

If your clock is wrong:
- Delays and baud rates will be inaccurate.
- Timers may drift.
- Some peripherals may not work at all.

---

## 2. SAM Clock System Overview

On the SAM series, the clock system has several building blocks:

- **Clock Sources**:  
  - Internal Oscillators (e.g., OSC16M = 16 MHz RC oscillator)  
  - External Oscillators (crystals, clocks from outside the chip)  
  - DFLL (Digital Frequency Locked Loop)  
  - DPLL (Digital Phase Locked Loop)

- **Generic Clock Generators (GCLK)**:  
  - Take an input source (like OSC16M or DFLL).  
  - Divide or multiply it.  
  - Distribute it to peripherals.

- **Bus Clocks**:  
  - CPU/AHB, APBA, APBB, APBC — each peripheral group is tied to one.  

---

## 3. Example: Configure CPU to 48 MHz

Below is a simplified example showing how to configure the CPU clock to 48 MHz
This is written for the SAMC21J17A

```c
#include "sam.h"

void OSCCTRL_Initialize(void) {
    /* Selection of the Division Value */
    OSCCTRL_REGS->OSCCTRL_OSC48MDIV = 0;

    while ((OSCCTRL_REGS->OSCCTRL_OSC48MSYNCBUSY &
            OSCCTRL_OSC48MSYNCBUSY_OSC48MDIV_Msk) ==
           OSCCTRL_OSC48MSYNCBUSY_OSC48MDIV_Msk) {
        /* Waiting for the synchronization */
    }

    while ((OSCCTRL_REGS->OSCCTRL_STATUS & OSCCTRL_STATUS_OSC48MRDY_Msk) !=
           OSCCTRL_STATUS_OSC48MRDY_Msk) {
        /* Waiting for the OSC48M Ready state */
    }

    OSCCTRL_REGS->OSCCTRL_OSC48MCTRL |= OSCCTRL_OSC48MCTRL_ONDEMAND_Msk;
}


void GCLK0_Initialize(void) {
    GCLK_REGS->GCLK_GENCTRL[0] =
        GCLK_GENCTRL_DIV(0UL) | GCLK_GENCTRL_SRC(6UL) | GCLK_GENCTRL_GENEN_Msk;   

    while ((GCLK_REGS->GCLK_SYNCBUSY & GCLK_SYNCBUSY_GENCTRL0_Msk) ==
           GCLK_SYNCBUSY_GENCTRL0_Msk) {
        /* wait for the Generator 0 synchronization */
    }
}


void CLOCK_Initialize(void) {
    /* Function to Initialize the Oscillators */
    OSCCTRL_Initialize();

    /* Function to Initialize the 32KHz Oscillators */

    GCLK0_Initialize();
    
    // Example configuring CAN0 peripherals
    GCLK_REGS->GCLK_PCHCTRL[26] = GCLK_PCHCTRL_GEN(0x0) | GCLK_PCHCTRL_CHEN_Msk;

    while ((GCLK_REGS->GCLK_PCHCTRL[26] & GCLK_PCHCTRL_CHEN_Msk) !=
           GCLK_PCHCTRL_CHEN_Msk) {
        /* Wait for synchronization */
    }

}

```

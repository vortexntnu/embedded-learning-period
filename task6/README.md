# Task 6: Clock Configuration

So far, we’ve been relying on the **default clock configuration** that comes after reset.  
But in real embedded projects, you often need to configure the **system clock** to achieve the right performance, enable certain peripherals, or reduce power consumption.  

In this task, you will learn how to:
- Understand the clock system in the SAM series
- Select a clock source (internal oscillator, external crystal, etc.)
- Configure the Generic Clock Controller (GCLK)
- Route the clock to a peripheral (example: Timer/Counter)

Since we in task7 will use EIC, I recommend Configuring the clock for EIC (External interrupt controller)

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


---

# 3. CPU Clock @ 48 MHz on SAMC21J17A (with GCLK & Peripheral Enable)

Below is a simplified example showing how to configure the CPU clock to **48 MHz** using the **internal 48 MHz oscillator (OSC48M)** and route it via **GCLK0**. Finally, we enable a peripheral clock (CAN0) as an example.

> **Why this matters:**
>
> * The CPU and peripherals won’t run at intended speeds unless the system clock is configured.
> * Baud rates, timers, and sampling frequencies all depend on correct clocking.
> * On SAMC21, **OSC48M** is the primary internal high-speed clock source. We select it, wait for it to be ready, and feed it to **GCLK0** (the main generator).

---

## 4. Configuring the Clock Source (OSC48M)

This function configures the **48 MHz internal oscillator** block (**OSC48M**) inside **OSCCTRL** and ensures it’s ready before use.

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
```

### What each line does

* `OSCCTRL_OSC48MDIV = 0;`
  Sets the **divider** for the 48 MHz oscillator to **÷1** (no division). The output remains **48 MHz**.

  > If you needed 24 MHz, you’d pick a divider > 0 (check the datasheet’s valid values).

* `OSC48MSYNCBUSY` wait loop
  Many clock writes are **synchronized** across clock domains. You must wait until the hardware clears the sync-busy bit before proceeding, or later writes may be ignored.

* `OSCCTRL_STATUS & OSC48MRDY` wait loop
  Waits until the **48 MHz oscillator is stable/ready**. Using it before `RDY` is set can cause unpredictable behavior.

* `OSC48MCTRL |= ONDEMAND`
  **On-Demand** mode lets hardware **auto-gate** the oscillator when no consumer needs it (power-saving). As soon as something needs the clock (e.g., GCLK), the oscillator wakes up.

> **Tip:** If you’re troubleshooting a clock that seems to “disappear,” try disabling ONDEMAND during bring-up so the source stays active.

---

## 5. Configure the Main Generic Clock (GCLK0)

**GCLK0** is the “main generator” that typically feeds the **CPU** and many peripherals (directly or indirectly). Here we select **OSC48M** as its source and enable it.

```c
void GCLK0_Initialize(void) {
    GCLK_REGS->GCLK_GENCTRL[0] =
        GCLK_GENCTRL_DIV(0UL) | GCLK_GENCTRL_SRC(6UL) | GCLK_GENCTRL_GENEN_Msk;   

    while ((GCLK_REGS->GCLK_SYNCBUSY & GCLK_SYNCBUSY_GENCTRL0_Msk) ==
           GCLK_SYNCBUSY_GENCTRL0_Msk) {
        /* wait for the Generator 0 synchronization */
    }
}
```

### What each field means

* `GCLK_GENCTRL_DIV(0)`
  A divider of **0** means **divide by 1** on this generator (i.e., pass 48 MHz through unchanged).

  > If you needed a slower CPU/peripheral clock, you could divide here.

* `GCLK_GENCTRL_SRC(6)`
  **Source selector**. On SAMC21, `6` corresponds to **OSC48M** (internal 48 MHz).

  > Source IDs are silicon-specific; confirm the numeric code in the device header/datasheet.

* `GCLK_GENCTRL_GENEN`
  Enables the generator. Without this bit, the generator remains off even if configured.

* `SYNCBUSY` wait loop
  As with OSCCTRL, you **must** wait for GCLK to synchronize after changing its configuration.

> **Result:** GCLK0 now outputs **48 MHz** sourced from OSC48M.

---

## 6. Putting It Together & Enabling Peripheral Clocks

Finally, we call our two init functions and **enable a peripheral** (CAN0) by:

1. Routing a generator to the peripheral’s **PCHCTRL** (channel control), and
2. Enabling the module’s **bus clock** in **MCLK**.

```c
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

    MCLK_REGS->MCLK_AHBMASK |= (1 << 8);  // CAN0

}
```

### What’s happening here

* `OSCCTRL_Initialize();`
  Brings up **OSC48M** and waits for it to be stable.

* `GCLK0_Initialize();`
  Sets **GCLK0 = 48 MHz (OSC48M)**, divide-by-1.

* `GCLK_PCHCTRL[26] = GEN(0) | CHEN;`
  **Peripheral Channel 26** (CAN0 on SAMC21) is being **clocked by Generator 0** (GCLK0) and **enabled**.

  * `GEN(0)` selects **GCLK0** as the source for this peripheral’s channel.
  * `CHEN` actually **enables** the clock channel to the peripheral.
  * The wait loop ensures the channel is fully enabled before continuing.

* `MCLK_AHBMASK |= (1 << 8);`
  Enables the **AHB bus clock** to the **CAN0 module**.

  > On SAM devices, a peripheral typically needs **both**:
  >
  > 1. a **GCLK channel** (functional clock), and
  > 2. its **bus mask** (so the CPU can access its registers).
  >    Forgetting either one leads to “peripheral not responding” bugs.

> **Note on “32 kHz oscillators” comment:**
> The placeholder comment suggests you might later enable a **low-frequency** clock (e.g., OSC32K/RTC). It’s not used in this minimal example.

---

## Verification & Troubleshooting

* **Is the CPU really at 48 MHz?**

  * Toggle a GPIO in a tight loop and measure the frequency on a scope.
  * Or set up a timer to generate a 1 kHz square wave and confirm the period.

* **Peripheral doesn’t work?**

  * Check **both** the **GCLK\_PCHCTRL\[x]** (GEN + CHEN) **and** the **MCLK mask** for that peripheral.
  * Ensure the **source ID** for `GCLK_GENCTRL_SRC()` matches **OSC48M** on your part.
  * Make sure **SYNCBUSY** waits are present after each clock write.

* **Power saving (ONDEMAND) confusion:**

  * During bring-up, consider clearing ONDEMAND to keep the source always on. Add it back once you’re stable.

---

## Mental Model (Summary)

1. **Turn on** and **stabilize** a clock **source** (OSC48M @ 48 MHz).
2. Configure a **GCLK generator** (GCLK0) to **use that source** and **enable it**.
3. For each **peripheral**, connect a **GCLK channel** (PCHCTRL) and **enable its bus clock** (MCLK mask).
4. Always **wait for sync** after changing clock registers.

This flow will carry you through most clocking tasks on the SAMC21 family.

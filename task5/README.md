
# Task 5: LED Blink V2 (ATSAM Series)

Up to now, we have worked with the **8-bit AVR microcontrollers** (e.g., AVR128DA48).  
These are great for learning, but in real projects we often need more performance, more peripherals, and 32-bit architectures.  

In this task, we move on to the **ATSAM series**, which are **32-bit ARM Cortex-M based microcontrollers**.  
This introduces us to new registers, naming conventions, and more complex hardware.  

---

## 1. AVR vs SAM Syntax

The basic idea is still the same:  
- Configure a pin as an **output**  
- Write to the pin to turn an LED **on/off**  

But the **register interface** is different.  

### Example: Setting PA5 as an output

**ATSAM (32-bit):**
```c
int main(void) {
    // Enable PA5 as output using SAM PORT register group
    PORT_REGS->GROUP[0].PORT_DIR |= (1 << 5);
    
    while (1) {
        // toggle LED here
    }
}
````

**AVR (8-bit):**

```c
int main(void) {
    // Enable PC6 as output using AVR DDR register
    PORTC.DIR |= (1 << 6);

    while (1) {
        // toggle LED here
    }
}
```

Notice how the syntax changes:

* **AVR** uses simple registers like `PORTC.DIR`.
* **SAM** uses `PORT_REGS->GROUP[x]` with array indexing for different port groups.

This difference reflects the increased **complexity and flexibility** of ARM-based MCUs.

---

## 2. Key Differences Between AVR and SAM

* **Word size**:

  * AVR → 8-bit registers (simple, compact).
  * SAM → 32-bit registers (more powerful, more fields per register).

* **Register access**:

  * AVR → `PORTx.DIR`, `PORTx.OUT` style.
  * SAM → `PORT_REGS->GROUP[n].PORT_DIR`, `PORT_REGS->GROUP[n].PORT_OUT`.

* **Port groups**:

  * On SAM, ports are organized into **groups** (e.g., `GROUP[0]` = Port A, `GROUP[1]` = Port B).
  * Each group has its own set of registers.

---

## 3. Exercise – LED Blink on ATSAM

Your task:

1. Configure **PA5** as an output.
2. Write code to turn the LED on and off with a delay.
3. Verify that the LED blinks at about 1 Hz.


```c
#include "sam.h"

void delay(volatile uint32_t count) {
    while (count--) {
        __NOP(); // No Operation Instruction
    }
}

int main(void) {
    // 1. Set PA5 as output
    PORT_REGS->GROUP[0].PORT_DIR |= (1 << 5);

    while (1) {
        // 2. Turn LED on
        PORT_REGS->GROUP[0].PORT_OUT |= (1 << 5);
        delay(100000);

        // 3. Turn LED off
        PORT_REGS->GROUP[0].PORT_OUT &= ~(1 << 5);
        delay(100000);
    }
}
```

---

## 4. Optional Challenges

* Try toggling the LED using `PORT_OUTTGL` instead of manually setting and clearing bits.
* Change the delay length to adjust the blink frequency.
* Use a **timer peripheral** instead of a busy-wait loop for more accurate timing.
* Identify in the datasheet which pin your dev board LED is connected to (some use PA17 instead of PA5).

---

**Goal:**
By the end of this task, you should:

* Understand the difference between **8-bit AVR** and **32-bit SAM** syntax.
* Know how to configure a GPIO pin as an output on the SAM MCU.
* Successfully blink an LED on a 32-bit ARM Cortex-M microcontroller.


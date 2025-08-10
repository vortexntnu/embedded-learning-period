# Task 2: Button Interrupt

In embedded systems, **interrupts** allow the microcontroller to respond to events immediately without constantly checking for them in the main loop.  
This is more efficient than polling and is essential for responsive, low-power systems.

In this task, you will configure a push-button to trigger an interrupt that toggles the LED you set up in **Task 1**.

---

## 1. Reading the Datasheet

One of the most crucial skills in embedded development is learning how to **read and interpret datasheets**.  
The datasheet tells you how the hardware works, what registers to use, and the meaning of each bit.

📄 **AVR128DA48 Datasheet**:  
[Download Here (Microchip)](https://ww1.microchip.com/downloads/en/DeviceDoc/AVR128DB28-32-48-64-DataSheet-DS40002247A.pdf)

For this task, you will need to look up:
- How to configure pins as inputs/outputs
- How to enable pull-up resistors
- How to configure port interrupts

---

## 2. Hardware Connections

- **LED**: PC6 (Port C, Pin 6) – Output
- **Button**: PC7 (Port C, Pin 7) – Input

---

## 3. What Needs to Be Configured

1. **Set LED pin to output** (PC6) – so we can control it.
2. **Set button pin to input** (PC7) – so it can receive button presses.
3. **Enable the pull-up resistor** on PC7 – ensures the input reads HIGH when the button is not pressed.
4. **Configure the interrupt** on PC7 – trigger on a **rising edge** (low → high transition).

---

## 4. Steps to Enable Interrupts

### 4.1 Include the Required Header
```c
#include <avr/io.h>
#include <avr/interrupt.h>
```
- `<avr/io.h>` – for register definitions  
- `<avr/interrupt.h>` – for `sei()` and ISR handling

---

### 4.2 Enable Global Interrupts
In the `main()` function, after initializing pins and peripherals:
```c
int main(void) {
    pin_init(); // Set up LED and button
    sei();      // Enable global interrupts
    
    while (1) {
        // Main loop stays empty because the ISR handles events
    }
}
```
- `sei()` (Set Enable Interrupts) allows the microcontroller to process interrupts.
- Without calling `sei()`, even correctly configured interrupts won’t trigger.

---

## 5. Writing the Interrupt Service Routine (ISR)

The ISR is the function that runs **automatically** when the button is pressed and the interrupt is triggered.

```c
ISR(PORTC_PORT_vect) {
    // Code to execute when the button interrupt fires
    
    // Clear the interrupt flag for PC7
    PORTC.INTFLAGS = (1 << 7);
}
```

### Important Notes:
- `PORTC.OUTTGL` toggles the LED pin without needing to check its current state.
- **You must clear the interrupt flag** (`PORTC.INTFLAGS`) at the end of the ISR; otherwise, the ISR may immediately trigger again.
- ISRs should be short and fast — do not put long delays or heavy computation inside them.
---


## 8. Optional Challenges
- Change the interrupt to trigger on a **falling edge** instead.
- Use a **different button** and configure it for a different LED.
- Add a **debounce delay** (software or hardware) to prevent multiple triggers on a single press.

---

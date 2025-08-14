# Task 1: LED Blink ("Hello World" of Embedded Systems)

In traditional programming, the first program you write is often **"Hello World"**.  
In embedded systems, the equivalent is making an LED blink — it’s a simple, visible way to verify that your code is running and that you can control hardware.

In this task, you will learn how to:
- Identify which pin controls the LED on your development board
- Configure that pin as an output
- Turn the LED on and off in code
- Use delays to make the LED blink

---

## 1. Hardware Overview

Before we can control the LED, we must know **which port and pin** it is connected to.

On the **AVR128DA48** development board:
- The user LED is connected to **PC6**  
  (Port C, Pin 6)

On the **AVR128DB48** development board:
- The user LED is connected to **PB3**  
  (Port B, Pin 3)

You will use this information to set the correct register bits for output.

---

## 2. Main Program Structure

A basic C program for an AVR microcontroller typically has the following structure:

```c
#include <avr/io.h>
#include <util/delay.h>  // for _delay_ms()

int main(void) {

    // Initialization code here
    // Example: configure pins

    while (1) {
        // Main loop
    }
}
```

> **Note:** If you are using MPLAB X IDE or Atmel/Microchip Studio, much of this structure may be auto-generated for you.

---

## 3. Step 1 – Configure PC6 as an Output

To control an LED, the microcontroller pin must be set to **output mode**.  
This is done by writing to the **Data Direction Register (DDR)** for the corresponding port.

Example function:

```c
void pin_init(void) {
    PORTC.DIR |= (1 << 6);  // Set bit 6 to '1' → PC6 is now an output
}
```

- `PORTC.DIR` is the direction register for Port C  
- `(1 << 6)` creates a bitmask for pin 6  
- `|=` sets that bit to 1 without changing the others

---

## 4. Step 2 – Turning the LED On and Off

Once PC6 is an output, we can write to the **PORTC.OUT** register to set the voltage high (LED on) or low (LED off).

```c
void led_enable(void) {
    PORTC.OUT |= (1 << 6);   // Set bit 6 high → LED ON
}

void led_disable(void) {
    PORTC.OUT &= ~(1 << 6);  // Clear bit 6 → LED OFF
}
```

---

## 5. Step 3 – Making the LED Blink

We can combine the `led_enable()` and `led_disable()` functions with a delay to create a blinking effect.

```c
#include <avr/io.h>
#include <util/delay.h>

void pin_init(void) {
    PORTC.DIR |= (1 << 6);  // Set PC6 as output
}

void led_enable(void) {
    PORTC.OUT |= (1 << 6);  // LED ON
}

void led_disable(void) {
    PORTC.OUT &= ~(1 << 6); // LED OFF
}

int main(void) {
    pin_init();

    while (1) {
        led_enable();
        _delay_ms(500);   // Wait 500 milliseconds
        led_disable();
        _delay_ms(500);   // Wait another 500 milliseconds
    }
}
```

---

## 6. Extra Challenges (Optional)
- Change the blink speed by modifying the delay.
- Use a variable to store the delay time and adjust it inside the loop.
- Try inverting the LED state with XOR instead of separate enable/disable functions.
- Experiment with connecting another LED to a different pin and blinking both in different patterns.

---

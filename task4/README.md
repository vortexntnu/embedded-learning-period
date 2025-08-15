# Task 4: Capstone Project – Multi-File, Multi-Peripheral Embedded Application

In larger embedded projects, you often find yourself writing **hundreds or even thousands of lines of code**.  
If you put everything in a single file, it quickly becomes messy and hard to maintain.  

To keep code **organized** and **readable**, it’s standard practice to split a project into **multiple source files** and **header files**.

---

## 1. Why Split into Multiple Files?

Splitting code into modules makes it easier to:
- Reuse code across projects
- Find and fix bugs
- Work in teams (different people can work on different files)
- Keep `main.c` focused on **program flow**, not hardware details

---

## 2. Example Project Structure

A project using a **timer** and **USART** might be organized like this:

```
include/
    usart.h
    timer.h
src/
    main.c
    usart.c
    timer.c
```

### **Header files (`.h`)**
- Contain **function declarations**, macro definitions, and `#include` statements needed by other files.
- Do **not** contain function definitions (except inline functions).

Example `usart.h`:
```c
#ifndef USART_H // These are header guards to avoid the same .h file being include multiple times
#define USART_H

#include <stdint.h>  // for uint8_t

void usart_init(void);
void usart_send_byte(uint8_t byte);
void usart_send_string(const char *str);

#endif
```

---

### **Source files (`.c`)**
- Contain the **function definitions** (actual code).
- Include the corresponding header file at the top.

Example `usart.c`:
```c
#include "usart.h"
#include <avr/io.h>

void usart_init(void) {
    // Initialize USART here
}

void usart_send_byte(uint8_t byte) {
    // Send a single byte over USART
}

void usart_send_string(const char *str) {
    // String sent over USART
}
```

---

### **Main file (`main.c`)**
- Includes only the header files for the modules it uses.
- Focuses on the **application logic**, not hardware details.

Example `main.c`:
```c
#include "usart.h"
#include "timer.h"

int main(void) {
    usart_init();
    timer_init();

    while (1) {
        usart_send_string("Hello from Task 4!\r\n");
        timer_delay_ms(1000);
    }
}
```

---

## 3. Task Requirements

Your goal is to **create a project that uses multiple peripherals** and is split into multiple source/header files.

### **Mandatory:**
1. Must use **serial communication**:
   - USART
   - I²C
   - or SPI
2. Must use **at least one other peripheral**, for example:
   - Timer
   - ADC
   - PWM
   - GPIO
   - External Interrupts

---

## 4. Example Project Ideas
- **USART + Timer**: Send a message over USART every second.
- **USART + PWM**: Adjust a PWM duty cycle from commands sent via a serial terminal. 
- **I²C + ENCODER**: Read a sensor value using I²C (**HARD**)

---

## 5. Tips for This Task
- Keep each peripheral’s code in its own `.c`/`.h` file.
- Use **descriptive function names** (e.g., `timer_init()`, `adc_read()`).
- Include only what you need in headers—avoid unnecessary dependencies.
- Test each peripheral separately before combining them.

---

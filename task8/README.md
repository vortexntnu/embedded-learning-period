#  Final Task – Embedded Learning Period

Congratulations! You’ve made it to the **final task** of the learning period.   

By now, you’ve learned the fundamentals of embedded C, worked with registers directly, and experimented with various peripherals on both AVR and SAM microcontrollers.  

One important part of learning is **“reinventing the wheel”** — writing low-level drivers yourself, so you really understand what’s happening under the hood.  
But in real-world projects, some peripherals (like CAN, I²C, and DMA) are **too complex to reinvent every time**.  

That’s where vendor-supplied libraries come in. Microchip provides **PLIB (Peripheral Libraries)** as part of the **MPLAB Harmony framework**. These give you pre-written drivers for most SAM peripherals, so you can focus on application logic rather than register fiddling.

---

## Reference Repositories

- [**SAMEx (D5x/E5x series):**](https://github.com/Microchip-MPLAB-Harmony/csp_apps_sam_d5x_e5x.git)

- [**SAMC21x (C20/C21 series):**](https://github.com/Microchip-MPLAB-Harmony/csp_apps_sam_c20_c21.git)

Browse these repositories to see **working examples** of different peripherals. You’ll often find ready-made drivers and example code that you can adapt to your project.

---

# Task 8 

The final task is very similar in spirit to **Task 4**, but now on the **SAM microcontroller series**.  
You will **design and implement a small project** that combines:

1. **One communication protocol** (choose one):  
   - USART  (Easy)
   - I²C  (Medium)
   - SPI  (Difficult)
   - CAN  (Very difficult)

2. **At least one additional peripheral**, such as:  
   - Timer/Counter (e.g., PWM generation or periodic interrupts)  
   - ADC (analog sensor input)  
   - DAC (waveform generation)  
   - GPIO (LED/button control)  
   - External Interrupt (EIC)  

---

## Suggested Project Ideas

- **USART + PWM**  
  Control an LED’s brightness (PWM duty cycle) by sending commands over the serial terminal.

- **I²C + ADC**  
  Read a sensor value using the ADC and display the results on an I²C LCD.

- **SPI + Timer**  
  Send periodic data packets over SPI, triggered by a hardware timer.

- **CAN + GPIO**  
  Receive CAN messages to toggle LEDs or control motors; send status frames back.

- **USART + ADC**  
  Implement a simple oscilloscope: read an analog voltage with the ADC and print values over USART.

---

##  Requirements

- The project must **compile and run** on your SAM board.  
- It must include **at least 2 peripherals** (1 communication + 1 other).  
- Your code should be **modular** (separate `.c`/`.h` files).  
- Use of **PLIB drivers** is encouraged where appropriate — especially for communication protocols.  
- Push your code to the repo under a folder called `task8_{username}/`.

---

##  Bonus Challenges

- Use **DMA** to transfer data automatically (e.g., ADC → memory → USART).  
- Implement a **command parser** (e.g., “SET PWM 50” in USART changes LED duty cycle).  
- Combine **three peripherals** instead of two.  
- Add **error handling** (timeouts, invalid input).  
- Document your project in a short `README.md` inside your task folder, explaining what you built.

---

##  Key Takeaways

By completing this task, you will:
- Learn how to leverage **vendor libraries (PLIB/Harmony)**.  
- Practice integrating **multiple peripherals** into one cohesive application.  
- Build something closer to what you would implement in a **real AUV subsystem**.  
- Gain confidence in reading vendor examples, adapting code, and debugging.  

This is your chance to **be creative** and make something cool that shows off everything you’ve learned in the embedded learning period. 🚀

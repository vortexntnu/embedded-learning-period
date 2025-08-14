# Task 3: USART Communication

**USART** (Universal Synchronous and Asynchronous Receiver-Transmitter) is a hardware module that enables serial communication between your microcontroller and other devices such as PCs, other microcontrollers, or sensors.

In this task, you will:
- Initialize USART1 on the AVR128DA48
- Send messages from the microcontroller to your computer
- Read input from the computer and respond

---

## 1. Why USART?

USART is commonly used for:
- **Debugging** – Sending messages to a terminal on your PC.
- **Control** – Receiving commands to change settings in your program.
- **Data Transfer** – Sending sensor readings or other information.

When configured in **asynchronous mode**, it uses only two wires:
- **TX** (Transmit)
- **RX** (Receive)

---

## 2. Reading the Datasheet

📄 **AVR128DA48 Datasheet**:  
[Download Here](https://ww1.microchip.com/downloads/aemDocuments/documents/MCU08/ProductDocuments/DataSheets/AVR128DA28-32-48-64-Data-Sheet-DS40002183.pdf)

📄 **AVR128DB48 Datasheet**:  
[Download Here (Microchip)](https://ww1.microchip.com/downloads/aemDocuments/documents/MCU08/ProductDocuments/DataSheets/AVR128DB28-32-48-64-DataSheet-DS40002247.pdf)

Look for:
- The `USART` section
- Baud rate calculation
- Pin mappings for TX/RX
- Register descriptions for control and status

---

## 3. Hardware Connections

On the AVR128DA48:
- **USART1 TX (Transmit)** → `PC0`
- **USART1 RX (Receive)** → `PC1`

On the AVR128DA48:
- **USART3 TX (Transmit)** → `PB0`
- **USART3 RX (Receive)** → `PB1`
---

## 4. Steps to Configure USART1

1. **Select baud rate** (e.g., 9600 bps)
2. **Enable TX and/or RX** as needed
3. **Enable interrupts** if you want to handle received data asynchronously
4. **Configure frame format** (default: 8 data bits, no parity, 1 stop bit)

---

## 5. Example Initialization Code


```c
#include <avr/io.h>
#include <avr/interrupt.h>

#define F_CPU 4000000UL // 4 MHz clock
#define USART1_BAUD_RATE(BAUD_RATE)     ((float)(64 * 4000000 / (16 * (float)BAUD_RATE)) + 0.5)

// Note: for the AVR128DB48 use USART3

void usart1_init(void) {
    // Set baud rate
    USART1.BAUD = (uint16_t)usart1_BAUD_RATE(9600);

    // Enable TX and RX
    USART1.CTRLB |= USART_TXEN_bm | USART_RXEN_bm;

    // Optional: Enable RX Complete Interrupt
    // USART1.CTRLA |= USART_RXCIE_bm;
}

void usart1_send_char(char c) {
    while (!(USART1.STATUS & USART_DREIF_bm)) {
        // Wait for data register to be empty
    }
    USART1.TXDATAL = c;
}

char usart1_read_char(void) {
    while (!(USART1.STATUS & USART_RXCIF_bm)) {
        // Wait for data
    }
    return USART1.RXDATAL;
}
```

---

## 6. Example Usage

```c
int main(void) {
    usart1_init();
    sei(); // Only needed if using interrupts

    usart1_send_string("USART1 Initialized\r\n");

    while (1) {
        char c = usart1_read_char(); // Wait for input
        usart1_send_string("You typed: ");
        usart1_send_char(c);
        usart1_send_string("\r\n");
    }
}
```

---

## 7. Using a Serial Monitor

1. Connect your USB-to-UART adapter to your PC.
2. Open a terminal program (e.g., PuTTY, Tera Term, Arduino Serial Monitor).
3. Select the COM port for your adapter.
4. Set the baud rate to match your configuration (e.g., **9600** bps).

---

## 8. Optional Challenges
- Change the baud rate to **115200** and confirm communication still works.
- Implement a **command parser** so typing `ON` turns the LED on, and `OFF` turns it off.
- Use the **USART RX Complete Interrupt** instead of polling for input.
- Send a periodic status message every second.

---

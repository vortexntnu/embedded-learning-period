/**
 * @file main.c
 * @author rikke
 * @date 2025-09-10
 * @brief Main function
 */

#include <avr/io.h>
#include <stdlib.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <string.h>

#define F_CPU 4000000UL // 4 MHz clock
#define USART1_BAUD_RATE(BAUD_RATE)     ((float)(64 * 4000000 / (16 * (float)BAUD_RATE)) + 0.5) 

void usart1_init(void) {
    USART1.BAUD = (uint16_t)USART1_BAUD_RATE(9600);

    PORTC.DIR |= 1;
    PORTC.PIN1CTRL |= (1 << 3);

    USART1.CTRLA |= (1 << 7);
    USART1.CTRLB |= (1 << 6) | (1 << 7);

}

void usart1_send_char(char c) {
    while (!(USART1.STATUS & USART_DREIF_bm)) {
        // Wait for data register to be empty
    }
    USART1.TXDATAL = c;
}

void usart1_send_string(char str[]) {
    for (int i = 0; i < strlen(str); i++)
    {

        usart1_send_char(str[i]);
    }
    
    
}

char usart1_read_char(void) {
    while (!(USART1.STATUS & USART_RXCIF_bm)) {
        // Wait for data
    }
    return USART1.RXDATAL;
}

void pin_init(void) {
    PORTC.DIR |= (1 << 6);
    PORTC.PIN7CTRL |= (1 << 3) | 2;
}

void led_enable(void) {
    PORTC.OUT |= (1 << 6);
}

void led_disable(void) {
    PORTC.OUT &= ~(1 << 6);
}

ISR(PORTC_PORT_vect) {
    //PORTC.OUTTGL |= (1 << 6);
    
    // Clear the interrupt flag for PC7
    PORTC.INTFLAGS = (1 << 7);
}

ISR(USART1_RXC_vect) {
    char c1 = USART1.RXDATAL;
    //usart1_send_char(c);

    if (c1 == 'o') {
        char c2 = usart1_read_char();
        //usart1_send_char(c1);
        if (c2 == 'n') {
            //usart1_send_char(c2);
            led_disable();
        }
        else if (c2 == 'f') {
            //usart1_send_char(c2);
            char c3 = usart1_read_char();
            if (c3 == 'f') {
                usart1_send_char(c3);
                led_enable();
            }
        }
    }

    /* if (c == 'n') {
        char c = USART1.RXDATAL;
        usart1_send_char(c);
        if (c == 'o') {
            led_disable();
            usart1_send_char(c);
        }
    }
    else if (c == 'f') {
        char c = USART1.RXDATAL;
        usart1_send_char(c);
            if (c == 'f') {
                usart1_send_char(c);
                usart1_send_char('2');
                char c = USART1.RXDATAL;
                if (c == 'o') {
                    led_enable();
                    usart1_send_char(c);
                }
            }
        } */
    

    USART1.STATUS = (1 << 7);
}

int main(void) {
    pin_init();
    usart1_init();
    sei(); // Only needed if using interrupts

    usart1_send_string("USART1 Initialized\r\n");

    while (1) {
        
    }
}

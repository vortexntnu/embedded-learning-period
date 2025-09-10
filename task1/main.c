
#include <avr/io.h>
#include <stdlib.h>
#include <util/delay.h>

void led_pin_init(void){
    PORTC.DIR |= (1<<6);
}

void led_on(void){
    PORTC.OUT |= (1<<6);
}

void led_off(void){
    PORTC.OUT &= ~(1<<6);
}

int main(void) {
    // Initialization code here
    // Example: configure pins

    led_pin_init();


    while (1) {
        led_on();
        _delay_ms(500);
        led_off();
        _delay_ms(500);
        // Main loop
    }
    return EXIT_FAILURE;
}
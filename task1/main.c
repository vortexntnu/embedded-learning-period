
#include <avr/io.h>
#include <stdlib.h>

void pin_init(void) {
    PORTC.DIR |= (1 << 6);
}

void pin_enable(void) {
    PORTC.OUT |= (1 << 6);
}

void pin_disable(void) {
    PORTC.OUT &= ~(1 << 6);
}

int main(void) {
    / pin_init();

    while (1) {
        led_enable();
        _delay_ms(500);  // Wait 500 milliseconds
        led_disable();
        _delay_ms(500);  // Wait another 500 milliseconds
    }
    return EXIT_FAILURE;
}

/**
 * @file main.c
 * @author vikingur
 * @date 2025-09-10
 * @brief Main function
 */
#include <avr/io.h>
#include <avr/interrupt.h>


void pin_config(){
    PORTC.DIR |= (1<<6);
    PORTC.DIR &= ~(1<<7);
    PORTC.PIN7CTRL |= (1<<3)|(3);
}

int main(){

   // Add your code here and press Ctrl + Shift + B to build
    pin_config();
    sei();
        

    return 0;
}

ISR(PORTC_PORT_vect){

    PORTC.OUTTGL |= (1<<6);

    PORTC.INTFLAGS |= (1<<7);
}
#ifndef USART_H // These are header guards to avoid the same .h file being include multiple times
#define USART_H

#include <stdint.h>  // for uint8_t

#ifdef __cplusplus
extern "C"{ // Used to allow C++ compatability
#endif


void usart_init(void);
void usart_send_byte(uint8_t byte);
void usart_send_string(const char *str);

#ifdef __cplusplus
}
#endif

#endif
/**
 * @file sercom.c
 * @author vikingur
 * @date 2025-09-10
 * @brief sercom
 */
#include <same51j20a.h>
#include <stdint.h>


void SERCOM5_init(void){
    SERCOM5_REGS->USART_INT.SERCOM_CTRLA = SERCOM_USART_INT_CTRLA_SWRST_Msk;
    while(SERCOM5_REGS->USART_INT.SERCOM_SYNCBUSY & SERCOM_USART_INT_SYNCBUSY_SWRST_Msk){
        //wait
    }
    SERCOM5_REGS->USART_INT.SERCOM_CTRLA |= SERCOM_USART_INT_CTRLA_MODE_USART_INT_CLK
                                            |SERCOM_USART_INT_CTRLA_CMODE_ASYNC
                                            |SERCOM_USART_INT_CTRLA_RXPO_PAD1
                                            |SERCOM_USART_INT_CTRLA_TXPO_PAD0
                                            |SERCOM_USART_INT_CTRLA_DORD_MSB;

    SERCOM5_REGS->USART_INT.SERCOM_CTRLB |= SERCOM_USART_INT_CTRLB_CHSIZE_8_BIT
                                            |SERCOM_USART_INT_CTRLB_PMODE_EVEN
                                            |SERCOM_USART_INT_CTRLB_SBMODE_1_BIT;

    SERCOM5_REGS->USART_INT.SERCOM_BAUD = 64278;
    


}
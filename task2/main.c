/**
 * @file main.c
 * @author vikingur
 * @date 2025-09-10
 * @brief Main function
 */


#include <same51j20a.h>

static void nvic_init(void) {

    NVIC_SetPriority(EIC_EXTINT_15_IRQn, 3);
    NVIC_EnableIRQ(EIC_EXTINT_15_IRQn);

    __DMB();
    __enable_irq();
}

void GCLK_init(void) {
    // --- Step 1: Configure Generator 0 ---
    // Select source (e.g., 0 = XOSC or GCLK source 0), no division
    GCLK_REGS->GCLK_GENCTRL[0] |= GCLK_GENCTRL_SRC(6)       // Choose source 0 (e.g., XOSC / OSC16M)
                               | GCLK_GENCTRL_IDC_Msk       // Improve duty cycle
                               | GCLK_GENCTRL_GENEN_Msk;    // Enable generator

    // Wait for synchronization
    while (GCLK_REGS->GCLK_SYNCBUSY & GCLK_SYNCBUSY_GENCTRL_GCLK0);

    // --- Step 2: Enable Peripheral Channel 4 (EIC) using Generator 0 ---
    GCLK_REGS->GCLK_PCHCTRL[4] |= GCLK_PCHCTRL_GEN(0)     // Use generator 0
                               | GCLK_PCHCTRL_CHEN_Msk; // Enable channel

    // Wait until channel is enabled
    while (!(GCLK_REGS->GCLK_PCHCTRL[4] & GCLK_PCHCTRL_CHEN_Msk));
}

void EIC_init(){
    EIC_REGS->EIC_CONFIG[1] |= EIC_CONFIG_FILTEN7_Msk
                            |  EIC_CONFIG_SENSE7_FALL;

    EIC_REGS->EIC_DEBOUNCEN |= (1<<15);
    EIC_REGS->EIC_CTRLA |= EIC_CTRLA_ENABLE_Msk;
}

void pin_init(){
    PORT_REGS->GROUP[0].PORT_PINCFG[15] |= PORT_PINCFG_PULLEN_Msk
                                        |  PORT_PINCFG_PMUXEN_Msk
                                        |  PORT_PINCFG_INEN_Msk;

    PORT_REGS->GROUP[0].PORT_DIR |= (1<<14);
}

void EIC_EXTINT_15_Handler(){
    PORT_REGS->GROUP[0].PORT_OUTTGL |= (1<<14);
}

int main(){
    pin_init();
    GCLK_init();
    EIC_init();
    nvic_init();

    while(1);

    return 0;
}
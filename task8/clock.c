/**
 * @file clock.c
 * @author vikingur
 * @date 2025-09-10
 * @brief clock i guess
 */
#include <same51j20a.h>
#include <stdint.h>

static void OSC32KCTRL_Initialize(void) {
    OSC32KCTRL_REGS->OSC32KCTRL_OSCULP32K &= ~(OSC32KCTRL_OSCULP32K_EN1K_Msk | OSC32KCTRL_OSCULP32K_EN32K_Msk);
    OSC32KCTRL_REGS->OSC32KCTRL_RTCCTRL = OSC32KCTRL_RTCCTRL_RTCSEL(1U);
    OSC32KCTRL_REGS->OSC32KCTRL_OSCULP32K |= (OSC32KCTRL_OSCULP32K_EN1K_Msk | OSC32KCTRL_OSCULP32K_EN32K_Msk);
    while((OSC32KCTRL_REGS->OSC32KCTRL_OSCULP32K &
    (OSC32KCTRL_OSCULP32K_EN1K_Msk | OSC32KCTRL_OSCULP32K_EN32K_Msk)) !=
    (OSC32KCTRL_OSCULP32K_EN1K_Msk | OSC32KCTRL_OSCULP32K_EN32K_Msk)){
        //wait
    }
}

static void DFLL_init(void){
    OSCCTRL_REGS->OSCCTRL_DFLLMUL |= OSCCTRL_DFLLMUL_CSTEP(16)
                                    |OSCCTRL_DFLLMUL_FSTEP(64)
                                    |OSCCTRL_DFLLMUL_MUL(1465);
    OSCCTRL_REGS->OSCCTRL_DFLLCTRLB |= OSCCTRL_DFLLCTRLB_MODE_Msk;
    while((OSCCTRL_REGS->OSCCTRL_STATUS & 
        OSCCTRL_STATUS_DFLLRDY_Msk) !=
        OSCCTRL_STATUS_DFLLRDY_Msk){
            //wait
    };
    uint8_t temp = OSCCTRL_REGS->OSCCTRL_DFLLVAL & OSCCTRL_DFLLVAL_COARSE_Msk;
}

static void FDPLL0_Initialize(void) {

    /****************** DPLL0 Initialization  *********************************/

    /* Configure DPLL    */
    OSCCTRL_REGS->DPLL[0].OSCCTRL_DPLLCTRLB = OSCCTRL_DPLLCTRLB_FILTER(0U) |
                                              OSCCTRL_DPLLCTRLB_LTIME(0x0U) |
                                              OSCCTRL_DPLLCTRLB_REFCLK(0U);

    OSCCTRL_REGS->DPLL[0].OSCCTRL_DPLLRATIO =
        OSCCTRL_DPLLRATIO_LDRFRAC(0U) | OSCCTRL_DPLLRATIO_LDR(96U);

    while ((OSCCTRL_REGS->DPLL[0].OSCCTRL_DPLLSYNCBUSY &
            OSCCTRL_DPLLSYNCBUSY_DPLLRATIO_Msk) ==
           OSCCTRL_DPLLSYNCBUSY_DPLLRATIO_Msk) {
        /* Waiting for the synchronization */
    }

    /* Enable DPLL */
    OSCCTRL_REGS->DPLL[0].OSCCTRL_DPLLCTRLA = OSCCTRL_DPLLCTRLA_ENABLE_Msk;

    while ((OSCCTRL_REGS->DPLL[0].OSCCTRL_DPLLSYNCBUSY &
            OSCCTRL_DPLLSYNCBUSY_ENABLE_Msk) ==
           OSCCTRL_DPLLSYNCBUSY_ENABLE_Msk) {
        /* Waiting for the DPLL enable synchronization */
    }

    while ((OSCCTRL_REGS->DPLL[0].OSCCTRL_DPLLSTATUS &
            (OSCCTRL_DPLLSTATUS_LOCK_Msk | OSCCTRL_DPLLSTATUS_CLKRDY_Msk)) !=
           (OSCCTRL_DPLLSTATUS_LOCK_Msk | OSCCTRL_DPLLSTATUS_CLKRDY_Msk)) {
        /* Waiting for the Ready state */
    }
}

void GCLK0_init(void){
    GCLK_REGS->GCLK_GENCTRL[0] |= GCLK_GENCTRL_SRC(7U)
                            | GCLK_GENCTRL_DIV(1)       
                            | GCLK_GENCTRL_GENEN_Msk;
    
    while ((GCLK_REGS->GCLK_SYNCBUSY & GCLK_SYNCBUSY_GENCTRL_GCLK0) ==
           GCLK_SYNCBUSY_GENCTRL_GCLK0) {
        /* wait for the Generator 0 synchronization */
    }

    GCLK_REGS->GCLK_PCHCTRL[35] |= GCLK_PCHCTRL_GEN(0)     // Use generator 0
                               |  GCLK_PCHCTRL_CHEN_Msk;  // Enable channel

    while ((GCLK_REGS->GCLK_PCHCTRL[35] & GCLK_PCHCTRL_CHEN_Msk) !=
           GCLK_PCHCTRL_CHEN_Msk) {
        /* Wait for synchronization */
    }
}

void GCLK1_init(void){
    GCLK_REGS->GCLK_GENCTRL[1] |= GCLK_GENCTRL_SRC(6U)
                            | GCLK_GENCTRL_DIV(48U)       
                            | GCLK_GENCTRL_GENEN_Msk;
    
    while ((GCLK_REGS->GCLK_SYNCBUSY & GCLK_SYNCBUSY_GENCTRL_GCLK1) ==
           GCLK_SYNCBUSY_GENCTRL_GCLK1) {
        /* wait for the Generator 0 synchronization */
    }

    GCLK_REGS->GCLK_PCHCTRL[1] |= GCLK_PCHCTRL_GEN(1) 
                               |  GCLK_PCHCTRL_CHEN_Msk;

    while ((GCLK_REGS->GCLK_PCHCTRL[1] & GCLK_PCHCTRL_CHEN_Msk) !=
           GCLK_PCHCTRL_CHEN_Msk) {
        // Wait for synchronization
    }
}

void GCLK2_init(void){
    GCLK_REGS->GCLK_GENCTRL[2] |= GCLK_GENCTRL_SRC(4)
                            | GCLK_GENCTRL_DIV(1)       
                            | GCLK_GENCTRL_GENEN_Msk;
    
    while ((GCLK_REGS->GCLK_SYNCBUSY & GCLK_SYNCBUSY_GENCTRL_GCLK2) ==
           GCLK_SYNCBUSY_GENCTRL_GCLK2) {
        /* wait for the Generator 0 synchronization */
    }

    GCLK_REGS->GCLK_PCHCTRL[0] |= GCLK_PCHCTRL_GEN(2) 
                               |  GCLK_PCHCTRL_CHEN_Msk;

    while ((GCLK_REGS->GCLK_PCHCTRL[0] & GCLK_PCHCTRL_CHEN_Msk) !=
           GCLK_PCHCTRL_CHEN_Msk) {
        // Wait for synchronization
    }
}

void clock_init(void){
    OSC32KCTRL_Initialize();
    GCLK2_init();
    DFLL_init();
    GCLK1_init();
    FDPLL0_Initialize();
    GCLK0_init();
}
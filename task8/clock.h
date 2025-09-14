/**
 * @file clock.h
 * @author vikingur
 * @date 2025-09-10
 * @brief clock i guess
 */
#include <same51j20a.h>
#pragma once

static void OSC32KCTRL_Initialize(void);

static void DFLL_init(void);

static void FDPLL0_Initialize(void);

void GCLK0_init(void);

void GCLK1_init(void);

void GCLK2_init(void);

void clock_init(void);
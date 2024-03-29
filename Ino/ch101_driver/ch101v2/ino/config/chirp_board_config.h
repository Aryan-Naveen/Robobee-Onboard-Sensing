/*
 * ________________________________________________________________________________________________________
 * Copyright (c) 2020 InvenSense Inc. All rights reserved.
 *
 * This software, related documentation and any modifications thereto (collectively “Software”) is subject
 * to InvenSense and its licensors' intellectual property rights under U.S. and international copyright
 * and other intellectual property rights laws.
 *
 * InvenSense and its licensors retain all intellectual property and proprietary rights in and to the Software
 * and any use, reproduction, disclosure or distribution of the Software without an express license agreement
 * from InvenSense is strictly prohibited.
 *
 * EXCEPT AS OTHERWISE PROVIDED IN A LICENSE AGREEMENT BETWEEN THE PARTIES, THE SOFTWARE IS
 * PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
 * EXCEPT AS OTHERWISE PROVIDED IN A LICENSE AGREEMENT BETWEEN THE PARTIES, IN NO EVENT SHALL
 * INVENSENSE BE LIABLE FOR ANY DIRECT, SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, OR ANY
 * DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
 * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
 * OF THE SOFTWARE.
 * ________________________________________________________________________________________________________
 */
/**
 * \file chirp_board_config.h
 *
 * This file defines required symbols used to build an application with the Chirp SonicLib
 * API and driver.  These symbols are used for static array allocations and counters in SonicLib 
 * (and often applications), and are based on the number of specific resources on the target board.
 *
 * Two symbols must be defined:
 *  CHIRP_MAX_NUM_SENSORS - the number of possible sensor devices (i.e. the number of sensor ports)
 *  CHIRP_NUM_I2C_BUSES - the number of I2C buses on the board that are used for those sensor ports
 *
 * This file must be in the C pre-processor include path when the application is built with SonicLib
 * and this board support package.
 */

#ifndef CHIRP_BOARD_CONFIG_H
#define CHIRP_BOARD_CONFIG_H

/* Settings for the Chirp SmartSonic board */
#define CHIRP_MAX_NUM_SENSORS 		1		// maximum possible number of sensor devices
#define CHIRP_NUM_I2C_BUSES 		1		// number of I2C buses used by sensors
#define CHBSP_RTC_CAL_PULSE_MS      100

#define CH_RST  8
#define CH_PROG 9
#define CH_INT  10

#define CHIRP_PIN_PROG   {CH_PROG}
#define CHIRP_PIN_IO     {CH_PROG}

#define	 CHIRP_SENSOR_FW_INIT_FUNC	ch101_gpr_init

#define CHIRP_FIRST_SENSOR_MODE		CH_MODE_TRIGGERED_TX_RX
#define CHIRP_OTHER_SENSOR_MODE		CH_MODE_TRIGGERED_RX_ONLY\

#define	MEASUREMENT_INTERVAL_MS (1000)

#define DATA_MAX_NUM_SAMPLES  (1)

/* Deactivate use of debug I2C interface */
#define USE_STD_I2C_FOR_IQ		(1)

#endif /* CHIRP_BOARD_CONFIG_H */
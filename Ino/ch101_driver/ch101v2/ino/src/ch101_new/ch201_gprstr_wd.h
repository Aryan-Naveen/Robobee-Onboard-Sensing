/*! \file ch201_gprstr_wd.h
 *
 * \brief Internal definitions for the Chirp CH201 GPR Static Target Rejection sensor firmware. (watchdog enabled)
 *
 * This file contains register offsets and other values for use with the CH201 GPR 
 * Static Target Rejection sensor firmware.  These values are subject to change without notice.
 *
 * You should not need to edit this file or call the driver functions directly.  Doing so
 * will reduce your ability to benefit from future enhancements and releases from Chirp.
 *
 */

/*
 * Copyright � 2016-2020, Chirp Microsystems.  All rights reserved.
 *
 * Chirp Microsystems CONFIDENTIAL
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL CHIRP MICROSYSTEMS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * You can contact the authors of this program by email at support@chirpmicro.com
 * or by mail at 2560 Ninth Street, Suite 220, Berkeley, CA 94710.
 */

#ifndef CH201_GPRSTR_WD_H_
#define CH201_GPRSTR_WD_H_

#include "ch201.h"
#include "soniclib.h"
#include <stdint.h>

/* GPR with STR firmware registers (watchdog enabled) */
#define CH201_GPRSTR_WD_REG_OPMODE 				0x01
#define CH201_GPRSTR_WD_REG_TICK_INTERVAL 		0x02
#define CH201_GPRSTR_WD_REG_LOW_GAIN_RXLEN    	0x04
#define CH201_GPRSTR_WD_REG_PERIOD 				0x05
#define CH201_GPRSTR_WD_REG_CAL_TRIG 		    0x06
#define CH201_GPRSTR_WD_REG_MAX_RANGE 			0x07
#define CH201_GPRSTR_WD_REG_INTCFG    	    	0x08
#define CH201_GPRSTR_WD_REG_CAL_RESULT 			0x0A
#define CH201_GPRSTR_WD_REG_THRESH_1 	        0x0C
#define CH201_GPRSTR_WD_REG_THRESH_0 	        0x0E
#define CH201_GPRSTR_WD_REG_TX_LENGTH         	0x10
#define CH201_GPRSTR_WD_REG_RX_HOLDOFF         	0x11
#define CH201_GPRSTR_WD_REG_STAT_RANGE			0x12
#define CH201_GPRSTR_WD_REG_STAT_COEFF			0x13
#define CH201_GPRSTR_WD_REG_READY 				0x14
#define CH201_GPRSTR_WD_REG_TOF_SF 				0x16
#define CH201_GPRSTR_WD_REG_TOF 			    0x18
#define CH201_GPRSTR_WD_REG_AMPLITUDE 			0x1A
#define CH201_GPRSTR_WD_REG_DATA 			    0x1C

#define CH201_GPRSTR_WD_MAX_SAMPLES				(290)

#define CH201_GPRSTR_WD_NUM_THRESHOLDS			(2)
#define CH201_GPRSTR_WD_STAT_COEFF_DEFAULT		(6)		// default value for stationary target coefficient
#define CH201_GPRSTR_WD_MIN_STR_SAMPLES			(14)	// min number of STR samples, to provide ringdown filter

extern const char *ch201_gprstr_wd_version;		// version string in fw .c file
extern const uint8_t ch201_gprstr_wd_fw[CH201_FW_SIZE];

uint16_t get_ch201_gprstr_wd_fw_ram_init_addr(void);
uint16_t get_ch201_gprstr_wd_fw_ram_init_size(void);

const unsigned char * get_ram_ch201_gprstr_wd_init_ptr(void);

uint8_t ch201_gprstr_wd_init(ch_dev_t *dev_ptr, ch_group_t *grp_ptr, uint8_t i2c_addr, uint8_t dev_num, uint8_t i2c_bus_index);

#endif

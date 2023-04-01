/*!
 * \file chbsp_dummy.c
 *
 * \brief Dummy implementations of optional board support package IO functions allowing 
 * platforms to selectively support only needed functionality.  These are placeholder
 * routines that will satisfy references from other code to avoid link errors, but they 
 * do not peform any actual operations.
 *
 * See chirp_bsp.h for descriptions of all board support package interfaces, including 
 * details on these optional functions.
 */

/*
 * Copyright � 2017-2019 Chirp Microsystems.  All rights reserved.
 */

#include <Arduino.h>
#include <Wire.h>

#include "chirp_bsp.h"
#include "soniclib.h"

#include "chirp_board_config.h"

ch_io_int_callback_t callback;
ch_group_t *gp;

void ch_isr () {
	(*callback) (gp, 0);
}

void chbsp_board_init(ch_group_t *grp_ptr) {
  Serial.println("Init board called");
	grp_ptr->num_ports = CHBSP_MAX_DEVICES; // DEFINE
	grp_ptr->num_i2c_buses = CHBSP_NUM_I2C_BUSES; // DEFINE
	grp_ptr->rtc_cal_pulse_ms = CHBSP_RTC_CAL_PULSE_MS; // DEFINE

	// init i2c
	chbsp_i2c_init ();

	// init serial interface
	Serial.begin (9600);

	// init pins
	chbsp_group_pin_init(grp_ptr);

  // save pointer
  gp = grp_ptr;
}

void chbsp_reset_assert (void) {
  Serial.println ("Reset asserted");
	digitalWrite (CH_RST, LOW);
}

void chbsp_reset_release (void) {
  Serial.println ("Reset released");
	digitalWrite (CH_RST, HIGH);
}

void chbsp_program_enable (ch_dev_t *dev_ptr) {
  Serial.println ("Prog asserted");
	digitalWrite (CH_PROG, HIGH);
}

void chbsp_program_disable (ch_dev_t *dev_ptr) {
  Serial.println ("Prog disabled");
	digitalWrite (CH_PROG, LOW);
}

void chbsp_group_set_io_dir_out (ch_group_t *grp_ptr) {
	pinMode (CH_INT, OUTPUT);
}

void chbsp_set_io_dir_out (ch_dev_t *dev_ptr) {
	pinMode (CH_INT, OUTPUT);
}

void chbsp_group_set_io_dir_in (ch_group_t *grp_ptr) {
	pinMode (CH_INT, INPUT);
}

void chbsp_set_io_dir_in (ch_dev_t *dev_ptr) {
	pinMode (CH_INT, INPUT);
}

void chbsp_group_pin_init (ch_group_t *grp_ptr) {
	pinMode (CH_RST /* RST */, OUTPUT);
	pinMode (CH_PROG /* PROG */, OUTPUT);
	pinMode (CH_INT /* INT */, OUTPUT);
}

void chbsp_group_io_clear (ch_group_t *grp_ptr) {
	digitalWrite (CH_INT, LOW);
}

void chbsp_io_clear (ch_dev_t *dev_ptr) {
	digitalWrite (CH_INT, LOW);
}

void chbsp_group_io_set (ch_group_t *grp_ptr) {
	digitalWrite (CH_INT, HIGH);
}

void chbsp_io_set (ch_dev_t *dev_ptr) {
	digitalWrite (CH_INT, HIGH);
}

void chbsp_group_io_interrupt_enable (ch_group_t *grp_ptr) {
	// Interrupt
	attachInterrupt (digitalPinToInterrupt (CH_INT), ch_isr, RISING);
}

void chbsp_io_interrupt_enable (ch_dev_t *dev_ptr) {
	// Interrupt
	attachInterrupt (digitalPinToInterrupt (CH_INT), ch_isr, RISING);
}

void chbsp_group_io_interrupt_disable (ch_group_t *grp_ptr) {
	// Disable interrupt
	detachInterrupt (digitalPinToInterrupt (CH_INT));
}

void chbsp_io_interrupt_disable (ch_dev_t *dev_ptr) {
	// Disable interrupt
	detachInterrupt (digitalPinToInterrupt (CH_INT));
}

void chbsp_io_callback_set (ch_io_int_callback_t callback_func_ptr) {
	// Set callback
	callback = callback_func_ptr;
}

void chbsp_delay_us (uint32_t us) {
	delayMicroseconds (us);
}

void chbsp_delay_ms (uint32_t ms) {
	delay (ms);
}

int chbsp_i2c_init (void) {
  Serial.println ("I2c init");
	Wire.begin ();
  Wire.setClock(5000);
	return 0;
}

uint8_t chbsp_i2c_get_info(ch_group_t *grp_ptr, uint8_t dev_num, ch_i2c_info_t *info_ptr) {
	info_ptr->address = 0x45;
	info_ptr->bus_num = 0;
	info_ptr->drv_flags = 0; // FIX
	return 0;
}

int chbsp_i2c_write (ch_dev_t *dev_ptr, uint8_t *data, uint16_t num_bytes) {
  Serial.println ("I2c write");
	Wire.beginTransmission (ch_get_i2c_address (dev_ptr));
	for (int i = 0; i < num_bytes; ++i) {
		Wire.write (data[i]);
	}
	Wire.endTransmission();
	return 0;
}

int chbsp_i2c_mem_write (ch_dev_t *dev_ptr, uint16_t mem_addr, uint8_t *data, uint16_t num_bytes) {
  Serial.println ("I2c mem write");
	Wire.beginTransmission (ch_get_i2c_address (dev_ptr));
	// Send header
	Wire.write (mem_addr & 0xFF);
	Wire.write (num_bytes & 0xFF);
	// Write data
	for (int i = 0; i < (num_bytes & 0xFF); ++i) {
		Wire.write (data[i]);
	}
	Wire.endTransmission ();
	return 0;
}

int chbsp_i2c_read (ch_dev_t *dev_ptr, uint8_t *data, uint16_t num_bytes) {
  Serial.println ("I2c read");
	Wire.requestFrom (ch_get_i2c_address (dev_ptr), num_bytes);
	int i = 0;
	while (Wire.available () > 0) {
		data[i] = Wire.read ();
	}
	return 0;
}

int chbsp_i2c_mem_read (ch_dev_t *dev_ptr, uint16_t mem_addr, uint8_t *data, uint16_t num_bytes) {
  Serial.println ("I2c mem read");
	Wire.beginTransmission (ch_get_i2c_address (dev_ptr));
	Wire.write (mem_addr & 0xFF);
	Wire.endTransmission ();

	Wire.requestFrom (ch_get_i2c_address (dev_ptr), num_bytes);
	chbsp_i2c_read (dev_ptr, data, num_bytes);
	return 0;
}

void chbsp_i2c_reset (ch_dev_t *dev_ptr) {
	// FIX (Or do nothing?)
  Serial.println ("I2c reset");
}

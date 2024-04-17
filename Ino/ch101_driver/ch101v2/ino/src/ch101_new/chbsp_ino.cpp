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
  // Serial.println("Init board called");
	grp_ptr->num_ports = CHBSP_MAX_DEVICES; // DEFINE
	grp_ptr->num_i2c_buses = CHBSP_NUM_I2C_BUSES; // DEFINE
	grp_ptr->rtc_cal_pulse_ms = CHBSP_RTC_CAL_PULSE_MS; // DEFINE

	// init i2c
	chbsp_i2c_init ();

	// init serial interface
	// Serial.begin (9600);

	// init pins
	chbsp_group_pin_init(grp_ptr);

  // save pointer
  gp = grp_ptr;
}

void chbsp_reset_assert (void) {
  // Serial.println ("Reset asserted");
	digitalWrite (CH_RST, LOW);
}

void chbsp_reset_release (void) {
  // Serial.println ("Reset released");
	digitalWrite (CH_RST, HIGH);
}

void chbsp_program_enable (ch_dev_t *dev_ptr) {
  // Serial.println ("Prog asserted");
	digitalWrite (CH_PROG, HIGH);
}

void chbsp_program_disable (ch_dev_t *dev_ptr) {
  // Serial.println ("Prog disabled");
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
  chbsp_reset_assert ();
	pinMode (CH_PROG /* PROG */, OUTPUT);
  chbsp_program_enable (nullptr);
	pinMode (CH_INT /* INT */, OUTPUT);
  chbsp_group_io_clear (grp_ptr);
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
	// attachInterrupt (digitalPinToInterrupt (CH_INT), ch_isr, RISING);
}

void chbsp_io_interrupt_enable (ch_dev_t *dev_ptr) {
	// Interrupt
	// attachInterrupt (digitalPinToInterrupt (CH_INT), ch_isr, RISING);
}

void chbsp_group_io_interrupt_disable (ch_group_t *grp_ptr) {
	// Disable interrupt
	// detachInterrupt (digitalPinToInterrupt (CH_INT));
}

void chbsp_io_interrupt_disable (ch_dev_t *dev_ptr) {
	// Disable interrupt
	// detachInterrupt (digitalPinToInterrupt (CH_INT));
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
  // Serial.println ("I2c init");
	Wire.begin ();
  // Wire.setClock(1 /* 10kHz */);
	return 0;
}

uint8_t chbsp_i2c_get_info(ch_group_t *grp_ptr, uint8_t dev_num, ch_i2c_info_t *info_ptr) {
	info_ptr->address = 0x29; // Hand picked i.e. He only responded to 41 and I am not sure why :(
	info_ptr->bus_num = 0;
	info_ptr->drv_flags = 0; // FIX
	return 0;
}

void chbsp_print_str(char *str) {
  Serial.println (str);
}

int writeNo = 0;
int offset = 0;
char buffer[8192];
int chbsp_i2c_write (ch_dev_t *dev_ptr, uint8_t *data, uint16_t num_bytes) {
  // Serial.print ("I2c writing bytes: ");
  // Serial.println (num_bytes);
  /* 
  offset = sprintf (buffer, "%3d,%X,%d,",writeNo,ch_get_i2c_address (dev_ptr),num_bytes);
  for (int i = 0; i < num_bytes; ++i) {
    offset = offset + sprintf (buffer + offset, "%2X,", data[i]);
  }
  writeNo = writeNo + 1;
  Serial.println (buffer);
  */
  
	Wire.beginTransmission (ch_get_i2c_address (dev_ptr));
	for (int i = 0; i < num_bytes; ++i) {
		Wire.write (data[i]);
	}
  int error = Wire.endTransmission();
  if (error != 0) {
    Serial.println ("Transmission Failed");
    Serial.println (error);
    delay (1000);
  }
  return error;
}

int chbsp_i2c_mem_write (ch_dev_t *dev_ptr, uint16_t mem_addr, uint8_t *data, uint16_t num_bytes) {
  // Serial.println ("I2c mem write");
  // Serial.print (num_bytes);
  // Serial.println (" bytes");
	Wire.beginTransmission (ch_get_i2c_address (dev_ptr));
	// Send header
	Wire.write (mem_addr & 0xFF);
	Wire.write (num_bytes & 0xFF);
	// Write data
	for (int i = 0; i < (num_bytes & 0xFF); ++i) {
		Wire.write (data[i]);
	}
	int error = Wire.endTransmission();
  if (error != 0) {
    Serial.println ("Mem Transmission Failed");
    Serial.println (error);
    delay (1000);
  }
  // Serial.println ("What happened here??");
  return error;
}

int chbsp_i2c_read (ch_dev_t *dev_ptr, uint8_t *data, uint16_t num_bytes) {
  // Serial.println ("I2c read");
	int nRead = Wire.requestFrom (ch_get_i2c_address (dev_ptr), num_bytes);
	int i = 0;
	while (Wire.available () > 0) {
		data[i] = Wire.read ();
    i = i + 1;
	}
  if (nRead != num_bytes) {
    Serial.println ("Read Failed");
    Serial.println (nRead);
    Serial.println (num_bytes);
    delay (1000);
  }
	return nRead != num_bytes;
}

int chbsp_i2c_mem_read (ch_dev_t *dev_ptr, uint16_t mem_addr, uint8_t *data, uint16_t num_bytes) {
  // Serial.println ("I2c mem read");
  // Serial.print ("I2C Address: ");
  // Serial.println (ch_get_i2c_address (dev_ptr));
  // Serial.print ("Mem Address: ");
  // Serial.println (mem_addr);
  // Serial.println ("Lets see what happens");
  // delay (5000);
	Wire.beginTransmission (ch_get_i2c_address (dev_ptr));
	Wire.write (mem_addr);
  int error = Wire.endTransmission(false);
  if (error != 0) {
    Serial.println ("Mem Read Failed");
    // Serial.println (error);
    // Serial.print (ch_get_i2c_address (dev_ptr));
    // Serial.print (" ");
    // Serial.println (mem_addr);    
    // delay (1000);
    // Test all possible addresses
    // Serial.println ("Lets see who responds");
    // for (int i = 0; i < 128; ++i) {
    //   Wire.beginTransmission (i);
    //   error = Wire.endTransmission ();
    //   if (error == 0 && i != ch_get_i2c_address (dev_ptr)) {
    //     Serial.print ("This loser responded: ");
    //     Serial.println (i);
    //     while (1);
    //   }
    // }
    // Serial.println ("All quiet on the western front");
    // while (1);

    // Test what byte does it want
    // Serial.println ("Lets see what it wants");
    // for (int i = 0; i < 256; ++i) {
    //   Wire.beginTransmission (ch_get_i2c_address (dev_ptr));
    //   Wire.write (i);
    //   error = Wire.endTransmission ();
    //   if (error == 0) {
    //     Serial.print ("This loser responded to: ");
    //     Serial.println (i);
    //   } else {
    //     Serial.print ("Error produced: ");
    //     Serial.println (error);
    //     Serial.print ("On Data: ");
    //     Serial.println (i);
    //   }
    // }
    // Serial.println ("All done");
    // while (1);
    return error;
  }
	return chbsp_i2c_read (dev_ptr, data, num_bytes);
}

void chbsp_i2c_reset (ch_dev_t *dev_ptr) {
	// FIX (Or do nothing?)
  Serial.println ("I2C reset");
}

uint32_t chbsp_timestamp_ms() {
  return millis();
}

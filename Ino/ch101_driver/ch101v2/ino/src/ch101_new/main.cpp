#include <Arduino.h>

#include "chirp_board_config.h"
#include "chirp_bsp.h"
#include "soniclib.h"

#include "main.h"

ch_group_t grp;
ch_dev_t dev;
ch_config_t dev_config;

struct {
  uint32_t range;
  uint32_t amplitude;
} data;

int WAIT_TIME = 2500;

int ch_trigger_and_read (void) {
  ch_trigger (&dev);
  chbsp_set_io_dir_in (&dev);

  // Wait on interrupt
  int start_time = millis ();
  while (digitalRead (CH_INT) != HIGH) {
    // Wait
    if (millis() - start_time > WAIT_TIME) {
      // Failed
      // return 1;
      Serial.println ("No response...");
      break;
    }
  }

  chbsp_set_io_dir_out (&dev);
  chbsp_io_clear (&dev);
  chbsp_set_io_dir_in (&dev);

  // // Wait predetermined time to let ic get measurement
  // int start_time = millis ();
  // while (millis() - start_time < WAIT_TIME) {
  //   // delayMicroseconds (100);
  // }

  // Pin is High Pull it to 0 and return to input
  // Serial.println ("Released line");
  // delay (10000);
  // chbsp_group_set_io_dir_in(&grp);

  data.range = ch_get_range (&dev, CH_RANGE_ECHO_ONE_WAY);
  if (data.range == CH_NO_TARGET || data.range == 0) {
    return 1;
  } else {
    data.amplitude = ch_get_amplitude(&dev);
  }
  // while (1);
  return 0;
}

void ch_main (void) {
  delay (10000);
  ch_group_t *grp_ptr = &grp;
  chbsp_board_init (grp_ptr);

  ch_dev_t *dev_ptr = &dev;
  auto error = ch_init (dev_ptr, grp_ptr, 0, CHIRP_SENSOR_FW_INIT_FUNC);

  error = ch_group_start (grp_ptr);

  if (!error) {
    Serial.println ("Lets go baby!!");
    // Configure sensor
    if (ch_sensor_is_connected(dev_ptr)) {
      dev_config.mode = CHIRP_FIRST_SENSOR_MODE;

      /* Init config structure with values from app_config.h */
      dev_config.max_range       = CHIRP_SENSOR_MAX_RANGE_MM;
      dev_config.static_range    = CHIRP_SENSOR_STATIC_RANGE;
      dev_config.thresh_ptr = 0;							
      error = ch_set_config(dev_ptr, &dev_config);

      /* Read back and display config settings */
      if (error) {
        Serial.println("Device error during ch_set_config()");
        while (1);
      }
    }

    // Do some measurements!!
    while (1) {
      error = ch_trigger_and_read ();
      if (error) {
        Serial.println ("Something went wrong");
        // while (1);
      }
      Serial.print ("Range output: ");
      Serial.println (data.range);
      Serial.print ("Amplitude output: ");
      Serial.println (data.amplitude);
      delay (500);
    }
  }
}



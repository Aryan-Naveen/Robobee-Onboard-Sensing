#include "vl6180_i2c.h"

#include <Arduino.h>
#include <Wire.h>

int  VL6180_I2CWrite(VL6180Dev_t dev, uint8_t  *buff, uint8_t len) {
  Wire.beginTransmission (dev->I2CDevAddr);
  for (int i = 0; i < len; ++i) {
    Wire.write (buff[i]);
  }
  int Status = Wire.endTransmission();
  if (Status) {
    Serial.println ("Something Went Wrong");
    Serial.println (Status);
  }
  return Status;
}

int VL6180_I2CRead(VL6180Dev_t dev, uint8_t *buff, uint8_t len) {
  uint8_t Num = Wire.requestFrom (dev->I2CDevAddr, len);
  for (int i = 0; i < Num; ++i) {
    buff[i] = Wire.read ();
  }
  if (Num != len) {
    Serial.println ("No Response From Sensor");
  }
  return Num != len;
}
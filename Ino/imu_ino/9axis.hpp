#pragma once

#include <stdint.h>

class I2CDevice {
public:
  I2CDevice (uint8_t address);
  bool ping ();
  bool write (const uint8_t *data, uint8_t len, bool stop = false);
  bool read (uint8_t *data, uint8_t len);
  bool writeRegister (uint8_t address, const uint8_t *data, uint8_t len, bool stop = false);
  bool readRegister (uint8_t address, uint8_t *data, uint8_t len);
  
  const uint8_t device_address;
};

class NineAxis : public I2CDevice {
public:
  NineAxis (bool ad0);
  static const uint8_t SLAVE_ADDR = 0x68;
  
  // Important Registers
  // UBANK0
  static const uint8_t PWR_MGMT_1 = 0x06;
  static const uint8_t PWR_MGMT_2 = 0x07;

  static const uint8_t ACCEL_XOUT_H = 0x2D;
  static const uint8_t ACCEL_XOUT_L = 0x2E;
  static const uint8_t ACCEL_YOUT_H = 0x2F;
  static const uint8_t ACCEL_YOUT_L = 0x30;
  static const uint8_t ACCEL_ZOUT_H = 0x31;
  static const uint8_t ACCEL_ZOUT_L = 0x32;

  static const uint8_t GYRO_XOUT_H = 0x33;
  static const uint8_t GYRO_XOUT_L = 0x34;
  static const uint8_t GYRO_YOUT_H = 0x35;
  static const uint8_t GYRO_YOUT_L = 0x36;
  static const uint8_t GYRO_ZOUT_H = 0x37;
  static const uint8_t GYRO_ZOUT_L = 0x38;

  static const uint8_t DATA_RDY_STATUS = 0x74;
  static const uint8_t USER_REG_BANK_SEL = 0x7F;

  // UBANK1
};
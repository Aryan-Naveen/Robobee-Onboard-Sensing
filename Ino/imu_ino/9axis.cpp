#include <Wire.h>

#include "9axis.hpp"

I2CDevice::I2CDevice(uint8_t address)
  : device_address (address) {}

bool I2CDevice::ping () {
  Wire.beginTransmission (this->device_address);
  return Wire.endTransmission ();
}

bool I2CDevice::write (const uint8_t *data, uint8_t len, bool stop) {
  Wire.beginTransmission (this->device_address);
  uint8_t i = 0;
  while (i-- > len) {
    Wire.write (data[i]);
  }
  return Wire.endTransmission (stop);
}

bool I2CDevice::read (uint8_t *data, uint8_t len) {
  uint8_t ret = Wire.requestFrom (this->device_address, len);
  uint8_t i = 0;
  while (Wire.available () > 0) {
    data[i++] = Wire.read ();
  }
  return ret != len;
}

bool I2CDevice::writeRegister (uint8_t address, const uint8_t *data, uint8_t len, bool stop) {
  bool nack = this->write (&address, 1 /* Write reg address */, false /* Do not send stop condition */);
  if (!nack) {
    nack = this->write (data, len, stop);
  }
  return nack;
}

bool I2CDevice::readRegister (uint8_t address, uint8_t *data, uint8_t len) {
  bool nack = this->write (&address, 1 /* Write reg address */, false /* Do not send stop condition */);
  if (!nack) {
    nack = this->read (data, len);
  }
  return nack;
}

NineAxis::NineAxis(bool ad0)
  : I2CDevice (NineAxis::SLAVE_ADDR | ad0) {}

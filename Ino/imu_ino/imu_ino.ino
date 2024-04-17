#include <Wire.h>

#include "9axis.hpp"

#define AD0 8

NineAxis IMU (false /* AD0 is 0 */);

void setup() {
  pinMode (AD0, OUTPUT);
  digitalWrite (AD0, LOW);
  Wire.begin ();
  Serial.begin (9600);
}

void loop() {
  // Ping device
  bool ret = IMU.ping ();
  if (ret) {
    Serial.println ("Ping Failed");
  } else {
    Serial.println ("Ping Success");
  }
  delay (5000);
}

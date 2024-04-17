#include <Arduino.h>
#include <Wire.h>

#include "vl6180_api.h"
#include "vl6180_types.h"

struct MyVL6180Dev_t devObject;

VL6180Dev_t myDev = &devObject;
VL6180_RangeData_t Range;

#define CHIPENPIN (32)

void MyDev_Init (VL6180Dev_t myDev) {
  Serial.println ("Setting I2c Address");
  delay (2500);
  myDev->I2CDevAddr = 0x29;
  Serial.println("That worked...");
  delay (2500);
}

void MyDev_SetChipEnable (VL6180Dev_t myDev) {
  Serial.println("Setting Chip Enable");
  pinMode (CHIPENPIN, OUTPUT);
  digitalWrite (CHIPENPIN, HIGH);
  Serial.println("Chip Enable Set");
}

void MyDev_uSleep (uint32_t us) {
  delayMicroseconds (us);
}

void MyDev_ShowRange (VL6180Dev_t myDev, int32_t rangemm) {
  Serial.print ("Read range: ");
  Serial.println (rangemm);
}

void MyDev_ShowError (VL6180Dev_t myDev, uint32_t error) {
  Serial.print ("Got error code: ");
  Serial.println (error);
}

bool MyDev_UserSayStop (VL6180Dev_t myDev) {
  return false;
}

void Sample_SimpleRanging(void) {
    Serial.println ("Initializing Device");
    VL6180_InitData(myDev);
    Serial.println ("Preparing Device");
    VL6180_Prepare(myDev);
    do {
        Serial.println ("Trying Measurement...");
        int Status = VL6180_RangePollMeasurement(myDev, &Range);
        if (!Status) {
          if (Range.errorStatus == 0)
              MyDev_ShowRange(myDev, Range.range_mm);
          else
              MyDev_ShowError(myDev, Range.errorStatus);
        } else {
          Serial.println ("Something Went Wrong");
          Serial.println (Status);
        }
        delay (1000);
    } while (!MyDev_UserSayStop(myDev));
}

void setup() {
  Wire.begin ();
  Serial.begin (9600);
  Serial.println ("Initial Setup Done...\n=====");
  delay (2500);

  MyDev_Init(myDev);
  MyDev_SetChipEnable(myDev);
  MyDev_uSleep(1000);
  Serial.print ("Ready To Get Started...\n");
  delay(2500);
}

void loop() {
  Serial.println ("Getting Started...");
  delay (2500);
  Sample_SimpleRanging ();
}

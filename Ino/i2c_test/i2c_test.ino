#include <Wire.h>

#define RESET_N 8
#define PROG 9

void setup () {
  // Set up GPIO
  pinMode (RESET_N, OUTPUT);
  digitalWrite (RESET_N, LOW);
  pinMode (PROG, OUTPUT);
  digitalWrite (PROG, LOW);

  Wire.begin ();
  Wire.setClock(1000 /* 40 kHz*/);
  // Wire.setWireTimeout (5000 /* us */, false /* resetOnTimeout */);
  // MCUCR |= (1<<PUD);
  Serial.begin (9600);
}

void loop () {
  // Enable
  digitalWrite (RESET_N, HIGH);
  delay (50);
  digitalWrite (PROG, HIGH);
  delay (50);

  // Test bus
  Wire.beginTransmission (0x45);
  Wire.write (0);
  // Wire.write (2);
  Wire.endTransmission ();

  Wire.requestFrom(0x45, 2);
  while (Wire.available()) {
    char c = Wire.read();
    Serial.println(int(c));
  }

  digitalWrite (PROG, LOW);
  digitalWrite (RESET_N, LOW);

  Serial.println("Completed Cycle\n\n");
  delay (1000 /* ms */);
}

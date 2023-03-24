This test scripts sets up I2C with the connections
using the CH101 IC:

Pin 11: Resetn
Pin 12: Prog

Sets both resetn and prog pins low.
Then asserts both pins.
Writes 0x0 to address 0x45 (CH101 Prog Address)
Then reads back 2 bytes and prints them
  (should be 0xA = 10 and 0x2 = 2)

Ensures that sensor is on and working.

Sequence explained in uploaded driver template code
  File: 

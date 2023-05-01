/* Sweep
 by BARRAGAN <http://barraganstudio.com>
 This example code is in the public domain.

 modified 8 Nov 2013
 by Scott Fitzgerald
 http://www.arduino.cc/en/Tutorial/Sweep
*/

#include <Servo.h>

Servo myservo;  // create servo object to control a servo
// twelve servo objects can be created on most boards

int pos = 45;    // variable to store the servo position
int num_times = 5;
bool should_run = true;

void setup() {
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object

}

void loop() {
  if(should_run){
    for(int n = 0; n < num_times; n++){
      for (pos = 45; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
        myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);
      }
      for (pos = 0; pos <= 45; pos += 1) { // goes from 0 degrees to 180 degrees
        // in steps of 1 degree
        myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);                       // waits 15ms for the servo to reach the position
      }
    } 
  }
  should_run=false;
  
}

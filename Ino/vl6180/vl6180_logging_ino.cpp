#include <Arduino.h>

#include "vl6180_platform.h"

void OnErrLog (const char *msg) {
  Serial.println (msg);
}

void DISP_ExecLoopBody(void) {
  // Do nothing...
}
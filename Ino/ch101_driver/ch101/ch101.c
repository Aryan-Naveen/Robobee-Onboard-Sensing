// File: ch101.c
// Lightweight ch101 driver api calls

// Pins
const int ch_prog_pin = 12;
const int ch_reset_pin = 13; 

// Register Addresses
const unsigned char ch_i2c_prog = 0x45;
const unsigned char ch_prog_reg_addr = 0; // FIX
const unsigned char ch_prog_reg_data = 0; // FIX
const unsigned char ch_prog_reg_ctl = 0; // FIX
const unsigned char ch_prog_reg_cnt = 0; // FIX
const unsigned char ch_prog_reg_cpu = 0; // FIX
const unsigned char ch_prog_reg_ping = 0; // FIX

// Firmware
const unsigned char burst_hdr[] = {0xC4, 0x0B};

const unsigned char idle_reg[] = {0xFF, 0xFC};
const unsigned char idle_loop[] = {0x40, 0x03, 0xFF, 0xFC};

const unsigned char reset_asic[] = {0x00, 0x40};
const unsigned char halt_asic[] = {0x00, 0x11};

const unsigned char wdt_reg[] = {0x01, 0x20};
const unsigned char wdt_stop[] = {0x5a, 0x80};

const unsigned char ram_addr_gpr[] = {}; // FIX
const unsigned char ram_size_gpr[] = {}; // FIX 
const unsigned char ram_init[] = {} // FIX;

// Inits pins / structures / etc
void ch_init () {
  pinMode (ch_prog_pin, OUTPUT);
  pinMode (ch_reset_pin, OUTPUT);
  Wire.begin ();
}

// Assert and reset prog line
void assert_prog_pin () {
  digitalWrite (ch_prog_pin, HIGH);
}
void release_prog_pin () {
  digitalWrite (ch_prog_pin, LOW);
}

// Assert and reset reset lines
void assert_reset_pin () {
  digitalWrite (ch_reset_pin, LOW);
}
void release_reset_pin () {
  digitalWrite (ch_reset_pin, HIGH);
}

void i2c_write (unsigned char addr, const unsigned char *msg, int len) {
  Wire.beginTransmission (addr);
  for (int i = 0; i < len; i = i + 1) {
    Wire.write (msg[i] & 0xFF);
  }
  Wire.endTransmission ();
}

void i2c_read (unsigned char addr, unsigned char *data_out, int len) {
  int i = 0;
  Wire.requestFrom (addr, len);
  while (Wire.available () > 0) {
    data_out[i++] = Wire.read ();
  }
}

void ch_prog_i2c_write (const unsigned char *data_out, int len) {
  i2c_write (ch_prog, data, len);
}

void ch_prog_i2c_read () {
  i2c_read (ch_prog, data_out, len);
}

void ch_prog_write (unsigned char reg_addr, const unsigned char data[2]) {
  // Set reg write bit 
  reg_addr |= 0x80;
  const unsigned char msg[] = {reg_addr, data[0], data[1]};
  ch_prog_i2c_write (msg, 3 /* Length msg */); // FIX
}

void ch_prog_read (unsigned char reg_addr, unsigned char* data_out) {
  unsigned char data[2];
  unsigned char msg[] = {0x7F & reg_addr};
  ch_prog_i2c_write (msg, 1 /* Length msg */);
  ch_prog_i2c_read (data, 2) // FIX
  data_out[0] = data[0];
  data_out[1] = data[1];
}

void ch_prog_mem_write (const unsigned char reg_addr[2], const unsigned char* msg, int len) {
  // Write prog reg
  ch_prog_write (ch_prog_reg_addr, reg_addr);
  if (len == 1 || (len == 2 && !(reg_addr[1] & 1))) {
    unsigned char data[] = {msg[0], msg[1]};
    ch_prog_write (ch_prog_reg_data, data);

    unsigned char opcode[] = {(0x03 | ((len == 1) ? 0x08 : 0x00))};
    ch_prog_write (ch_prog_reg_ctl, opcode);
  } else {
    ch_prog_write (ch_prog_reg_cnt, len - 1);
    ch_prog_i2c_write (burst_hdr, 2 /* Length burst_hdr */);\
    ch_prog_i2c_write (msg, len);
  }
}

// Reset and halt
void ch_reset_and_halt () {
  ch_prog_write (ch_prog_reg_cpu, reset_asic);
  ch_prog_reset (ch_prog_reg_cpu, halt_asic);
}

void ch_set_sensor_idle () {
  ch_prog_mem_write (idle_reg, idle_loop, 4 /* Length idle_loop*/);
  ch_reset_and_halt ();
  ch_prog_mem_write (wdt_reg, wdt_stop, 2 /* Length wdt_stop */);
}

void ch_prog_ping () {
  unsigned char data_out[2];
  ch_reset_and_halt ();
  ch_prog_read (ch_prog_reg_ping, data_out);
  // Read Out?
}

void get

void ch_init_ram () {
}

void ch_write_firmware () {

}

void ch_program () {
  assert_prog_pin ();
  ch_prog_pring ();

}

void ch_wait_for_lock () {
}

void ch_measure_rtc () {

}

// Starts sensor 
void ch_sensor_start () {
  assert_reset_pin ();
  assert_prog_pin ();
  delay (1);
  release_reset_pin ();

  ch_set_sensor_idle ();
  release_prog_pin ();
}


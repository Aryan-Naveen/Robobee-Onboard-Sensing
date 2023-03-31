#include "chirp_bsp.h"
#include "soniclib.h"

#include "main.h"

ch_group_t grp;
ch_dev_t dev;

void ch_main (void) {
  ch_group_t *grp_ptr = &grp;
  chbsp_board_init (grp_ptr);

  ch_dev_t *dev_ptr = &dev;
  ch_init (dev_ptr, grp_ptr, 0, CHIRP_SENSOR_FW_INIT_FUNC);

  ch_group_start (grp_ptr);
}

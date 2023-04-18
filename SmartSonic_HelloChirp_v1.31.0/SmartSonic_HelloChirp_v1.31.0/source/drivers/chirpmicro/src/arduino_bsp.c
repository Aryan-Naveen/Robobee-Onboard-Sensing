/*!
 * \file chbsp_dummy.c
 *
 * \brief Dummy implementations of optional board support package IO functions allowing
 * platforms to selectively support only needed functionality.  These are placeholder
 * routines that will satisfy references from other code to avoid link errors, but they
 * do not peform any actual operations.
 *
 * See chirp_bsp.h for descriptions of all board support package interfaces, including
 * details on these optional functions.
 */

/*
 * Copyright � 2017-2019 Chirp Microsystems.  All rights reserved.
 */

#include "chirp_bsp.h"

void chbsp_board_init(ch_group_t *grp_ptr){
  
}

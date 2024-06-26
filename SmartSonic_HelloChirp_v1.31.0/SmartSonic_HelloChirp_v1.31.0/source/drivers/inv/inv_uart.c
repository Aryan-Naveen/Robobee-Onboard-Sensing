/*
 * ________________________________________________________________________________________________________
 * Copyright (c) 2020 InvenSense Inc. All rights reserved.
 *
 * This software, related documentation and any modifications thereto (collectively “Software”) is subject
 * to InvenSense and its licensors' intellectual property rights under U.S. and international copyright
 * and other intellectual property rights laws.
 *
 * InvenSense and its licensors retain all intellectual property and proprietary rights in and to the Software
 * and any use, reproduction, disclosure or distribution of the Software without an express license agreement
 * from InvenSense is strictly prohibited.
 *
 * EXCEPT AS OTHERWISE PROVIDED IN A LICENSE AGREEMENT BETWEEN THE PARTIES, THE SOFTWARE IS
 * PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
 * EXCEPT AS OTHERWISE PROVIDED IN A LICENSE AGREEMENT BETWEEN THE PARTIES, IN NO EVENT SHALL
 * INVENSENSE BE LIABLE FOR ANY DIRECT, SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, OR ANY
 * DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
 * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
 * OF THE SOFTWARE.
 * ________________________________________________________________________________________________________
 */
#include <asf.h>
#include "inv_uart.h"
#include "inv_i2c.h"
#include "stdio_serial.h"

void uart_init(uint8_t rts_cts, uint8_t *uart_rx_buffer)
{
	const usart_serial_options_t uart_serial_options = {
		.baudrate = CONF_UART_BAUDRATE,
		.charlength = CONF_UART_CHAR_LENGTH,
		.paritytype = CONF_UART_PARITY,
		.stopbits = CONF_UART_STOP_BITS,
	};

	/* Configure console UART. */
	sysclk_enable_peripheral_clock(ID_FLEXCOM0);
	usart_serial_init(USART0, (usart_serial_options_t *)&uart_serial_options);

	uint32_t mode = (0 == rts_cts) ? US_MR_CHMODE_NORMAL : US_MR_USART_MODE_HW_HANDSHAKING;
	USART0->US_MR = (USART0->US_MR & ~US_MR_USART_MODE_Msk) | mode;

	/* Prepare for reception */
	uart_dma_getc(uart_rx_buffer, 1);

	usart_enable_rx(USART0);
	usart_enable_tx(USART0);

	/* Enable UART IRQ.
	 * Note that this UART INT must have the highest priority in the system to be able to
	 * receive all bytes coming from the FTDI. */
	NVIC_SetPriority(FLEXCOM0_IRQn, 0);
	NVIC_EnableIRQ(FLEXCOM0_IRQn);
}

void uart_dma_getc(uint8_t * data, uint32_t len)
{
	pdc_packet_t g_pdc_usart_packet; /* PDC data packet for transfer */
	Pdc *g_p_usart_pdc; /* Pointer to USART PDC register base */

	/* Get pointer to USART PDC register base */
	g_p_usart_pdc = usart_get_pdc_base(USART0);

	/* Initialize PDC data packet for transfer */
	g_pdc_usart_packet.ul_addr = (uint32_t) data;
	g_pdc_usart_packet.ul_size = len;

	/* Configure PDC for data receive */
	pdc_rx_init(g_p_usart_pdc, &g_pdc_usart_packet, NULL);

	/* Enable PDC transfers */
	pdc_enable_transfer(g_p_usart_pdc, PERIPH_PTCR_RXTEN);
	usart_enable_interrupt(USART0, US_IER_ENDRX);
}

void uart_dma_puts(const uint8_t * data, uint32_t len)
{
	/* PDC data packet for transfer */
	pdc_packet_t g_pdc_usart_packet;
	/* Pointer to USART PDC register base */
	Pdc *g_p_usart_pdc;

	/* Get pointer to USART PDC register base */
	g_p_usart_pdc = usart_get_pdc_base(USART0);

	/* Initialize PDC data packet for transfer */
	g_pdc_usart_packet.ul_addr = (uint32_t) data;
	g_pdc_usart_packet.ul_size = len;

	/* Configure PDC for data receive */
	pdc_tx_init(g_p_usart_pdc, &g_pdc_usart_packet, NULL);

	/* Enable PDC transfers */
	pdc_enable_transfer(g_p_usart_pdc, PERIPH_PTCR_TXTEN);
	usart_enable_interrupt(USART0, US_IER_ENDTX);
}

#include <ioport.h>
#define ioport_set_port_peripheral_mode(port, masks, mode) \
	do {\
		ioport_set_port_mode(port, masks, mode);\
		ioport_disable_port(port, masks);\
	} while (0)

#define ioport_set_pin_peripheral_mode(pin, mode) \
	do {\
		ioport_set_pin_mode(pin, mode);\
		ioport_disable_pin(pin);\
	} while (0)

/* Use the EDBG console for debug */
void configure_console(void)
{
	/* USART6 */
	/*ioport_set_port_peripheral_mode(IOPORT_PIOB, PIO_PB0B_TXD6 | PIO_PB1B_RXD6, IOPORT_MODE_MUX_B);
	ioport_set_pin_peripheral_mode(IOPORT_CREATE_PIN(PIOB, 1), IOPORT_MODE_MUX_B);
	ioport_set_pin_peripheral_mode(IOPORT_CREATE_PIN(PIOB, 0), IOPORT_MODE_MUX_B);*/

	/* USART7 / EDBG */
	ioport_set_port_peripheral_mode(PINS_USART7_PORT, PINS_USART7, PINS_USART7_FLAGS);
	ioport_set_pin_peripheral_mode(IOPORT_CREATE_PIN(PIOA, 27), PINS_USART7_FLAGS);
	ioport_set_pin_peripheral_mode(IOPORT_CREATE_PIN(PIOA, 28), PINS_USART7_FLAGS);

	const usart_serial_options_t uart_serial_options = {
		.baudrate = CONF_UART_BAUDRATE,
		.charlength = CONF_UART_CHAR_LENGTH,
		.paritytype = CONF_UART_PARITY,
		.stopbits = CONF_UART_STOP_BITS,
	};

	/* Configure console UART. */
	sysclk_enable_peripheral_clock(CONF_UART_ID);
	usart_serial_init(CONF_UART, (usart_serial_options_t *)&uart_serial_options);

	stdio_serial_init(CONF_UART, &uart_serial_options);

	usart_enable_rx(CONF_UART);
	usart_enable_tx(CONF_UART);

	/* no IRQ on console UART */

}
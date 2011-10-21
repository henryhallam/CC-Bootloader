/*
 * CC Bootloader - Hardware Abstraction Layer 
 *
 * Fergus Noble, Henry Hallam (c) 2011
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
 */

#include "cc1111.h"

/*  Customization instructions:
 *
 *  My board (JimboLink TX 1b) has two bicolor LEDs.  If for whatever crazy
 *  reason yours does not, just do something else in the following LED functions.
 *  You can leave them empty if you like - the LEDs are just for a little debugging
 *  of the bootloader process.
 *
 *  A 1.5k resistor should be connected between USB D+ and a GPIO (my board uses
 *  P1.0).  If you are stingy with GPIOs, you can probably instead connect the
 *  resistor between USB D+ and +3.3V.  I haven't tried that though and it might
 *  cause problems when you want to turn off the USB system after bootload is
 *  complete.  If you used a different GPIO, modify the usb_pullup_xxx functions.
 *
 *  You can optionally connect USB +5V via a potential divider to another GPIO,
 *  for the purpose of detecting whether USB is connected or not - if the micro
 *  boots up without USB connected, it can go directly into the application and
 *  not wait around in the bootloader.  I used P0.4.  If you used something else,
 *  modify usb_power_detect().
 *
 *  If you're customizing this file, you might also want to look at main.h, where
 *  you can set (or disable) the startup timeout.
 */


void setup_led() {
  // Setup LED and turn it off
  P1DIR |= 0x74; //P1.5 and P1.6 for LED3, P1.4 and P1.2 for LED2
  P1_5 = 0;
  P1_6 = 0;
  P1_4 = 0;
  P1_2 = 0;
}

void leds_set(char a, char b) { //a and b may be 0, 1 or 2
  P1_5 = (a & 2)?1:0;
  P1_6 = (a & 1)?1:0;

  P1_2 = (b & 2)?1:0;
  P1_4 = (b & 1)?1:0;
}

void usb_pullup_enable() {
  // On this board, the USB D+ 1.5k pull-up is on P1.0.
  // If you permanently wired it, just leave this function empty.
	P1DIR |= 1;
	P1_0 = 1;
}

void usb_pullup_disable() {
  // On this board, the USB D+ 1.5k pull-up is on P1.0.
  // If you permanently wired it, just leave this function empty.

  P1_0 = 0;
  P1DIR &= ~1;
}

char usb_power_detect() {
  // On this board, USB power detect is on P0.4.
  // If you didn't connect it on your board, just return 1.
  P0DIR &= ~(1<<4);
  return P0_4;
}

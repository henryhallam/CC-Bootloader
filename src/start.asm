	.globl __start__stack
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area	SSEG	(DATA)
__start__stack:
	.ds	1

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area VECTOR    (CODE)
	.globl __interrupt_vect
__interrupt_vect:
	ljmp	__sdcc_gsinit_startup
	
	ljmp #(0x1400+0x03)
	.ds	5
	ljmp #(0x1400+0x0B)
	.ds	5
	ljmp #(0x1400+0x13)
	.ds	5
	ljmp #(0x1400+0x1B)
	.ds	5
	ljmp #(0x1400+0x23)
	.ds 5
	ljmp #(0x1400+0x2B)
	.ds	5
	ljmp usb_isr_forward
	.ds	5
	ljmp #(0x1400+0x3B)
	.ds	5
	ljmp #(0x1400+0x43)
	.ds	5
	ljmp #(0x1400+0x4B)
	.ds	5
	ljmp #(0x1400+0x53)
	.ds	5
	ljmp #(0x1400+0x5B)
	.ds	5
	ljmp #(0x1400+0x63)
	.ds	5
	ljmp #(0x1400+0x6B)
	.ds	5
	ljmp #(0x1400+0x73)
	.ds	5
	ljmp #(0x1400+0x7B)
	.ds	5
	ljmp #(0x1400+0x83)
	.ds	5
	ljmp #(0x1400+0x8B)
	.ds	5
	
usb_isr_forward:
	ljmp _usb_isr
; -- Commented code below was part of a somewhat-misguided attempt to allow
;    use of USB in the application.
;
;  push acc
;	mov	a, _bootloader_running
;	jnz	usb_isr_forward_bootloader
;	 Bootloader not running, jump into the payload ISR
;	pop acc
;	ljmp #(0x1400+0x33)
;usb_isr_forward_bootloader:
;	pop acc
;	ljmp	_usb_isr
	
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	
	.area GSINIT  (CODE)
	.globl __sdcc_gsinit_startup
	.globl __sdcc_program_startup
	.globl __start__stack
	.globl __mcs51_genXINIT
	.globl __mcs51_genXRAMCLEAR
	.globl __mcs51_genRAMCLEAR
	.area GSFINAL (CODE)
	.globl __sdcc_program_startup
	ljmp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
__sdcc_program_startup:
	lcall	_bootloader_main
	;	return from main will lock up
	sjmp .

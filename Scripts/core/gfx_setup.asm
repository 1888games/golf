GFX_SETUP: {


	* = * "-- GFX Setup"

	Init: {

			//Set VIC BANK 3, last two bits = 00
		lda VIC.BANK_SELECT
		and #%11111100
		sta VIC.BANK_SELECT

			// set screen ram & bitmap mode
		lda #SCREEN_OFFSET
		ora #BITMAP_OFFSET
		sta VIC.MEMORY_SETUP

		jsr ClearBitmap


		rts
	}


	ClearBitmap: {

		.label NUM_FULL_PAGES = 31
		.label REMAINING_BYTES = 63

		lda #<BITMAP_BASE
		sta ZP.BitmapAddress

		lda #>BITMAP_BASE
		sta ZP.BitmapAddress + 1

		lda #0
		ldx #NUM_FULL_PAGES
		ldy #0

		Loop:

			sta (ZP.BitmapAddress), y
			iny
			bne Loop

			inc ZP.BitmapAddress + 1
			dex
			beq Final64
			bne Loop

		Final64:

			ldy #REMAINING_BYTES

		Loop2:

			sta (ZP.BitmapAddress), y
			dey
			bpl Loop2

		rts
	}



}
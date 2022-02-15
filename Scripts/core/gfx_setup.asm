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

	InitColours: {

		ldx #0

		Loop:

			lda #(YELLOW<<4)|GREEN
			sta DISPLAY_BASE + (16*40), y
			sta DISPLAY_BASE + (20*40), y

			lda #LIGHT_BLUE
   	 		sta VIC.COLOR_RAM+(16*40),x
    		sta VIC.COLOR_RAM+(20*40),x

    		inx
    		cpx #160
    		bne Loop

    	ldx #0

    	Loop2:

    		lda #(GRAY<<4)|GREEN
    		sta DISPLAY_BASE + (4*40), y
			sta DISPLAY_BASE + (10*40), y

			lda #GREY
			sta VIC.COLOR_RAM+(4*40),x
    		sta VIC.COLOR_RAM+(10*40),x
    		inx
    		cpx #240
    		bne Loop2

    		rts

	}

	


}
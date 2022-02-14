BITMAP: {

	* = * "-- Bitmap"

	.label BitmapSource = ZP.P0
	.label ScreenRamSource = ZP.P2
	.label ColourRamSource = ZP.P4

	.label BitmapDestination= ZP.MATHS0
	.label ScreenRamDestination = ZP.MATHS2
	.label ColourRamDestination = ZP.MATHS4

	.label BITMAP_SIZE = $8000
	.label BITMAP_BLOCK_SIZE = 250
	.label BITMAP_BLOCKS = BITMAP_SIZE / BITMAP_BLOCK_SIZE

	.label SCREEN_BLOCKS = 4

	DrawMulticolour: {

		   // NOTE: assume multicolor bitmap mode has already been set!

		jsr SetupSourcePointers
		jsr SetupDestinationPointers
		jsr CopyData


		rts

	}

	SetupSourcePointers: {

		 // Initialize pointers for video & color RAM.

		.label BitmapScreenRAM_Gap = $8000
		.label ScreenRAMColourRam_Gap = $1000


		lda BitmapSource
	    clc
	    adc #<BitmapScreenRAM_Gap
	    sta ScreenRamSource

	    lda BitmapSource + 1
	    adc #>BitmapScreenRAM_Gap
	    sta ScreenRamSource + 1

	    lda ScreenRamSource
	    clc
	    adc #<ScreenRAMColourRam_Gap
	    sta ColourRamSource
	    
	    lda ScreenRamSource + 1
	    adc #>ScreenRAMColourRam_Gap
	    sta ColourRamSource + 1

	    rts

	}

	SetupDestinationPointers: {


		lda #<BITMAP_BASE
	    sta BitmapDestination
	    lda #>BITMAP_BASE
	    sta BitmapDestination + 1

	    lda #<DISPLAY_BASE 
	    sta ScreenRamDestination
	    lda #>DISPLAY_BASE 
	    sta ScreenRamDestination+ 1

	    lda #<VIC.COLOR_RAM
	    sta ColourRamDestination
	    lda #>VIC.COLOR_RAM
	    sta ColourRamDestination + 1

	    rts
	}

	CopyData: {

		jsr BitmapData
		jsr ScreenColourData

		rts

	}

	BitmapData: {

		ldx #BITMAP_BLOCKS

		BitmapLoop:

			ldy #0

		YLoop1:

			lda (BitmapSource), y
			sta (BitmapDestination), y
			iny
			cpy #BITMAP_BLOCK_SIZE
			bne YLoop1

			dex
			beq Finish

			MovePointer(BitmapSource, BITMAP_BLOCK_SIZE)
			MovePointer(BitmapDestination, BITMAP_BLOCK_SIZE)

			jmp BitmapLoop

		Finish: 


		rts
	}


	ScreenColourData: {

		ldx #SCREEN_BLOCKS

		Loop:

			ldy #0

		YLoop1:

			lda (ScreenRamSource), y
			sta (ScreenRamDestination), y

			lda (ColourRamSource), y
			sta (ColourRamDestination), y

			iny
			cpy #BITMAP_BLOCK_SIZE
			bne YLoop1

			dex
			beq Finish

			MovePointer(ScreenRamSource, BITMAP_BLOCK_SIZE)
			MovePointer(ScreenRamDestination, BITMAP_BLOCK_SIZE)
			MovePointer(ColourRamSource, BITMAP_BLOCK_SIZE)
			MovePointer(ColourRamDestination, BITMAP_BLOCK_SIZE)
			
			jmp Loop

		Finish: 
			
			lda (ColourRamSource), y
			sta VIC.BACKGROUND_COLOR

		rts

	}
		



}
*=$02 "Temp vars zero page" virtual


.label PADDING = 5
.label MAX_SPRITES = 20



ZP: {

	Counter:				.byte 0
	Row:					.byte 0
	Column:					.byte 0
	RowOffset:				.byte 0
	CharID:					.byte 0
	Temp1:					.byte 0
	Colour:					.byte 0
 	Amount:					.byte 0
 	CurrentID:				.byte 0
 	ScreenAddress:			.word 0
 	ColourAddress:			.word 0


 	P0:						.byte 0
 	P1:						.byte 0
 	P2:						.byte 0
 	P3:						.byte 0
	P4:						.byte 0
 	P5:						.byte 0

 	MATHS0:					.byte 0
 	MATHS1:					.byte 0
 	MATHS2:					.byte 0
 	MATHS3:					.byte 0
	MATHS4:					.byte 0
 	MATHS5:					.byte 0



}


	TextRow:	.byte 0
	TextColumn:	.byte 0

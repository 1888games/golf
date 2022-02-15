SCORE_CARDS: {

	* = * "-Scorecards"

	Pars:			.fill 18, 3
	Scores:			.fill 18 * MAX_PLAYERS, 0
	TeamScores:		.fill 18 * 2, 0

	RoundScores:	.fill MAX_PLAYERS, 0
	Front9Scores:	.fill MAX_PLAYERS, 0
	Back9Scores:	.fill MAX_PLAYERS, 0

	ScoresEnd:

	ScoreStringBuffer:	.fill 3, 0
	ScoreStringColour:	.byte 0

// ; Temporary buffer for score string and color.
// ; NOTE: extra 3 bytes for buffer is when match play - we need to show also
// ; how many holes are still to play (e.g. '/11').
// sc_v_score_str_buffer   !fill   3;+3
// sc_v_score_str_color    !byte   0



	ResetAll: {

		ldx #ScoresEnd-Scores-1
		lda #0

		Loop:

			sta Scores, x
			dex
			cpx #255
			bne Loop


		rts
	}


}
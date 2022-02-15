GOLFER: {


	* = * "-Golfer"

	Init: {

	   	lda #LIGHT_RED
	    sta VIC.SPRITE_COLOR_0

	    lda #RED
	    sta VIC.SPRITE_COLOR_1

	    // now sprite engine

		lda #0
	    sta spr_v_x_hi+GOLFER_UPPER_BODY_SPR_NUM
	    sta spr_v_x_hi+GOLFER_LOWER_BODY_SPR_NUM
	    sta spr_v_x_hi+GOLFER_CLUB_SHAFT_SPR_NUM 
	    sta spr_v_hires+GOLFER_UPPER_BODY_SPR_NUM
	    sta spr_v_hires+GOLFER_LOWER_BODY_SPR_NUM
	    sta spr_v_hires+GOLFER_CLUB_SHAFT_SPR_NUM 

		rts
	}
}
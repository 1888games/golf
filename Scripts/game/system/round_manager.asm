ROUND_MANAGER: {


	* = * "-Round Manager"

	Init: {

		jsr GFX_SETUP.InitColours
		jsr SCORE_CARDS.ResetAll
		jsr GOLFER.Init



		rts
	}





						// *******************
					// *** SUBROUTINES ***
					// *******************
					//!zone {
					// round_s_init
					//     jsr gfxs_s_init_colors
					//     jsr sc_s_reset_all
//     jsr golfer_init2
//     jsr sstore_init
//     jsr players_s_reset
//     jsr bdrop_s_init

//     lda #0
//     sta round_v_current_player
//     ldx shared_v_holes
//     lda round_l_FIRST_HOLE_TO_PLAY,x
//     sta round_v_current_hole

//     lda #0
//     sta transtn_v_is_active

//     lda #1
//     sta round_v_must_render

//     jsr msg_s_clear

//     rts
// end sub round_s_init
//



}
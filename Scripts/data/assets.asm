

 	* = $c400 "Sprites" //Start at frame #16
 	//.import binary "../../assets/jawbreaker - sprites.bin"



* = $f000 "Charset"

CHAR_SET:	.import binary "../assets/jawbreaker - Chars.bin"   
		
* = $7000 "Game Map" 
MAP: 		.import binary "../assets/jawbreaker - Map (20x13).bin"

* = * "Game Tiles" 
MAP_TILES: .import binary "../assets/jawbreaker - Tiles.bin"

* = * "Game Colours" 
CHAR_COLORS: .import binary "../assets/jawbreaker - CharAttribs_L1.bin"





*= $cc00 "  SPRITES" // Sprite 48

* = * "-Blank"
BLANK_SPRITE:		.fill 64, 0
* = * "-Reserved"
RESERVED_SPRITES:	.fill 64 * 4, 0
* = * "-Clubs"
CLUBS:				.import binary "../../assets/sprites/clubs.bin"
* = * "-Crosshair"
CROSSHAIR:			.import binary "../../assets/sprites/crosshair.bin"
* = * "-Backdrop"
BACKDROP_SPRITES:	.fill 13 * 64, 0
* = * "-Overhead Ball"
OVERHEAD_BALL: 		.import binary "../../assets/sprites/overhead_ball.bin"
* = * "-Top Sprites"
TOP_SPRITES: 		.import binary "../../assets/sprites/top_spr.bin"


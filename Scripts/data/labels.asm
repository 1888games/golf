
.label ZERO= 					0
.label FALSE = 					0	
.label ALL_ON = 				255
.label TRUE = 					1


.label PAL = 					0
.label NTSC =	 				1

.label GAME_MAP =				0
.label GAME_TITLE = 1

.label PROCESSOR_PORT = 		$01
.label INTERRUPT_VECTOR = 		$fffe
.label JOY_PORT_2 = 			$dc00

.label SCREEN_RAM = 			$c000

.label IRQControlRegister1 = 	$dc0d
.label IRQControlRegister2 = 	$dd0d


.label WHITE_MULT = 9
.label RED_MULT = 10
.label CYAN_MULT = 11
.label PURPLE_MULT = 12
.label GREEN_MULT = 13
.label BLUE_MULT = 14
.label YELLOW_MULT = 15

.label LEFT_MASK = 1
.label RIGHT_MASK = 2
.label DOWN_MASK = 4
.label UP_MASK= 8

.label LEFT = 0
.label RIGHT = 1
.label DOWN = 2
.label UP = 3




.label NIL = 0
.label ONE = 1


.label GAME_MODE_TITLE = 0
.label GAME_MODE_PLAY = 1
.label GAME_MODE_OVER = 2



// GFX_SETUP.ASM


.label VIC_BANK_0 = %11
.label VIC_BANK_1 = %10
.label VIC_BANK_2 = %01
.label VIC_BANK_3 = %00

.label SCREEN_OFFSET = 2<<4 
.label CHARSET_OFFSET = 0<<4
.label BITMAP_OFFSET = 1<<3

.label CHARS_TO = $C000
.label CHAR_PAGES = 2

.label SPRITE_POINTERS = DISPLAY_BASE + 1024 - 8
.label DISPLAY_BASE= $C800
.label BITMAP_BASE = $e000

.label COLOR_RAM_OFFSET = VIC.COLOR_RAM - DISPLAY_BASE



.label MAX_PLAYERS = 4







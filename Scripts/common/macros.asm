ShowDebug: .byte 0

.macro StoreState() {

	pha // A
	txa
	pha // X
	tya
	pha // Y

}

.macro RestoreState() {

	pla // Y
	tay
	pla // X
	tax
	pla // A

}

.macro SetDebugBorder(value) {

	lda ShowDebug
	beq Finish

	lda #value
	sta $d020

	Finish:

}


.macro MovePointer(pointer,amount) {

	lda pointer
	clc
	adc #amount
	sta pointer
	bcc NoCarry

	inc pointer + 1

	NoCarry:
}

.macro MovePointerBack(pointer,amount) {

	lda pointer
	sec
	sbc #amount
	sta pointer
	bcs NoCarry

	dec pointer + 1

	NoCarry:
}
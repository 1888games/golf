DECOMPRESSOR: {


    * = * "-- Decompressor"


    .label Source = ZP.P0
    .label Destination = ZP.P2
    .label EscapeCode = ZP.P4
    .label DestinationIteration = ZP.P5
    .label Pattern = ZP.P6

    DisplayMCBitmap: {

        ldy #0
        sty DestinationIteration

        lda (Source), y
        sta VIC.BACKGROUND_COLOR

        iny
        lda (Source), y
        sta EscapeCode

        MovePointer(Source, 2)

        Loop_Top:

            ldy #0
            lda (Source), y
            cmp EscapeCode
            beq HandleRun

            ldy DestinationIteration
            sta (Destination), y
            iny
            sty DestinationIteration
            bne NoCarry1

            inc Destination + 1


        NoCarry1:

            MovePointer(Source,1)
            jmp Loop_Top

        HandleRun:

            iny
            lda (Source), y
            sta Pattern

            iny
            lda (Source), y
            tax

            MovePointer(Source, 3)

            txa
            ora Pattern
            beq Finish

            ldy DestinationIteration
            lda Pattern

        RunLoop:

            sta (Destination), y
            iny
            bne NoCarry2

            inc Destination + 1
    

        NoCarry2:

             dex
             bne RunLoop

             sty DestinationIteration
             beq Loop_Top


        Finish:



        rts
    }

}
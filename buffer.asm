					LIST p=16f877a
					INCLUDE <P16F877A.INC>

buffRegOne			EQU 	0x20
buffRegTwo			EQU 	0x21
buffRegThree 		EQU 	0x22
buffRegFour			EQU 	0x23
buffRegFive			EQU		0x24

mainRegOne			EQU 	0x25
mainRegTwo			EQU 	0x26
mainRegThree 		EQU 	0x27
mainRegFour			EQU 	0x28
mainRegFive			EQU		0x29

buffStart			EQU		0x7A
buffNext			EQU		0x7B
buffEnd			    EQU		0x7C


					ORG		0x00
					goto	main
					ORG		0x20

main				call	initmainreg
					call	initbuff
mainone
					call	storebuff
					call	incmainreg
					goto  	mainone



;----------------Initial values for circular buffer--------------

initmainreg			movlw	D'2'
					movwf	mainRegOne
					return

;----------------Increment Main register values----------------------

incmainreg			movlw	D'2'
					addwf	mainRegOne,F
					return	

;-------------------Circular buffer intialization-----------------

initbuff			movlw	0x20
					movwf	buffStart

					movlw	0x20
					movwf	buffNext

					movlw	0x24
					movwf	buffEnd

					movf	buffStart,W
					movwf	FSR
	
					return

;-------------------Circular buffer storage-----------------

storebuff			
					movf	mainRegOne,W
					movwf	INDF

					incf	buffNext
					movf	buffNext,W
					movwf	FSR
					
					movf	buffNext,W
					bcf		STATUS,Z
					sublw	0x25
					btfss	STATUS,Z
					return
					goto	buffreset

					
buffreset			movf	buffStart,W
					movwf	buffNext
					movwf	FSR
					
					return


;-----------------Program Termination-------------------------

finish
					END




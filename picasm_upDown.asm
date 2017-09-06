; FILENAME: picasm_upDown.asm
; DATE OF PERFORMANCE: August 17, 2017
; AUTHORS: Bien Carlo B. Halili; Jochelle Nicolle P. Enriquez
; DESCRIPTION:  This program contain instructions in creating an
;		up and down counter associated with a switch. The
;		switch when valued at logic 1 (HIGH), it will serve
;		as an up counter, else down counter.

; CPU CONFIGURATION 
PROCESSOR 16F877A
INCLUDE <P16F877A.INC>
__config _XT_OSC & _WDT_OFF & _PWRTE_ON 

; SET UP THE CONSTANTS
STATUS 	EQU 	03H
TRISB	EQU	86H	
PORTB	EQU	06H
TRISC 	EQU 	87H
PORTC 	EQU 	07H
COUNT1 	EQU 	30H
COUNT2 	EQU 	31H
N	EQU	D'130'
ORG 0

; SET UP THE PORT
BSF 	STATUS, 5
MOVLW	B'00000000'	
MOVWF	TRISC		; Port C as output
MOVLW	B'00000001'
MOVWF	TRISB		; Port B; Bit 0 as input
BCF		STATUS, 5

; TURN THE 7-SEGMENT LED ON
MAIN
	; CHECK IF THE SWITCH IS SET TO ON
	BTFSS PORTB,0
	CALL UPCOUNT
	BTFSC PORTB, 0
	CALL DOWNCOUNT
	
	; GO BACK TO THE START OF THE PROGRAM
	GOTO MAIN

;UPCOUNT SUBROUTINE
UPCOUNT

	MOVLW B'01100000'	; Do 1
	MOVWF PORTC
	CALL DELAY

	MOVLW B'11011010'	; Do 2
	MOVWF PORTC
	CALL DELAY

	MOVLW B'11110010'	; Do 3
	MOVWF PORTC
	CALL DELAY

	MOVLW B'01100110'	; Do 4
	MOVWF PORTC
	CALL DELAY

	MOVLW B'10110110'	; Do 5
	MOVWF PORTC
	CALL DELAY

	MOVLW B'10111110'	; Do 6
	MOVWF PORTC
	CALL DELAY

	MOVLW B'11100000'	; Do 7
	MOVWF PORTC
	CALL DELAY

	MOVLW B'11111110'	; Do 8
	MOVWF PORTC
	CALL DELAY

	MOVLW B'11100110'	; Do 9
	MOVWF PORTC
	CALL DELAY
	RETURN
;END OF UPCOUNT SUBROUTINE

;DOWNCOUNT SUBROUTINE
DOWNCOUNT
	MOVLW B'11100110'	; Do 9
	MOVWF PORTC
	CALL DELAY

	MOVLW B'11111110'	; Do 8
	MOVWF PORTC
	CALL DELAY

	MOVLW B'11100000'	; Do 7
	MOVWF PORTC
	CALL DELAY

	MOVLW B'10111110'	; Do 6
	MOVWF PORTC
	CALL DELAY

	MOVLW B'10110110'	; Do 5
	MOVWF PORTC
	CALL DELAY

	MOVLW B'01100110'	; Do 4
	MOVWF PORTC
	CALL DELAY

	MOVLW B'11110010'	; Do 3
	MOVWF PORTC
	CALL DELAY

	MOVLW B'11011010'	; Do 2
	MOVWF PORTC
	CALL DELAY

	MOVLW B'01100000'	; Do 1
	MOVWF PORTC
	CALL DELAY

	MOVLW B'11111100'	; Do 0
	MOVWF PORTC
	CALL DELAY
	RETURN 
;END OF DOWNCOUNT SUBROUTINE

DELAY100
	MOVLW N
	MOVWF COUNT1
	CLRF COUNT2

DELAY
	DECFSZ COUNT1, F		
	GOTO DELAY
	DECFSZ COUNT2, F		
	GOTO DELAY
	RETURN

END
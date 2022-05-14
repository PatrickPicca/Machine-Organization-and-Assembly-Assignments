s;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: William Picca
; Email: wpicc001@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 22
; TA: Shirin Haji Amin Shirazi
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------


LD R2, DEC_4			;Setting R2 as a counter for keep tracking of every 4 bits in regards to spacing.
LD R3, DEC_15			;Setting R3 as a counter for total number of bits remaining.

LoopMoreBits
	ADD R2, R2, #0
	BRp EveryFourBits	;Checks if the counter of R2 is positive, there are still more bits to be printed in this group.
						;Skips this code if there still is more to print.
	
	AND R4, R4, #0		;Set of code that loads into R0 current value of R3, exiting the loop as there are no more bits to print.
	ADD R4, R4, R3		
	BRn Finish		
	
	LEA R0, space		;Displays a space after every 4th bit.
	PUTS
	AND R2, R2, #0		;Sets R2 to value of 0.
	ADD R2, R2, #4		;Increments R2 by 4, resetting the total number of bits before next space.
	ADD R3, R3, #0		;Statement that checks value of R3, where if next 
	BR EndOfFourBits	;If this code is reached, as a result of a space being printed, skip the rest of the code,
						;Restarting the loop.
	
	EveryFourBits		;End of skipped code for EveryFourBits
	ADD R1, R1, #0
		
	BRn IfNegative		;If current value of R1 is negative, skip this code.
		LEA R0, bitZero		;Displays a 0 bit
		PUTS
		
		BR Final		;Skips to the end of the bit printing code
	IfNegative			
			LEA R0, bitOne			;Displays a 1 bit
			PUTS
	Final
		
	ADD R1, R1, R1			;Shifts the value of R1 to the left by multiplying by 2, adding itself essentially.
	ADD R3, R3, #-1			;Decrements the counter for total number of bits remaining
	ADD R2, R2, #-1			;Decrements the counter
	EndOfFourBits				
BRzp LoopMoreBits		;Loops more bits if R3, the number of bits remaining, is positive..
Finish
LEA R0, newLine				;Displays a new line
PUTS

HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCB00	; The address where value to be displayed is stored
DEC_4 .FILL #4
DEC_15 .FILL #15
newLine .STRINGZ "\n"
bitZero .STRINGZ "0"
bitOne .STRINGZ "1"
space .STRINGZ " "


.ORIG xCB00					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END

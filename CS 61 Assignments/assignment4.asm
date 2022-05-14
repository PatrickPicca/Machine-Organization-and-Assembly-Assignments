;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: William Patrick Picca
; Email: wpicc001@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 23
; TA: Shirin Haji Amin Shirazi
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R1
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------

Reset         ;Starts the program over if branch is reached.


; output intro prompt
					
	LD R0, introPromptPtr
	PUTS
						
; Set up flags, counters, accumulators as needed

	
	AND R1, R1, #0
	AND R2, R2, #0	;R2 will be the flag that holds 0 for positive and 1 for negative
	AND R3, R3, #0	;R3 will accumlate the input
	AND R4, R4, #0	;R4 will be the register that checks input
	AND R6, R6, #0	;R6 holds the current accumlated value to be mulitplied by 10 if another digit is added.
	AND R7, R7, #0
	
	LD R5, DEC_4	


; Get first character, test for '\n', '+', '-', digit/non-digit 	
					
	GETC
	OUT
	
					; is very first character = '\n'? if so, just quit (no message)!
	
	LD R4, newline_DEC
	ADD R4, R4, R0			;This and previous line adds first input with that off the newline value into R4.
	BRnp NotNewline			;If 'ENTER' is inputted by user, ends program.
	BR NewlineFound
	NotNewline
		
					; is it = '+'? if so, ignore it, go get digits
	
	LD R4, Positive		;If the first input is the positive sign, stops checking other cases and heads to Input_Array branch.
	ADD R4, R4, R0
	BRz Input_Array
	
					; is it = '-'? if so, set neg flag, go get digits
		
	LD R4, Negative		;If first input is negative sign, toggle negative flag and goes to Input_Array branch. If not, 
						;continue checking other cases.
	ADD R4, R4, R0
	BRnp Not_Negative
	ADD R2, R2, #1		;R2 is set to 1, letting the rest of the program know that the inputted number is negative.
	BR Input_Array	
	Not_Negative
			
					; is it < '0'? if so, it is not a digit	- o/p error message, start over
	

	LD R4, ASCII0				;If at this point the ASCII value of what is inputted is below 0, it is not a number.
								;End program at that point or continue
	ADD R4, R4, R0
	BRzp SkipRestart
	LEA R0, newline
	PUTS	
	LD R0, errorMessagePtr
	PUTS
	BR Reset
	SkipRestart

					; is it > '9'? if so, it is not a digit	- o/p error message, start over
					
	LD R4, ASCII9				;If at this point the ASCII value of what is inputted is above 9, it is not a number.
								;End program at that point or continue
	ADD R4, R4, R0
	BRnz SkipRestart2
	LEA R0, newline
	PUTS	
	LD R0, errorMessagePtr
	PUTS
	BR Reset
	SkipRestart2				
					
					; if none of the above, first character is first numeric digit - convert it to number & store in target register!
					
	ADD R5, R5, #-1				;First valid number recieved, decrement R5 counter and add number to accumulator..
	LD R4, ASCIIOffset
	ADD R4, R4, R0
	ADD R3, R3, R4				
					
; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator


	Input_Array
		GETC							;Takes next input from user.
		OUT
		
		LD R4, newline_DEC				;Checks if input is 'ENTER' from user, ending the Input_Array early if so.
		ADD R4, R4, R0
		BRnp NewlineSkip
		BR End_Input_Array
		NewlineSkip
		
		LD R4, ASCII0					;Checks if inputs value is below 0, recogniziing it as invalid input and starting over
		ADD R4, R4, R0
		BRzp ZeroFound
		LEA R0, newline
		PUTS	
		LD R0, errorMessagePtr
		PUTS
		BR Reset
		ZeroFound
		
		LD R4, ASCII9				;Checks if inputs valie is above 9, recognizing it as invalid input and starting over.
		ADD R4, R4, R0
		BRnz NineFound
		LEA R0, newline
		PUTS	
		LD R0, errorMessagePtr
		PUTS
		BR Reset
		NineFound
		
		;If reached current input is valid, therefore add in the value
		
		AND R6, R6, #0				;If reached sets R6 to 0.
		ADD R6, R6, R3				;Adds in current accumlated value of R3 into R6
		LD R4, DEC_9
		MultiplyLoop				;Branch loop that mulitplies R6 by adding itself 10 times, back into R3.
			ADD R3, R3, R6
			ADD R4, R4, #-1
			BRp MultiplyLoop
		
		LD R4, ASCIIOffset
		ADD R4, R4, R0				
		ADD R3, R3, R4				;Adds recent input back into R4, giving the current total accumulated value.
		ADD R5, R5, #-1				;Decrements R5 counter. If counter is no longer positive, ends the Input_Array

		BRp Input_Array
	End_Input_Array

	ADD R2, R2, #0					;If reached checks flag of R2. If R2 is positive, take the 2s complement of R3.
	BRnz IfNegative
		NOT R3, R3
		ADD R3, R3, #1
	IfNegative


					; remember to end with a newline!
	ADD R0, R0, #-10
	BRz	EndIt
	LEA R0, newline
	PUTS	
	EndIt	
	NewlineFound
					
					
	ADD R1, R3, #0
					
					
	HALT

;---------------	
; Program Data
;---------------

introPromptPtr		.FILL xB000
errorMessagePtr		.FILL xB200


Positive	.FILL #-43		;ASCII offsets to convert a given input to's numerical value of desired ranges.
Negative    .FILL #-45
ASCII0		.FILL #-48
ASCII9		.FILL #-57
ASCIIOffset	.FILL #-48
newline_DEC .FILL #-10
newline 	.STRINGZ	"\n"
DEC_4   	.FILL	#5
DEC_9		.FILL	#9


;------------
; Remote data
;------------
					.ORIG xB000			; intro prompt
					.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
					.ORIG xB200			; error message
					.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
					.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.

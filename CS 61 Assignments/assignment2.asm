;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: William Picca
; Email: wpicc001@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------


GETC					; gets first input from user
OUT						; outputs stored input located at register 0
ADD R1, R0, #0			; Adds into register 1 what is stored at register 0

;Set of code that loads into register 0 newline and outputs it, skipping a line.
LD R0, newline			; get starting address of prompt string
OUT

;Set of code that takes in input, stores it into a register, and outputs it back to the user.
;PUTS			    	; Invokes BIOS routine to output string
GETC					; gets second input from user
OUT						; outputs stored input located at register 0
ADD R2, R0, #0			; Adds into register 2 what is stored at register 0

;Set of code that loads into register 0 newline and outputs it, skipping a line.
LD R0, newline			; get starting address of prompt string
OUT

;Set of code that stores into R0 what is in R1, and outputs R0
ADD R0, R1, #0
OUT

;set of code that outputs the minus sign with spaces
LEA R0, space
PUTS
LEA R0, minus
PUTS
LEA R0, space
PUTS

;Set of code that stores into R0 what is in R2, and outputs R0
ADD R0, R2, #0
OUT

;set of code that outputs the equals sign with spaces
LEA R0, space
PUTS
LEA R0, equals
PUTS
LEA R0, space
PUTS

;set of code that adds the ASCII offset to our resulting number, allowings us to output the result.
LD R4, ASCII
LD R0, #0

;set of code that takes the 2's complement of R2 and adds that result to R1, storing the result into R3.
NOT R2, R2
ADD R2, R2, 1
ADD R3, R1, R2


;Branch that checks if R3 is a negative number, skipping this code if it is.
ADD R3, R3, #0
BRn isnotpositive
;Adding ASCII offset onto R3
ADD R0, R3, R4
OUT
isnotpositive

;Branch that checks if the resulting value of R3 is zero or positive., skipping this code if it is.
ADD R3, R3, #0
BRzp isnotnegative
;Set of code that displays the minus sign and the magnitude of the negative number.
LEA R0, minus
PUTS
NOT R3, R3
ADD R3, R3, 1
LD R0, 0
ADD R0, R3, R4
OUT
isnotnegative

;Set of code that loads into register 0 newline and outputs it, skipping a line.
LD R0, newline			; get starting address of prompt string
OUT

HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT
minus  .STRINGZ  "-"   ;
equals  .STRINGZ  "="  ;
space .STRINGZ " "     ;
ASCII .FILL x30



;---------------	
;END of PROGRAM
;---------------	
.END


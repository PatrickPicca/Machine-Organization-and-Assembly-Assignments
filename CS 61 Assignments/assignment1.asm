;=================================================
; Name: William Picca
; Email:  wpicc001@ucr.edu
; Assignment: assn1
; Lab Section: <22>
;
; TA: Shirin Haji Amin Shirazi
; 
;=================================================


;-----------------------------------------------------
; REG VALUES      R0 R1 R2 R3 R4 R5 R6 R7
;-----------------------------------------------------
; Pre-Loop        0  6  12  0  0  0  0 1168
; Iteration 1     0  5  12  12 0  0  0 1168
; Iteration 2     0  4  12  24 0  0  0 1168
; Iteration 3     0  3  12  36 0  0  0 1168
; Iteration 4     0  2  12  48 0  0  0 1168
; Iteration 5     0  1  12  60 0  0  0 1168
; Iteration 6     0  0  12  72 0  0  0 72
; End of Program  0  0  12  72 0  0  0 72
;-----------------------------------------------------


.ORIG x3000						; **ALL your programs start at x3000
; Instructions (i.e. LC-3 code)

AND R1, R1, x6 			; R1 <- (R1) AND x0000 
LD R2, DEC_12			; R2 <- #12
LD R3, DEC_0			; R3 <- #0

DO_WHILE
	ADD R3, R3, R2		; R3 <- R3 + R2
	ADD R1, R1, #-1		; R1 <- R1 - #1
	BRp DO_WHILE		; if (LMR >0): goto DO_WHILE

HALT							; end of program code
; Local Data					; pseudo-ops for hard-coding data go here

DEC_0		.FILL   #0		; put #0 into memory here
DEC_6		.FILL   #6		; put #6 into memory here
DEC_12		.FILL   #12		; put #12 into memory here

.end							; .end is like the "}" after main() in C++

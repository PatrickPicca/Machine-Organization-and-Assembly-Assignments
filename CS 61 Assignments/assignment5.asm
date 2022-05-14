;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: William Picca
; Email: wpicc001@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 23
; TA: Shirin Haji Amin Shirazi
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================
; Busyness vector: xB600 

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

MENU_PROMPT

	LD R6, MENU_PTR
	JSRR R6
	
END_MENU_PROMPT

ADD R1, R1, #-1
BRnp CONTINUE_1		;Check if all machines are busy
	LD R6, ALL_MACHINES_BUSY_PTR
	JSRR R6
	
	ADD R2, R2, #0
	BRp ALL_BUSY
		LEA R0, allnotbusy
		PUTS
		BR END_ALL_MACHINES_BUSY
	ALL_BUSY
		LEA R0, allbusy
		PUTS
	END_ALL_MACHINES_BUSY
	
BR MENU_PROMPT
CONTINUE_1
ADD R1, R1, #-1
BRnp CONTINUE_2		;Check if all machines are free
	LD R6, ALL_MACHINES_FREE_PTR
	JSRR R6
	
	ADD R2, R2, #0
	BRp ALL_FREE
		LEA R0, allnotfree
		PUTS
		BR END_ALL_MACHINES_FREE
	ALL_FREE
		LEA R0, allfree
		PUTS
	END_ALL_MACHINES_FREE
	
BR MENU_PROMPT
CONTINUE_2
ADD R1, R1, #-1
BRnp CONTINUE_3		;Display the number of machines that are busy

	LEA R0, busymachine1
	PUTS
	
	LD R6, NUM_BUSY_MACHINES_PTR
	JSRR R6
	
	LD R6, PRINT_NUM_PTR
	JSRR R6
	
	LEA R0, busymachine2
	PUTS
	
BR MENU_PROMPT
CONTINUE_3
ADD R1, R1, #-1
BRnp CONTINUE_4		;Display the number of machines that are free

	LEA R0, freemachine1
	PUTS
	
	LD R6, NUM_FREE_MACHINES_PTR
	JSRR R6
	
	LD R6, PRINT_NUM_PTR
	JSRR R6
	
	LEA R0, freemachine2
	PUTS
	
BR MENU_PROMPT
CONTINUE_4
ADD R1, R1, #-1
BRnp CONTINUE_5		;Displays the status of any given machine inputted by the user

	LD R6, GET_MACHINE_NUM_PTR
	JSRR R6
	
	LD R6, MACHINE_STATUS_PTR
	JSRR R6
	
	LEA R0, status1
	PUTS
	
	LD R6, PRINT_NUM_PTR
	JSRR R6
	
	ADD R2, R2, #0
	BRz STATUS_BUSY
		LEA R0, status3
		PUTS
	BR END_STATUS_BUSY
	STATUS_BUSY
		LEA R0, status2
		PUTS
	END_STATUS_BUSY
	
BR MENU_PROMPT
CONTINUE_5
ADD R1, R1, #-1
BRnp CONTINUE_6		;Displays the number of the first free machine

	LD R6, FIRST_FREE_PTR
	JSRR R6
	
	ADD R1, R1, #0
	BRn NO_MACHINES_FREE
	
	LEA R0, firstfree1
	PUTS
	LD R6, PRINT_NUM_PTR
	JSRR R6
	LD R0, newline
	OUT
	BR END_NO_MACHINES_FREE
	
	NO_MACHINES_FREE
		LEA R0, firstfree2
		PUTS
	END_NO_MACHINES_FREE
	
BR MENU_PROMPT
CONTINUE_6		;Quits the program
	LEA R0, goodbye
	PUTS

HALT
;---------------	
;Data
;---------------
;Subroutine pointers

MENU_PTR 				.FILL			x3200
ALL_MACHINES_BUSY_PTR 	.FILL			x3400
ALL_MACHINES_FREE_PTR 	.FILL			x3600
NUM_BUSY_MACHINES_PTR 	.FILL			x3800
NUM_FREE_MACHINES_PTR 	.FILL			x4000
MACHINE_STATUS_PTR 		.FILL			x4200
FIRST_FREE_PTR 			.FILL			x4400
GET_MACHINE_NUM_PTR 	.FILL			x4600
PRINT_NUM_PTR 			.FILL			x4800


;Other data 
newline 		.fill '\n'

; Strings for reports from menu subroutines:
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.org x3200

;HINT back up 
ST R0, BACKUP_R0_3200		;Stores registers temporarily. 
ST R1, BACKUP_R1_3200
ST R2, BACKUP_R2_3200
ST R3, BACKUP_R3_3200
ST R4, BACKUP_R4_3200
ST R5, BACKUP_R5_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

PRINT_MENU_3200

LD R0, Menu_string_addr
PUTS

GETC
OUT

ADD R2, R0, #0
ADD R2, R2, #-12
ADD R2, R2, #-12
ADD R2, R2, #-12
ADD R2, R2, #-12

LD R0, newline_3200
OUT

ADD R2, R2, #0
BRnz ERROR_MSG_3200
ADD R2, R2, #-7
BRp ERROR_MSG_3200

ADD R1, R2, #7
BR END_ERROR_MSG_3200

ERROR_MSG_3200
	LEA R0, Error_msg_1
	PUTS
	BR PRINT_MENU_3200
END_ERROR_MSG_3200



;HINT Restore
LD R0, BACKUP_R0_3200
LD R2, BACKUP_R2_3200
LD R3, BACKUP_R3_3200
LD R4, BACKUP_R4_3200
LD R5, BACKUP_R5_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x5000
newline_3200		.fill '\n'
BACKUP_R0_3200 .BLKW #1
BACKUP_R1_3200 .BLKW #1
BACKUP_R2_3200 .BLKW #1
BACKUP_R3_3200 .BLKW #1
BACKUP_R4_3200 .BLKW #1
BACKUP_R5_3200 .BLKW #1
BACKUP_R6_3200 .BLKW #1
BACKUP_R7_3200 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.org x3400



;HINT back up 
ST R0, BACKUP_R0_3400		;Stores registers temporarily. 
ST R1, BACKUP_R1_3400
ST R2, BACKUP_R2_3400
ST R3, BACKUP_R3_3400
ST R4, BACKUP_R4_3400
ST R5, BACKUP_R5_3400
ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400


AND R2, R2, x0
LD R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY
LDR R1, R0, #0

ADD R1, R1, #0
BRnp END_TRUE_3400

TRUE_3400
	ADD R2, R2, #1
END_TRUE_3400



;HINT Restore
LD R0, BACKUP_R0_3400
LD R1, BACKUP_R1_3400
LD R3, BACKUP_R3_3400
LD R4, BACKUP_R4_3400
LD R5, BACKUP_R5_3400
LD R6, BACKUP_R6_3400
LD R7, BACKUP_R7_3400

RET
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xB600
BACKUP_R0_3400 .BLKW #1
BACKUP_R1_3400 .BLKW #1
BACKUP_R2_3400 .BLKW #1
BACKUP_R3_3400 .BLKW #1
BACKUP_R4_3400 .BLKW #1
BACKUP_R5_3400 .BLKW #1
BACKUP_R6_3400 .BLKW #1
BACKUP_R7_3400 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
.org x3600

;HINT back up 
ST R0, BACKUP_R0_3600		;Stores registers temporarily. 
ST R1, BACKUP_R1_3600
ST R2, BACKUP_R2_3600
ST R3, BACKUP_R3_3600
ST R4, BACKUP_R4_3600
ST R5, BACKUP_R5_3600
ST R6, BACKUP_R6_3600
ST R7, BACKUP_R7_3600


AND R2, R2, x0
LD R0, BUSYNESS_ADDR_ALL_MACHINES_FREE
LDR R1, R0, #0
ADD R1, R1, #1
BRnp END_TRUE_3600

TRUE_3600
	ADD R2, R2, #1
END_TRUE_3600


;HINT Restore
LD R0, BACKUP_R0_3600
LD R1, BACKUP_R1_3600
LD R3, BACKUP_R3_3600
LD R4, BACKUP_R4_3600
LD R5, BACKUP_R5_3600
LD R6, BACKUP_R6_3600
LD R7, BACKUP_R7_3600

RET
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xB600
BACKUP_R0_3600 .BLKW #1
BACKUP_R1_3600 .BLKW #1
BACKUP_R2_3600 .BLKW #1
BACKUP_R3_3600 .BLKW #1
BACKUP_R4_3600 .BLKW #1
BACKUP_R5_3600 .BLKW #1
BACKUP_R6_3600 .BLKW #1
BACKUP_R7_3600 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.org x3800

;HINT back up 
ST R0, BACKUP_R0_3800		;Stores registers temporarily. 
ST R1, BACKUP_R1_3800
ST R2, BACKUP_R2_3800
ST R3, BACKUP_R3_3800
ST R4, BACKUP_R4_3800
ST R5, BACKUP_R5_3800
ST R6, BACKUP_R6_3800
ST R7, BACKUP_R7_3800


LD R0, BUSYNESS_ADDR_NUM_BUSY_MACHINES
LDR R0, R0, #0
AND R1, R1, x0
LD R2, CHECK_SLOT_3800
LD R3, SLOTS_3800

CHECK_LOOP_3800
	AND R4, R0, R2
	BRnp FALSE_CONDITION_3800
	ADD R1, R1, #1
	FALSE_CONDITION_3800
	ADD R0, R0, R0
	ADD R3, R3, #-1
	BRp CHECK_LOOP_3800
END_CHECK_LOOP_3800


;HINT Restore
LD R0, BACKUP_R0_3800
LD R2, BACKUP_R2_3800
LD R3, BACKUP_R3_3800
LD R4, BACKUP_R4_3800
LD R5, BACKUP_R5_3800
LD R6, BACKUP_R6_3800
LD R7, BACKUP_R7_3800

RET
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xB600
CHECK_SLOT_3800		.FILL x8000
SLOTS_3800			.FILL #16
BACKUP_R0_3800 .BLKW #1
BACKUP_R1_3800 .BLKW #1
BACKUP_R2_3800 .BLKW #1
BACKUP_R3_3800 .BLKW #1
BACKUP_R4_3800 .BLKW #1
BACKUP_R5_3800 .BLKW #1
BACKUP_R6_3800 .BLKW #1
BACKUP_R7_3800 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.org x4000

;HINT back up 
ST R0, BACKUP_R0_4000		;Stores registers temporarily. 
ST R1, BACKUP_R1_4000
ST R2, BACKUP_R2_4000
ST R3, BACKUP_R3_4000
ST R4, BACKUP_R4_4000
ST R5, BACKUP_R5_4000
ST R6, BACKUP_R6_4000
ST R7, BACKUP_R7_4000


LD R0, BUSYNESS_ADDR_NUM_FREE_MACHINES
LDR R0, R0, #0
AND R1, R1, x0
LD R2, CHECK_SLOT_4000
LD R3, SLOTS_4000

CHECK_LOOP_4000
	AND R4, R0, R2
	BRz FALSE_CONDITION_4000
	ADD R1, R1, #1
	FALSE_CONDITION_4000
	ADD R0, R0, R0
	ADD R3, R3, #-1
	BRp CHECK_LOOP_4000
END_CHECK_LOOP_4000


;HINT Restore
LD R0, BACKUP_R0_4000
LD R2, BACKUP_R2_4000
LD R3, BACKUP_R3_4000
LD R4, BACKUP_R4_4000
LD R5, BACKUP_R5_4000
LD R6, BACKUP_R6_4000
LD R7, BACKUP_R7_4000

RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xB600
CHECK_SLOT_4000		.fill x8000
SLOTS_4000			.FILL #16
BACKUP_R0_4000 .BLKW #1
BACKUP_R1_4000 .BLKW #1
BACKUP_R2_4000 .BLKW #1
BACKUP_R3_4000 .BLKW #1
BACKUP_R4_4000 .BLKW #1
BACKUP_R5_4000 .BLKW #1
BACKUP_R6_4000 .BLKW #1
BACKUP_R7_4000 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.org x4200

;HINT back up 
ST R0, BACKUP_R0_4200		;Stores registers temporarily. 
ST R1, BACKUP_R1_4200
ST R2, BACKUP_R2_4200
ST R3, BACKUP_R3_4200
ST R4, BACKUP_R4_4200
ST R5, BACKUP_R5_4200
ST R6, BACKUP_R6_4200
ST R7, BACKUP_R7_4200


AND R2, R2, x0
AND R3, R3, x0
ADD R3, R3, #1
LD R0, BUSYNESS_ADDR_MACHINE_STATUS
LDR R0, R0, #0

MASK_LOOP
	ADD R3, R3, R3
	ADD R1, R1, #-1
	BRp MASK_LOOP

AND R0, R0, R3
BRz BUSY_CONDITION

ADD R2, R2, #1

BUSY_CONDITION


;HINT Restore
LD R0, BACKUP_R0_4200
LD R1, BACKUP_R1_4200
LD R3, BACKUP_R3_4200
LD R4, BACKUP_R4_4200
LD R5, BACKUP_R5_4200
LD R6, BACKUP_R6_4200
LD R7, BACKUP_R7_4200

RET
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS .Fill xB600
BACKUP_R0_4200 .BLKW #1
BACKUP_R1_4200 .BLKW #1
BACKUP_R2_4200 .BLKW #1
BACKUP_R3_4200 .BLKW #1
BACKUP_R4_4200 .BLKW #1
BACKUP_R5_4200 .BLKW #1
BACKUP_R6_4200 .BLKW #1
BACKUP_R7_4200 .BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.org x4400

;HINT back up 
ST R0, BACKUP_R0_4400		;Stores registers temporarily. 
ST R1, BACKUP_R1_4400
ST R2, BACKUP_R2_4400
ST R3, BACKUP_R3_4400
ST R4, BACKUP_R4_4400
ST R5, BACKUP_R5_4400
ST R6, BACKUP_R6_4400
ST R7, BACKUP_R7_4400


LD R0, BUSYNESS_ADDR_FIRST_FREE
LDR R0, R0, #0
AND R1, R1, x0
AND R2, R2, x0
ADD R2, R2, #1
LD R5, SLOTS_4400

CHECK_LOOP_4400
	AND R4, R0, R2
	BRz CONTINUE_CONDITION_4400
	BR END_CHECK_LOOP_4400
	
	CONTINUE_CONDITION_4400
	
	ADD R1, R1, #1
	ADD R2, R2, R2
	ADD R5, R5, #-1
	BRp CHECK_LOOP_4400
	
	AND R1, R1, x0
	ADD R1, R1, #-1
END_CHECK_LOOP_4400


;HINT Restore
LD R0, BACKUP_R0_4400
LD R2, BACKUP_R2_4400
LD R3, BACKUP_R3_4400
LD R4, BACKUP_R4_4400
LD R5, BACKUP_R5_4400
LD R6, BACKUP_R6_4400
LD R7, BACKUP_R7_4400

RET
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xB600
SLOTS_4400		.FILL #16
BACKUP_R0_4400 .BLKW #1
BACKUP_R1_4400 .BLKW #1
BACKUP_R2_4400 .BLKW #1
BACKUP_R3_4400 .BLKW #1
BACKUP_R4_4400 .BLKW #1
BACKUP_R5_4400 .BLKW #1
BACKUP_R6_4400 .BLKW #1
BACKUP_R7_4400 .BLKW #1


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.org x4600

ST R0, BACKUP_R0_4600		;Stores registers temporarily. 
ST R1, BACKUP_R1_4600
ST R2, BACKUP_R2_4600
ST R3, BACKUP_R3_4600
ST R4, BACKUP_R4_4600
ST R5, BACKUP_R5_4600
ST R6, BACKUP_R6_4600
ST R7, BACKUP_R7_4600


BR INTRO_PROMPT
ERROR_PROMPT
	LD R0, newline_4600
	OUT
	LEA R0, Error_msg_2
	PUTS

INTRO_PROMPT
	LEA R0, prompt
	PUTS
	
AND R0, R0, x0
AND R1, R1, x0
AND R2, R2, x0
AND R3, R3, x0
AND R4, R4, x0
ADD R4, R4, #-1


CHARACTER_LOOP
	GETC
	OUT
	
	LD R6, SUB_VALIDATE_INPUT_PTR
	JSRR R6
	
	ADD R3, R3, #0
	BRn END_CHAR_INPUT
	BRz ERROR_PROMPT
	
	ADD R2, R2, #1
	ADD R5, R2, #-5
	BRzp LOOP_SIGN_CHECK
	BR CHARACTER_LOOP
	
	LOOP_SIGN_CHECK
		ADD R4, R4, #0
		BRn END_CHARACTER_LOOP
		
		ADD R5, R2, #-6
		BRn CHARACTER_LOOP
END_CHARACTER_LOOP


LD R0, newline_4600
OUT

END_CHAR_INPUT

NEG_CHECK
	ADD R4, R4, #0
	BRnz END_NEG_CHECK
	NOT R1, R1
	ADD R1, R1, #1
END_NEG_CHECK

BOUNDS_CHECK
	ADD R2, R1, #-12
	ADD R2, R2, #-3
	BRnz END_BOUNDS_CHECK
	BR ERROR_PROMPT
END_BOUNDS_CHECK


LD R0, BACKUP_R0_4600
LD R2, BACKUP_R2_4600
LD R3, BACKUP_R3_4600
LD R4, BACKUP_R4_4600
LD R5, BACKUP_R5_4600
LD R6, BACKUP_R6_4600
LD R7, BACKUP_R7_4600

RET
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
BACKUP_R0_4600 .BLKW #1
BACKUP_R1_4600 .BLKW #1
BACKUP_R2_4600 .BLKW #1
BACKUP_R3_4600 .BLKW #1
BACKUP_R4_4600 .BLKW #1
BACKUP_R5_4600 .BLKW #1
BACKUP_R6_4600 .BLKW #1
BACKUP_R7_4600 .BLKW #1
SUB_VALIDATE_INPUT_PTR	.FILL  x5200
newline_4600	.FILL '\n'
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------

;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.org x4800

ST R0, BACKUP_R0_4800		;Stores registers temporarily. 
ST R1, BACKUP_R1_4800
ST R2, BACKUP_R2_4800
ST R3, BACKUP_R3_4800
ST R4, BACKUP_R4_4800
ST R5, BACKUP_R5_4800
ST R6, BACKUP_R6_4800
ST R7, BACKUP_R7_4800


ADD R1, R1, #-10
BRzp TEN_CONDITION_4800
ADD R1, R1, #10
BR END_TEN_CONDITION_4800

TEN_CONDITION_4800
	LD R0, ONE_4800
	OUT
END_TEN_CONDITION_4800

ADD R1, R1, #12
ADD R1, R1, #12
ADD R1, R1, #12
ADD R1, R1, #12

ADD R0, R1, #0
OUT



LD R0, BACKUP_R0_4800
LD R1, BACKUP_R1_4800
LD R2, BACKUP_R2_4800
LD R3, BACKUP_R3_4800
LD R4, BACKUP_R4_4800
LD R5, BACKUP_R5_4800
LD R6, BACKUP_R6_4800
LD R7, BACKUP_R7_4800

RET
;--------------------------------
;Data for subroutine print number
;--------------------------------
BACKUP_R0_4800 .BLKW #1
BACKUP_R1_4800 .BLKW #1
BACKUP_R2_4800 .BLKW #1
BACKUP_R3_4800 .BLKW #1
BACKUP_R4_4800 .BLKW #1
BACKUP_R5_4800 .BLKW #1
BACKUP_R6_4800 .BLKW #1
BACKUP_R7_4800 .BLKW #1
ONE_4800  .FILL '1'


.ORIG x5000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_VALIDATE_INPUT
; Inputs: 
; Postcondition: 
; Return Value: 
;-----------------------------------------------------------------------------------------------------------------

;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.org x5200

ST R0, BACKUP_R0_5200		;Stores registers temporarily. 
ST R1, BACKUP_R1_5200
ST R2, BACKUP_R2_5200
ST R3, BACKUP_R3_5200
ST R4, BACKUP_R4_5200
ST R5, BACKUP_R5_5200
ST R6, BACKUP_R6_5200
ST R7, BACKUP_R7_5200

ADD R2, R2, #0
BRnp END_FIRST_CHARACTER_VALIDATION_5200
FIRST_CHARACTER_VALIDATION_5200
	AND R4, R4, x0
	
	FIRST_ENTER_CHECK_5200
		LD R5, newline_5200
		NOT R5, R5
		ADD R5, R5, #1
		ADD R0, R0, R5
		BRnp FIRST_NEG_CHECK_5200
		
		AND R3, R3, x0
		BR END_VALIDATION_5200
	
	FIRST_NEG_CHECK_5200
		LD R0, BACKUP_R0_5200
		LD R5, NEG_SIGN_5200
		NOT R5, R5
		ADD R5, R5, #1
		ADD R0, R0, R5
		BRnp FIRST_POS_CHECK_5200
		
		;LD R0, newline_5200
		;OUT
		ADD R4, R4, #1
		AND R3, R3, x0
		BR END_VALIDATION_5200
		
	FIRST_POS_CHECK_5200
		LD R0, BACKUP_R0_5200
		LD R5, POS_SIGN_5200
		NOT R5, R5
		ADD R5, R5, #1
		ADD R0, R0, R5
		BRnP END_CHECKS_5200
		
		AND R3, R3, x0
		ADD R3, R3, #1
		BR END_VALIDATION_5200
		
	END_CHECKS_5200
	ADD R4, R4, #-1
	
END_FIRST_CHARACTER_VALIDATION_5200

ENTER_CHECK_5200
	LD R0, BACKUP_R0_5200
	LD R5, newline_5200
	NOT R5, R5
	ADD R5, R5, #1
	ADD R0, R0, R5
	BRnp NUMBER_CHECK_5200
	
	ADD R2, R2, #-1
	BRnp VALID_ENTER_INPUT_5200
	
	ADD R4, R4, #0
	BRn VALID_ENTER_INPUT_5200
	
	AND R3, R3, x0
	BR END_VALIDATION_5200
	
	VALID_ENTER_INPUT_5200
	AND R3, R3, x0
	ADD R3, R3, #-1
	BR END_VALIDATION_5200
	
NUMBER_CHECK_5200
	LD R0, BACKUP_R0_5200
	LD R5, CHAR_0_5200
	NOT R5, R5
	ADD R5, R5, #1
	ADD R0, R0, R5
	BRn NUMBER_CHECK_5200
	
	LD R0, BACKUP_R0_5200
	LD R5, CHAR_9_5200
	NOT R5, R5
	ADD R5, R5, #1
	ADD R0, R0, R5
	BRp NUMBER_CHECK_ERROR_5200
	
	ADD R0, R1, #0
	LD R5, DEC_9_5200
	MULTIPLY_BY_10_LOOP_5000
		ADD R1, R0, R1
		ADD R5, R5, #-1
		BRp MULTIPLY_BY_10_LOOP_5000
	
	LD R0, BACKUP_R0_5200
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R1, R0, R1
	AND R3, R3, x0
	ADD R3, R3, #1
	BR END_VALIDATION_5200
	
	NUMBER_CHECK_ERROR_5200
		;LD R0, newline_5200
		;OUT
		AND R3, R3, x0
		
END_VALIDATION_5200
		



LD R0, BACKUP_R0_5200
LD R2, BACKUP_R2_5200
LD R5, BACKUP_R5_5200
LD R6, BACKUP_R6_5200
LD R7, BACKUP_R7_5200

RET
;--------------------------------
;Data for subroutine print number
;--------------------------------
BACKUP_R0_5200 .BLKW #1
BACKUP_R1_5200 .BLKW #1
BACKUP_R2_5200 .BLKW #1
BACKUP_R3_5200 .BLKW #1
BACKUP_R4_5200 .BLKW #1
BACKUP_R5_5200 .BLKW #1
BACKUP_R6_5200 .BLKW #1
BACKUP_R7_5200 .BLKW #1
newline_5200	.FILL '\n'
NEG_SIGN_5200	.FILL '-'
POS_SIGN_5200	.FILL '+'
CHAR_0_5200	.FILL '0'
CHAR_9_5200	.FILL '9'
DEC_9_5200	.FILL #9





.ORIG xB600			; Remote data
BUSYNESS .FILL xABCD		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END

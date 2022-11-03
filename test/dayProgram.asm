ORG 	00H
MOV	SP, #70H
MOV 	PSW, #00H
RS	EQU P3.3
RW 	EQU P3.4
ENBL	EQU P3.5
mov r0,#0h
mov r1,#0h
mov r2,#0h
mov r3,#0h
mov r4,#0h
mov r5,#0h
mov r6,#0h
mov r7,#0h

		MOV	A, #38H			;init. LCD 2 lines, 5x7 matrix
		LCALL	COMMAND		;call command subroutine
		LCALL DELAY			;give LCD some time
		MOV 	A, #0EH			;dispplay on, cursor on
		LCALL	COMMAND		;call command subroutine
		LCALL 	DELAY			;give LCD some time
		MOV	A, #01			;clear LCD
		LCALL	COMMAND		;call command subroutine
		LCALL 	DELAY			;give LCD some time
		MOV	A, #06H			;shift cursor right
		LCALL	COMMAND		;call command subroutine
		LCALL 	DELAY			;give LCD some time
		MOV	A, #82H			;cursor at line 1 postion 1
		LCALL	COMMAND		;call command subroutine
		LCALL DELAY			;give LCD some time
		ACALL 	DELAY
		MOV DPTR, #MSG_1
		mov 43h, dpl
start:

		MOV A, #082H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOV	A,#3ah
		LCALL 	DISPLAY
		LCALL 	DELAY
		
		
		mov 41h,#0c2H
		
		
		mov 40h,#3
l1:		MOV A, 41h
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOVC 	A,@A+DPTR
		mov r0,dpl
		inc r0
		jz FINISH
		LCALL 	DISPLAY
		LCALL 	DELAY
		mov dpl,r0
		inc 41h
		djnz 40h,l1
		
		

sjmp start

FINISH:
		mov dpl,43h
		sjmp l1

		
COMMAND: 	
		LCALL READY
 		MOV P2,A
		CLR P3.3
		CLR P3.4
		SETB P3.5
		ACALL DELAY
		CLR P3.5
		RET
DISPLAY: 		
		LCALL 	READY
		MOV P2, A
		SETB 	RS
	  	CLR 	RW
		SETB 	ENBL
		LCALL 	DELAY
	  	CLR 	ENBL
		RET

READY: 		
		SETB 	P2.7
 		CLR 	RS
  		SETB 	RW
WAIT:		 
		CLR 	ENBL
		ACALL 	DELAY
  		SETB 	ENBL
		JB 	P2.7, WAIT
   		RET
DELAY:		 
		MOV 	R5, #50
AGAIN_2: 	
		MOV 	R4, #255
AGAIN: 		
		DJNZ 	R4, AGAIN
		DJNZ R5, AGAIN_2
		RET
		
MSG_1: 		
		DB 'satsunmontuewedthufri',0
		END

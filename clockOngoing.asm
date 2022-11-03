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
			
		MOV A, #084H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOV	A,#3ah
		LCALL 	DISPLAY
		LCALL 	DELAY
		
		MOV A, #087H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOV	A,#3ah
		LCALL 	DISPLAY
		LCALL 	DELAY
		
start:		MOV DPTR, #MSG_1
LOOP_1: 	
		MOV A, #082H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOVC 	A,@A+DPTR
		mov P1,a
		mov r0,dpl
		jz FINISH_12
		LCALL 	DISPLAY
		LCALL 	DELAY
		inc r0
		

 	
		mov dptr, #MSG_2
LOOP_2: 	
		MOV A, #083H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOVC 	A,@A+DPTR
		mov r1,dpl
		jz FINISH_21
		cjne a,#34h,check_four
		mov a,P1
		cjne a,#32h,check_four
		ljmp start
check_four:	LCALL 	DISPLAY
		LCALL 	DELAY
		sjmp a1
FINISH_12:	ljmp FINISH_1
a1:		
;		min loop start
		mov dptr, #MSG_2
min1:
		MOV A, #085H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOVC 	A,@A+DPTR
		cjne a,#36h,check_six
		sjmp minend
check_six:	mov b,a
		mov r2,dpl
		LCALL 	DISPLAY
		LCALL 	DELAY
		
		sjmp a2
FINISH_21:	ljmp FINISH_2
a2:		

		
secend:		inc r2
		mov dptr, #MSG_2
min2:
		MOV A, #086H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOVC 	A,@A+DPTR
		mov r3,dpl
		jz minFINISH_3
		
		LCALL 	DISPLAY
		LCALL 	DELAY
		
		
;		second loop start
		mov dptr, #MSG_3
sec1:
		MOV A, #088H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOVC 	A,@A+DPTR
		cjne a,#36h,check_six_sec
		sjmp second
check_six_sec:	mov b,a
		mov r6,dpl
		LCALL 	DISPLAY
		LCALL 	DELAY
		inc r6
		mov dptr, #MSG_3
sec2:
		MOV A, #089H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOVC 	A,@A+DPTR
		mov r7,dpl
		jz secFINISH_3
		
		LCALL 	DISPLAY
		LCALL 	DELAY	;call another delay here like delaysec and calculate this delay to make it 1 sec... and primary code will be done
		inc r7
		mov dpl,r7
		ljmp sec2
secFINISH_3: 
		mov dpl,r6
		ljmp sec1
		
second:		;sec END
		inc r3
		mov dpl,r3
		ljmp min2
minFINISH_3: 
		mov dpl,r2
		ljmp min1
		
		;min END
minend:		inc r1
		mov dpl,r1
		ljmp LOOP_2


FINISH_2: 
		mov dpl,r0
		ljmp LOOP_1
FINISH_1:
		ljmp start
		
		
COMMAND: 	
		LCALL READY
 		MOV P0,A
		CLR P3.3
		CLR P3.4
		SETB P3.5
		ACALL DELAY
		CLR P3.5
		RET
DISPLAY: 		
		LCALL 	READY
		MOV P0, A
		SETB 	RS
	  	CLR 	RW
		SETB 	ENBL
		LCALL 	DELAY
	  	CLR 	ENBL
		RET

READY: 		
		SETB 	P0.7
 		CLR 	RS
  		SETB 	RW
WAIT:		 
		CLR 	ENBL
		ACALL 	DELAY
  		SETB 	ENBL
		JB 	P0.7, WAIT
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
		DB "012",0

MSG_2:		 
		DB "0123456789",0
		
MSG_3:		 
		DB "0123456789",0
		END

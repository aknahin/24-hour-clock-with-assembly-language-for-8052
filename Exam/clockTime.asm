ORG 	00H
MOV	SP, #70H
MOV 	PSW, #00H
RS	EQU P2.5
RW 	EQU P2.6
ENBL	EQU P2.7

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

mov r0,#50h
mov r4,#2
; Keyboard   function
keyboard:
	MOV A,#0FH
	MOV P3,A
K1: 	MOV P3,#00001111B
	MOV A,P3
	ANL A,#00001111B
	CJNE A,#00001111B,K1

K2: 	ACALL DELAY
	MOV A,P3
	ANL A,#00001111B
	CJNE A,#00001111B,OVER
	SJMP K2

OVER: ACALL DELAY
	MOV A,P3
	ANL A,#00001111B
	CJNE A,#00001111B,OVER1
	SJMP K2

OVER1: 	MOV P3,#11101111B
	MOV A,P3
	ANL A,#00001111B
	CJNE A,#00001111B,ROW_0
	MOV P3,#11011111B
	MOV A,P3
	ANL A,#00001111B
	CJNE A,#00001111B,ROW_1
	MOV P3,#01111111B
	MOV A,P3
	ANL A,#00001111B
	CJNE A,#00001111B,ROW_2
	MOV P3,#10111111B
	MOV A,P3
	ANL A,#00001111B
	CJNE A,#00001111B,ROW_3
	;LJMP K2
	
ROW_0: 	MOV DPTR,#KCODE0
	SJMP FIND
ROW_1: 	MOV DPTR,#KCODE1
	SJMP FIND
ROW_2: 	MOV DPTR,#KCODE2
	SJMP FIND
ROW_3: 	MOV DPTR,#KCODE3

FIND: 	RRC A
	JNC MATCH
	INC DPTR
	SJMP FIND
	
MATCH: 	CLR A
	MOVC A,@A+DPTR
	CJNE A, #99H, ON_AC
	MOV A,#01
	ACALL COMMAND
	ACALL DELAY
	;LJMP K1
ON_AC: 	ACALL DISPLAY
	ACALL DELAY
	mov @r0,a
	inc r0
	cjne r0, #56h, keyboard
	;LJMP K1
mov r0,50h	;h1
mov r1,51h	;h0
mov r2,52h	;m1
mov r3,53h	;m0
mov r6,54h	;s1
mov r7,55h	;s0

mov r4,#0h
mov r5,#0h
mov 32h,#0h
setb p2.0
		
			
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
		MOV DPTR, #day
		mov 43h, dpl
		mov 32h,dpl
		; day as extra feature
		MOV DPTR, #day
		mov 41h,#0c2H
		mov 40h,#3
l12:		MOV A, 41h
		mov dpl,32h
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOVC 	A,@A+DPTR
		mov 32h,dpl
		inc 32h
		jz dayFINISH
		LCALL 	DISPLAY
		LCALL 	DELAY
		inc 41h
		djnz 40h,l12
		
start:		
LOOP_1: 	MOV DPTR, #MSG_1
		MOV A, #082H
		ACALL 	COMMAND
		ACALL 	DELAY
			
		CLR 	A
		mov a, r0
		MOVC 	A,@A+DPTR
		mov 30h,a
		;mov r0,dpl
		jz FINISH_12
		LCALL 	DISPLAY
		LCALL 	DELAY
		inc r0
		

 	
		
LOOP_2: 	mov dptr, #MSG_2
		MOV A, #083H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		mov a, r1
		MOVC 	A,@A+DPTR
		;mov r1,dpl
		jz FINISH_21
		mov 31h,a
		cjne a,#34h,check_four
		mov a,30h
		cjne a,#32h,check_four
		
		; day as extra feature
		MOV DPTR, #day
		mov 41h,#0c2H
		mov 40h,#3
l1:		MOV A, 41h
		mov dpl,32h
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		MOVC 	A,@A+DPTR
		mov 32h,dpl
		inc 32h
		jz dayFINISH
		LCALL 	DISPLAY
		LCALL 	DELAY
		inc 41h
		djnz 40h,l1
		
		ljmp start
dayFINISH:
		mov 32h,43h
		sjmp l1
		
check_four:	
		clr p2.0
		lcall DELAYsec
		setb p2.0
		mov a,31h
		LCALL 	DISPLAY
		LCALL 	DELAY
		sjmp a1
FINISH_12:	ljmp FINISH_1
a1:		
;		min loop start
		
min1:		mov dptr, #MSG_2
		MOV A, #085H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		mov a,r2
		MOVC 	A,@A+DPTR
		cjne a,#36h,check_six
		sjmp minend
check_six:	mov b,a
		;mov r2,dpl
		LCALL 	DISPLAY
		LCALL 	DELAY
		
		sjmp a2
FINISH_21:	ljmp FINISH_2
a2:		

		
secend:		inc r2
		
min2:		mov dptr, #MSG_2
		MOV A, #086H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		mov a,r3
		MOVC 	A,@A+DPTR
		;mov r3,dpl
		jz minFINISH_3
		
		LCALL 	DISPLAY
		LCALL 	DELAY
		
		
;		second loop start
		
sec1:		mov dptr, #MSG_3
		MOV A, #088H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		mov a,r6
		MOVC 	A,@A+DPTR
		cjne a,#36h,check_six_sec
		sjmp second
check_six_sec:	mov b,a
		;mov r6,dpl
		LCALL 	DISPLAY
		LCALL 	DELAY
		inc r6
		
sec2:		mov dptr, #MSG_3
		MOV A, #089H
		ACALL 	COMMAND
		ACALL 	DELAY	
		CLR 	A
		mov a,r7
		MOVC 	A,@A+DPTR
		;mov r7,dpl
		jz secFINISH_3
		
		LCALL 	DISPLAY
		LCALL 	DELAYsec	;call another delay here like delaysec and calculate this delay to make it 1 sec... and primary code will be done
		inc r7
		;mov dpl,r7
		ljmp sec2
secFINISH_3: 
		mov r7, #0h
		;mov dpl,r6
		ljmp sec1
		
second:		;sec END
		mov r6,#0h
		inc r3
		;mov dpl,r3
		ljmp min2
minFINISH_3: 
		mov r3,#0h
		;mov dpl,r2
		ljmp min1
		
		;min END
minend:		
		mov r2,#0h
		inc r1
		;mov dpl,r1
		ljmp LOOP_2


FINISH_2: 
		mov r1,#0h
		;mov dpl,r0
		ljmp LOOP_1
FINISH_1:	
		mov r1,#0h
		mov r0, #0h
		ljmp start
		
		
COMMAND: 	
		LCALL READY
 		MOV P0,A
		CLR RS
		CLR RW
		SETB ENBL
		ACALL DELAY
		CLR ENBL
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
AGAIN_21: 	
		MOV 	R4, #100
AGAIN11: 		
		DJNZ 	R4, AGAIN11
		DJNZ R5, AGAIN_21
		RET
		
DELAYsec:		
		mov 45h, #10
AGAIN_3: 
		MOV 	R5, #200
AGAIN_2: 	
		MOV 	R4, #220
AGAIN: 		
		DJNZ 	R4, AGAIN
		DJNZ R5, AGAIN_2
		djnz 45h,AGAIN_3
		RET
		
MSG_1: 		
		DB "012",0

MSG_2:		 
		DB "0123456789",0
		
MSG_3:		 
		DB "0123456789",0
day:
		DB 'thufrisatsunmontuewed',0
		
KCODE3: DB 7,8,9,'I' ;ROWnumber 0
KCODE1: DB 4,5,6,'U' ;ROWnumber 1
KCODE0: DB 1,2,3,'T' ;ROWnumber 2
KCODE2: DB 99H,0,'=','+' ;ROWnumber 3

		END

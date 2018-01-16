TITLE		Lab02CK
;Programmer:  Your Name here...just kidding. Christopher King
;Due: 		  Friday Feb 26th 
;Description: This program adds up numbers read from the keyboard then subtracts
;				a constant from that number. That number is then displayed to the
;				screen with the date
			INCLUDE PCMAC.INC; includes the book MACROS
			.MODEL SMALL
			.386
			.STACK 64 ;sts the size of the stack
			
			
;====================================================
			.DATA
 		
CONSTANT	EQU		100
prompt		DB		"Please Enter A Number", 13, 10, "$"
separator	DB		"===========================", 13, 10, "$"
heading		DB		"Constant - Sum Report", 13, 10, "$"
answerLine  DB		 13, 10, "Answer:", "$"

;====================================================
			.CODE
			EXTRN	GetDec:NEAR, PutDec:NEAR
Main		PROC	NEAR
			mov		ax, @data	;this instruction and the next one
			mov		ds, ax		;	initialize the data segment register
		
			call 	GetNumber	;gets number
			call	AddNewNum   ;adds gotten number to existing amount 
			call 	GetNumber	;gets number
			call	AddNewNum   ;adds gotten number to existing amount 
			call 	GetNumber	;gets number
			call	AddNewNum   ;adds gotten number to existing amount 
			call 	GetNumber	;gets number
			call	AddNewNum   ;adds gotten number to existing amount 
			
			call	CalcResult	;takes the added up number and subtracts the 
								;	const from it
			call	DispRpt		;Displays the calculated number to the screen
								;	along with the date		
done:
			mov		ax, 4C00h	;set up return code to the op sys
			int		21h			;end execution and return control to the op sys

Main		ENDP

;====================================================			
;reads a number from keyboard to ax. ax and dx are modified
GetNumber		PROC	NEAR
			_PutStr prompt		;Displays the Prompt
			call 	GetDec				;Reads in a number
			
			ret					;jump back to calling procedure
GetNumber		ENDP

;====================================================			
;adds ax to bx. to be used after reading in a new value
AddNewNum		PROC	NEAR
			add 	bx, ax		;add the new number to the running total 
			ret					;jump back to calling procedure
AddNewNum		ENDP

;====================================================			
;takes bx and subtracts the constant from it
CalcResult		PROC	NEAR
			; Constant - Added Value = Answer
			mov		ax, CONSTANT;needed so that added val can be subtracted from constant
			sub 	ax, bx		;Constant - Added Value
			mov		bx, ax		;move the answer over because displays modify ax
			ret					;jump back to calling procedure
CalcResult		ENDP

;====================================================

;set up fields needed for string display then performs the display
DispRpt		PROC	NEAR
			_PutStr separator
			_PutStr heading
			_GetDate			;modifies ax(weekday),cx(YYYY),dx(dhMM,dlDD)
			mov 	ah, 00			;clear out ah
			mov 	al, dl			;put DD into al so it can be used by PutDec
			call 	PutDec				;displaying DD
			
			mov ah, 00			;clear out ah
			mov 	al, dh			;put MM into al so it can be used by PutDec
			call	PutDec				;displaying MM
			
			mov 	ax, cx			;put YYYY into al so it can be used by PutDec
			call 	PutDec				;displaying YYYY
			
			_PutStr answerLine  ;Displays "Answer:"
			mov 	ax,bx			;set up for PutDec
			call 	PutDec				;displaying the answer
			
			ret					;jump back to calling procedure
DispRpt		ENDP

			END		Main		;specifies procedure to execute first








			
			
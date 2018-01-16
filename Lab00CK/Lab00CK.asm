TITLE		Lab00CK
;Programmer:  Your Name here...just kidding. Christopher King
;Due: 		  Friday Feb 12th 
;Description: This program illustrates procedures, assignment, add, and display
			
			.MODEL SMALL
			.386
			.STACK 64 ;sts the size of the stack
			
;====================================================
			.DATA
msgout		DB		'Hello, World', 13, 10, '$'
someNum		DW		209
answer		DW		?

;====================================================
			.CODE
Main		PROC	NEAR
			mov		ax, @data	;this instruction and the next one
			mov		ds, ax		;	initialize the data segment register
		
			call 	DoCalcs		;perform the procedure to compute values
			
			call 	DispMsg		;perform the procedure to display to the screen
done:
			mov		ax, 4C00h	;set up return code to the op sys
			int		21h			;end execution and return control to the op sys

Main		ENDP

;====================================================
			
;Move a number from memory into a register then sum it with a constant value
DoCalcs		PROC	NEAR
			mov		ax,someNum		;prepare for add
			mov		bx, -11			
			add		ax, bx			;add initial num and chosen constant
			mov		answer, ax		;store result in memory for dump
			ret						;jump back to calling procedure
DoCalcs		ENDP

;====================================================

;set up fields needed for string display then performs the display
DispMsg		PROC	NEAR
			mov		dx, OFFSET msgOut	;move message to display into place
			mov		ah, 09h				;set up code for sting display
			int		21h					;call to perform sting display
			ret							;jump back to calling procedure
DispMsg		ENDP

			END		Main				;specifies procedure to execute first








			
			
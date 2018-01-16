TITLE		Lab02CK
;Programmer:  Your Name here...just kidding. Christopher King
;Due: 		  Friday Mar 4th 
;Description: This program tracks a personal budget. It calculates your monthly savings
;				from your expenses, income, taxes, and TSA
			INCLUDE PCMAC.INC; includes the book MACROS
			.MODEL SMALL
			.386
			.STACK 64 ;sts the size of the stack
			
			
;====================================================
			.DATA
memStart	DB		"MEM STARTS HERE!!!!!!!"
;answers
normPay		DW		?
overPay		DW		?
grossPay	DW		?
netPay		DW		?
totExp		DW		?
newSavings	DW		?
;Income
totHours	EQU		50
regHours	EQU		35
hourRate	DB		13
ovrTimeX	DW		2
;Withholding
fedTaxes	DW		75
sttTaxes	EQU		35
TSAContr	EQU		55
;Expenses
cable		EQU		25
phone		EQU		75
util		EQU		65
rent		EQU		225
;savings from last month
savings		EQU		0


;====================================================
			.CODE
			EXTRN	GetDec:NEAR, PutDec:NEAR
Main		PROC	NEAR
			mov		ax, @data		;this instruction and the next one
			mov		ds, ax			;	initialize the data segment register
			
			call 	CalcNormPay		;normPay left in ax
			call 	CalcOverPay		;calculate the over time pay
			call 	CalcGrossPay	;calculate the gross pay	
			call 	CalcWithholding ;calculate the total withholding
			call	CalcExpenses	;calculate the total expenses
			call	CalcSavings		;calculates the total savings, factoring in last months values
		
done:
			mov		ax, 4C00h		;set up return code to the op sys
			int		21h				;end execution and return control to the op sys

Main		ENDP


;====================================================			
;
CalcNormPay		PROC	NEAR
			mov		al, regHours; move the regular hours into al
			mul		hourRate	;multiply the regular hours by the hourly rate
			mov		normPay, ax ;save the multiplied value in memory
			mov		bx, ax		;move normal pay aside so it wont have to be reloaded
			
			ret					;jump back to calling procedure
CalcNormPay		ENDP

;====================================================			
;
CalcOverPay		PROC	NEAR
			mov		al, totHours; move the total hours into al
			sub		al, reghours ; subract total - regular to get the overtime hours
			mul		hourRate	;multiply the overtime hours by the hourly rate
			mul		ovrTimeX	;multiply the overtime pay by the overtime multiplier
			mov		overPay, ax ;save the multiplied value in memory
			
			ret					;jump back to calling procedure
CalcOverPay		ENDP

;====================================================
;adds normal pay to the overtime pay
CalcGrossPay		PROC	NEAR
			add		grossPay, ax
			add		grossPay, bx
			mov		bx, grossPay	;save gross pay for calcWithholding
			
			ret					;jump back to calling procedure
CalcGrossPay		ENDP

;====================================================
;subtracts taxes from pay
CalcWithholding		PROC	NEAR
			mov		ax, fedTaxes	;prepare for add
			add		ax, sttTaxes	;add state taxes to federal taxes
			add		ax, TSAContr	;add TSA contribution to total
			sub		bx, ax			;subtract Total from Gross Pay
			mov		netPay, bx		;save netPay
		
			ret					;jump back to calling procedure
CalcWithholding		ENDP

;====================================================
;sums up expenses
CalcExpenses			PROC	NEAR
			mov		ax, cable	;prepare for add
			add		ax, phone	;add phone to total
			add		ax, util	;add utilities  to total
			add		ax, rent
			mov		totExp, ax		;save total expenses

	
			ret					;jump back to calling procedure
CalcExpenses		ENDP

;====================================================
;sums up expenses
CalcSavings			PROC	NEAR
			sub		bx, ax		;subtract expenses from net pay
			add		bx, savings	;add savings from last month
			
			mov		newSavings, bx		;save new total savings

	
			ret					;jump back to calling procedure
CalcSavings		ENDP

;====================================================


			END		Main		;specifies procedure to execute first








			
			
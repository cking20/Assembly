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
totHours	EQU		52
regHours	EQU		40
hourRate	DB		14
ovrTimeX	DW		2
;Withholding
fedTaxes	DW		85
sttTaxes	EQU		60
TSAContr	EQU		75
;Expenses
cable		EQU		82
phone		EQU		80
util		EQU		302
rent		EQU		230
;savings from last month
savings		EQU		290


;====================================================
			.CODE
			EXTRN	GetDec:NEAR, PutDec:NEAR
Main		PROC	NEAR
			mov		ax, @data		;this instruction and the next one
			mov		ds, ax			;	initialize the data segment register
			
			call 	CalcNormPay		;normPay left in ax
			call 	CalcOverPay
			call 	CalcGrossPay
			call 	CalcWithholding
			call	CalcExpenses
			call	CalcSavings
		
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








			
			
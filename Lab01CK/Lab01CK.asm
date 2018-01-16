TITLE		Lab00CK
;Programmer:  Your Name here...just kidding. Christopher King
;Due: 		  Friday Feb 12th 
;Description: This program illustrates procedures, assignment, add, and display
			
			.MODEL SMALL
			.286
			.STACK 64 ;sets the size of the stack
			
;====================================================
			.DATA
memStart		DB		'MEM STARTS HERE!!' ;"!" in hex is 21h
;answers start here
totGrossSales	DW		?
totExpenses		DW		?
netSales		DW		?
profit			DW		?
;answers end here
monSale1		DW		785d
monSale2		DW		842d
monSale3		DW		518d
monOpExp1		DW		268d
monOpExp2		DW		304d
monOpExp3		DW		243d
monPayExp1		DW		179d
monPayExp2		DW		254d
monPayExp3		DW		 97d
quarInvCost 	DW		397d
quarTotRet		DW		217d
memEnd			DB		'!!MEM ENDS HERE'

;====================================================
			.CODE
Main		PROC	NEAR
			mov		ax, @data	;this instruction and the next one
			mov		ds, ax		;	initialize the data segment register. i think i still need this???
			
			call 	CalcTotalGrossSales		;calculates the total gross sales
			call 	CalcTotalExpenses		;calculates the total expenses
			call	CalcNetSales			;calculates the net sales
			call	CalcProfit				;calculates the moolah
done:
			mov		ax, 4C00h	;set up return code to the op sys
			int		21h			;end execution and return control to the op sys

Main		ENDP

;====================================================
			
;moves monthly sales to the registers then adds them one at a time to totGrossSales
CalcTotalGrossSales		PROC	NEAR
					mov		ax, monSale1		;prepare for add
					mov		bx, totGrossSales			
					add		bx, ax				;adds the sale one to the total
					mov		ax, monSale2		;prepare for add
					add		bx, ax				;adds the sale two to the total
					mov		ax, monSale3		;prepare for add
					add		bx, ax				;adds the sale three to the total
					mov		totGrossSales, bx	;store result in memory for dump
					ret							;jump back to calling procedure
CalcTotalGrossSales		ENDP

;====================================================
			
;moves monthly expenses to the registers then adds them one at a time to totExpenses
CalcTotalExpenses	PROC	NEAR
					
					mov		bx, totExpenses		;prepare for add
					mov		ax, monOpExp1		;prepare for add	
					add		bx, ax				;adds the operating expense one to the total
					mov		ax, monOpExp2		;prepare for add
					add		bx, ax				;adds the operating expense two to the total
					mov		ax, monOpExp3		;prepare for add
					add		bx, ax				;adds the operating expense three to the total
					mov		ax, monPayExp1		;prepare for add	
					add		bx, ax				;adds the payroll expense one to the total
					mov		ax, monPayExp2		;prepare for add
					add		bx, ax				;adds the payroll expense two to the total
					mov		ax, monPayExp3		;prepare for add
					add		bx, ax				;adds the payroll expense three to the total
					mov		totExpenses, bx		;store result in memory for dump
					ret							;jump back to calling procedure
CalcTotalExpenses		ENDP

;====================================================
			
;clacs the difference of the total gross sales and the total expenses
CalcNetSales	PROC	NEAR
					mov		ax, totGrossSales
					mov		bx, totExpenses
					sub		ax,bx 				;subtracts totExpenses FROM totGrossSales
					mov		netSales, ax		;moves the subtracted value into netsales
					ret							;jump back to calling procedure
CalcNetSales	ENDP

;====================================================

;clacs the difference of net sales and the sum of the quarterly inventory costs and the quarterly total returns
CalcProfit	PROC	NEAR
					;quarInvCost 	
					;quarTotRet		
					mov		ax, netSales
					mov		bx, quarInvCost
					sub		ax, bx 				;subtracts quarInvCost FROM netSales
					mov		bx, quarTotRet
					sub		ax, bx 				;subtracts quarTotRet FROM netSales
					mov		profit, ax		;moves the subtracted value into profit
					ret							;jump back to calling procedure
CalcProfit	ENDP

;====================================================
			END		Main				;specifies procedure to execute first
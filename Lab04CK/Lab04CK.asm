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
 		
		
prompt		DB		"How much o' trash y'all got der?", 13, 10, "$"
header		DB		13, 10,"			Trashvill Not Nashvill", 13, 10, "			Trash Service Comparison", 13, 10, "$"
cityHead	DB		13, 10,"			City Summary", 13, 10, "Size 	PricePerBag 	Quantity 	Price", 13, 10,"$"
space		DB		"	", "$"
endline		DB		13, 10,"$"
total		DB		"Total:		","$"
remainer 	DB		"Remainder:	","$"
privHead	DB		13, 10,"			Private Summary", 13, 10, "Size 	PricePerBag 	Quantity 	Price", 13, 10,"$"
garbage		DW		?
cityBigBags	DB		40	
cBigPrice	DB		4
cBigCost	DW		?
numBigBags	DB		?	
cityMidBags	DB		24
cMidPrice	DB		3
cMidCost	DW		?
numMidBags	DB		?	
citySmlBags	DB		13
cSmlPrice	DB		2
cSmlCost	DW		?
numSmlBags	DB		?
cityRemain  DB		?
cityTotal	DW		?
	
privBig		DW		250 ;must be word
pBigPrice	DB		25
pBigCost	DW		?
numBigBin	DW		?	
privSml		DB		50
pSmlPrice	DB		8
pSmlCost	DW		?
numSmlBin	DB		?
privRemain  DB		?
privTotal	DW		?


;====================================================
			.CODE
			EXTRN	GetDec:NEAR, PutDec:NEAR
Main		PROC	NEAR
			mov		ax, @data	;this instruction and the next one
			mov		ds, ax		;	initialize the data segment register
			call	GetNumber	;gets the amount of trash from the user
			call	CalcCity	;calculates and displays the city values
			call	DispCity	;Displays the cities info in the table
			call 	CalcPriv	;calculates and displays the private values
			call	DispPriv	;Displays the private info in the table
			
done:
			mov		ax, 4C00h	;set up return code to the op sys
			int		21h			;end execution and return control to the op sys

Main		ENDP

;====================================================			
;reads a number from keyboard to ax. ax and dx are modified
GetNumber		PROC	NEAR
			_PutStr prompt		;Displays the Prompt
			call 	GetDec		;Reads in a number into ax
			mov		garbage,ax
			ret					;jump back to calling procedure
GetNumber		ENDP

;====================================================			
;CITY calculates the amount of big bags the trash will take up 
CalcCity		PROC	NEAR
			_PutStr cityHead	; display the heading
			;calculate the number of each bag needed
			mov 	ax,garbage			; prepare for div 							garbage is a word going into a word size reg. 4237 / 40 = 105R37
			div 	cityBigBags		; divide entered num by big amount			is a word. value of 40 
			mov 	numBigBags,al	; save the number of big bags
			;_PutStr cityHead;TEST!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			mov 	al,ah			; prepare for the next div
			cbw						; prepare for the next div
			div 	cityMidBags		; divide remainder by med amount
			mov 	numMidBags,al	; save the number of med bags
			
			mov 	al,ah			; prepare for the next div
			cbw						; prepare for the next div
			div 	citySmlBags		; divide remainder by small amount
			mov 	numSmlBags,al	; save the number of med bags
			mov		cityRemain,ah   ; save remaining trash
			;calculate the price of each bag type
			
			;BIG BAGS
			mov		al,numBigBags
			mul		cBigPrice
			mov		bx, ax	;saves the amount for a running total
			mov		cBigCost, ax
			;call	PutDec			;prints the big bag cost
			;MID BAGS
			mov		al,numMidBags
			mul		cMidPrice
			add		bx, ax	;adds the amount for a running total
			mov		cMidCost, ax
			;call	PutDec			;prints the mid bag cost
			;SML BAGS
			mov		al,numSmlBags
			mul		cSmlPrice
			add		bx, ax	;adds the amount for a running total
			mov		cityTotal, bx
			mov		cSmlCost, ax
			;call	PutDec			;prints the sml bag cost
			
			
			ret						; jump back to calling procedure
CalcCity		ENDP

;====================================================	
DispCity	PROC	NEAR
		; displays the big bags info
		mov al,cityBigBags
			cbw
			call PutDec
			_PutStr space
			_PutStr space
		mov al,cBigPrice
			cbw
			call PutDec
			_PutStr space
		mov al,numBigBags
			cbw
			call PutDec
			_PutStr space
			_PutStr space
		mov ax,cBigCost
			call PutDec
			_PutStr endline
			; displays the Mid bags info
		mov al,cityMidBags
			cbw
			call PutDec
			_PutStr space
			_PutStr space
		mov al,cMidPrice
			cbw
			call PutDec
			_PutStr space
		mov al,numMidBags
			cbw
			call PutDec
			_PutStr space
			_PutStr space
		mov ax,cMidCost
			call PutDec
			_PutStr endline
		; displays the Sml bags info
		mov al,citySmlBags
			cbw
			call PutDec
			_PutStr space
			_PutStr space
		mov al,cSmlPrice
			cbw
			call PutDec
			_PutStr space
		mov al,numSmlBags
			cbw
			call PutDec
			_PutStr space
			_PutStr space
		mov ax,cSmlCost
			call PutDec
			_PutStr endline
		_PutStr remainer
			mov	al, cityRemain
			cbw
			call PutDec
			_PutStr endline
		;print the total
		_PutStr total
			mov  ax,cityTotal
			call PutDec
			_PutStr endline
			
		
			
			ret
DispCity		ENDP
;====================================================
		
;CITY calculates the amount of big bags the trash will take up 
CalcPriv		PROC	NEAR
			_PutStr privHead	; display the heading
								;calculate the number of each bag needed
			mov 	ax,garbage	; prepare for div move inputted number back into ax
			cwd					;makes garbage a double word
			div 	privBig		; divide entered num by largest amount WORD SIZE
			mov 	numBigBin,ax; save the number of big bags
			mov 	ax,dx			; prepare for the next div
			div 	privSml		; divide remainder by largest amount
			mov 	numSmlBin,al	; save the number of med bags
			mov		privRemain,ah   ; save remaining trash
			;calculate the price of each bag type
			
			;BIG BINS
			mov		ax,numBigBin
			mul		pBigPrice
			mov		bx, ax	;saves the amount for a running total
			mov		pBigCost, ax
			
			
			;SML BAGS
			mov		al,numSmlBin
			mul		pSmlPrice
			add		bx, ax	;adds the amount for a running total
			mov		pSmlCost, ax
			mov		privTotal,bx		
			
			
			
			ret						; jump back to calling procedure
CalcPriv		ENDP
;====================================================


DispPriv		PROC NEAR
		mov ax,privBig
			;cbw
			call PutDec
			_PutStr space
			_PutStr space
		mov al,pBigPrice
			cbw
			call PutDec
			_PutStr space
		mov ax,numBigBin
			;cbw
			call PutDec
			_PutStr space
			_PutStr space
		mov ax,pBigCost
			call PutDec
			_PutStr endline
			; displays the Mid bags info
		mov al,privSml
			cbw
			call PutDec
			_PutStr space
			_PutStr space
		mov al,pSmlPrice
			cbw
			call PutDec
			_PutStr space
		mov al,numSmlBin
			cbw
			call PutDec
			_PutStr space
			_PutStr space
		mov ax,pSmlCost
			call PutDec
			_PutStr endline
		_PutStr remainer
			mov	al, privRemain
			cbw
			call PutDec
			_PutStr endline
		_PutStr total
			mov  ax,privTotal
			call PutDec
			_PutStr endline
			
		ret
DispPriv	ENDP		

;============
			END		Main		;specifies procedure to execute first

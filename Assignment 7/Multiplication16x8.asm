 		org 00h
	    ljmp start

; elements of multiplication

		org 100h
		multiplier: db 0FFH
		multiplicand_lb: db 0FFH
		multiplicand_hb: db 0FFH 
	  
	  ;-------------delay routine

delay: mov r3,#0x10
       mov r4,#0x0
	   mov r5,#0x0
loop:  djnz r5,loop   
	   djnz r4,loop
	   djnz r3,loop
	   ret

	; initial calling

start: call mult
       call display
 here: jmp here

 	   ; main program  logic

  mult: mov dptr, #multiplier
        clr a
		movc a,@a+dptr
		mov b,a
		inc dptr
		mov dptr,#multiplicand_lb
		clr a
		movc a,@a+dptr
		mul ab			; aXb result  a=lower byte ,b=higher byte
		mov r0,a
		mov r1,b
		mov dptr,#multiplier
		clr a
		movc a,@a+dptr
		mov b,a
		mov dptr,#multiplicand_hb
		clr a
		movc a,@a+dptr
		mul ab
		add a,r1
		mov r6,a
		jnc dn
		inc b
	dn: ret

	;***********display logic*****

   display: mov a,b
            cpl a
			mov p2,a	 ;higher byte
			call delay
			mov a,r6	  ; middle byte
			cpl a
			mov p2,a
			call delay
			mov a,r0	  ; last byte
			cpl a
			mov p2,a
			call delay
			ret

  end


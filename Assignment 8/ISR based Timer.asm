	portpin equ p1.0
	org 00h
	ljmp start

	org 0bh
	clr tf0
	clr tr0
	cpl portpin
	mov th0,#0ffh
	mov tl0,#2fh
	setb tr0
	reti
start: setb ea
		setb ET0
       mov tmod,#01
	   mov th0,#0ffh
	   mov tl0,#2fh
	   setb tr0
 here: sjmp here
 end
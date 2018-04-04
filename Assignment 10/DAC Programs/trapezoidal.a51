;This is a program to generate square wave using dac

temp equ 1 			;use Register R3 
rev  equ 2 			;use Register R2 
cntr equ 3			;use Register R4 

org 0h
	jmp begin

delay:
	mov r5,#02h
d1:
	djnz r5,d1
	ret

longdelay:
	mov r5,#0AFh
ld1:
	mov r6,#08h
ld2:
	djnz r6,ld2
	djnz r5,ld1
	ret

send_dac:
	mov P1,a
	ret

begin:
	mov r0,#00h
w1:
	mov a,r0
	lcall send_dac
	;lcall delay
	inc r0
	cjne r0,#0ffh,w1

	lcall longdelay

w2:
	mov a,r0 
	lcall send_dac
	;lcall delay
	djnz r0,w2
	
	lcall longdelay	
	
	jmp w1
end

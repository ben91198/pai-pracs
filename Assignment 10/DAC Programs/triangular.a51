;This is a program to geberate square wave using dac

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
w2:
	mov a,r0 
	lcall send_dac
	;lcall delay
	djnz r0, w2	
	jmp w1
end

;This is a program to geberate square wave using dac

temp equ 2 			;use Register R3 
rev  equ 3 			;use Register R2 
cntr equ 4			;use Register R4 

org 0h
	jmp begin
delay:
	mov r5,#0FFh
d1:
	djnz r5,d1
	ret

send_dac:
	mov P1,a
	ret

begin:
	nop
w1:
	mov a, #00h
	lcall send_dac
	lcall delay
	mov a, #0FFh
	lcall send_dac
	lcall delay	
	jmp w1
end

;This is a program to generate square wave using dac

temp equ 1 			;use Register R3 
rev  equ 2 			;use Register R2 
cntr equ 3			;use Register R4 

org 0h
	jmp begin
delay:
	mov r5,#01h
d1:
	djnz r5,d1
	ret

send_dac:
	mov P1,a
	ret

begin:
	mov dptr,#lut
	mov r0,#00h
Q1:	//quadrant I
	mov a,r0
	movc a,@a+dptr
	add a,#07Fh
	lcall send_dac
	;lcall delay
	mov a ,r0
	add a,#01h
	mov r0,a
	cjne r0,#12h,Q1

Q2:	//quadrant II
	mov a,r0
	movc a,@a+dptr
	add a,#07Fh
	lcall send_dac
	;lcall delay
	mov a ,r0
	subb a,#01h
	mov r0,a
	djnz r0,Q2

Q3: //quadrant III   
	mov a,r0
	movc a,@a+dptr
    cpl a
	subb a,#01h
	add a,#07Fh
	lcall send_dac
	;lcall delay
	mov a ,r0
	add a,#01h
	mov r0,a
	cjne r0,#12h,Q3	

Q4://quadrant II
	mov a,r0
	movc a,@a+dptr
	cpl a
	add a,#01h
	subb a,#07Fh
	lcall send_dac
	;lcall delay
	mov a,r0
	subb a,#01h
	mov r0,a
	djnz r0,Q4

	jmp Q1

org 100h
lut:	DB 0,10,17,25,35,42,50,57,65,71,77,82,87,91,95,97,99,100,100
end


	org 00h
	ljmp dn1
	
        org 100h
	arr:db 04,05,02,03
   
    dn1:call addn
        call disp
    sss:sjmp sss

;******************delay routine*********

  delay:mov r3,#0x10
        mov r4,#0x0
	mov r5,#0x0
   loop:djnz r5,loop
        djnz r4,loop
        djnz r3,loop
	  ret 
;******************addition routine*********
  
  addn: mov dptr,#100h
         mov r0,#0	 ;add
         mov r1,#0	 ;carry
         mov r2,#04      ;counter
     
    up1: clr a
         movc a,@a+dptr
	 add a,r0
	 jnc dn2
	 inc r1
    dn2: mov r0,a
	 inc dptr
	 djnz r2,up1
	 ret

;******************display routine********* 
  
   disp: mov a,r1
         cpl a
	 mov p2,a
	 call delay
	 mov a,r0
	 cpl a
	 mov p2,a
	 call delay
	 ret
   end
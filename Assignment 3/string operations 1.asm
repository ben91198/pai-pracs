.model small

.data
msg1    db 10,13,"**********MENU**********"
        db 10,13,"1.Display Length"
        db 10,13,"2.Display Reverse"
        db 10,13,"3.Check Palindrome Or Not"
        db 10,13,"4.Exit"
        db 10,13,"Enter Your Choice: $"
msg2    db 10,13,"Enter String:$"
msg3    db 10,13,"Length Of The String Is: $"
msg4    db 10,13,"Reverse Of String Is: $"
msg5    db 10,13,"-----String Is Palindrome-----$"
msg6    db 10,13,"-----String Is Not Palindrome-----$"
msg7    db 10,13,"Wrong Chice..! Enter Correct Choice..!$"
	
str1 db 25h,0,25h dup("$")       ;1=total allocate size
                                 ;2=actual length of string 
                                 ;3=blank space fill with $
.code

	mov ax,@data
        mov ds,ax
	mov es,ax
	 
	menu:lea dx,msg1
        mov ah,09h
        int 21h

        mov ah,01h
        int 21h

        cmp al,31h
        jz x1				;jump to lable x1

        cmp al,32h
        jz x2				;jump to lable x2

        cmp al,33h
        jz x3				;jump to lable x3

        cmp al,34h
        jz x4				;jump to lable x4

        jnz x5

        x1:call len			;call to len procedure
           jmp menu

        x2:call rev			;call to rev procedure
           jmp menu

        x3:call palindrome		;call to palindrome procedure
           jmp menu

        x4:call exit			;call to exit procedure

        x5:lea dx,msg7			;display wrong choice msg
           mov ah,09h
           int 21h
           jmp menu

;-------- length of string ----------

len proc near

	lea dx,msg2             	
        mov ah,09h
        int 21h

        lea dx,str1			;accept string from user
        mov ah,0ah
        int 21h

       lea dx,msg3
       mov ah,09h
       int 21h

       mov dl,str1+1			;calculate length of string
       add dl,30h
       mov ah,02h
       int 21h

       ret				;return
endp

;--------- reverse string-----------

rev proc near

	lea dx,msg2             
        mov ah,09h
        int 21h

        lea dx,str1			;accept string from user
        mov ah,0ah
        int 21h

        lea dx,msg4
        mov ah,09h
        int 21h

        lea si,str1+2			;point to 1st letter
        mov ch,00h
	mov cl,str1+1			;move actual length os string
        add si,cx			;point to last letter

        back:dec si
             mov dl,[si]
             mov ah,02h
             int 21h
	loop back

        ret				;return
endp

;--------- palindrome ------------

palindrome proc near

	lea dx,msg2             
        mov ah,09h
        int 21h

        lea dx,str1			;accept string from user
        mov ah,0ah
        int 21h
	
	mov cx,00
	lea si,str1+2  			;point to 1st letter of string
	lea di,str1+1		     	;then no need to dec by 1
	mov cl,str1+1
	add di,cx
	sar cx,1      		     	;length divided by 2

up1:	cmpsb          			;compare bytes
	jne noti               
	sub di,02h     			;si,di always inc by 1 
	loop up1       			;but we want di as dec by 1 
      
	lea dx,msg5			;display msg5
	mov ah,09h
	int 21h
          
	jmp next1

noti:	lea dx,msg6			;display msg6
	mov ah,09h
	int 21h

next1:ret				;return to lablel x3

endp

;---------- exit ---------------

exit proc near

	mov ah,4ch
	int 21h
endp


end

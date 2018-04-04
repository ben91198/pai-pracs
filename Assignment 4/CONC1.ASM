; ALP FOR STRING CONCATANATION

.MODEL SMALL

XYZ MACRO NUM
     MOV AH, NUM
     INT 21H
ENDM

PUBLIC  MAX1, ACTUAL1, STRING1, MAX2, ACTUAL2, STRING2, M4, M6, M7

EXTRN CONCATE:FAR
EXTRN COMPARE:FAR

.DATA

MAX1     DB 80 
ACTUAL1  DB 0
STRING1  DB 80 DUP (0)
MAX2     DB 80 
ACTUAL2  DB 0
STRING2  DB 80 DUP (0)

M1 db 10,13,"*****MENU*****"
   db 10,13,"1.String Concatanation"
   db 10,13,"2.String Comparision"
   db 10,13,"3.exit"
   db 10,13,"Enter ur choice: $"
M2 DB 10,13,"ENTER THE FIRST STRING:  $"
M3 DB 10,13,"ENTER THE SECOND STRING:  $"
M4 DB 10,13,"THE CONCATANATED STRING IS:  $"
M5 DB 10,13,"Wrong choice !! enter again$"
M6 DB 10,13,"THE STRINGS ARE EQUAL$"
M7 DB 10,13,"THE STRINGS ARE NOT EQUAL$"


.CODE

 	MOV AX, @DATA
	MOV DS, AX


	LEA DX, M2
	XYZ 9

	LEA DX, MAX1
	XYZ 0AH
 
        LEA DX, M3
	XYZ 9

	LEA DX, MAX2
	XYZ 0AH

   MENU:LEA DX, M1
	XYZ 9
     
        XYZ 1
     
     	cmp al,31h
    	jz x1          
     
	cmp al,32h
    	jz x2     
     
	cmp al,33h
    	jz x3
     	jnz x4                 ;if wrong choice is entered

x1:call concate
   jmp menu

x2:call compare
   jmp menu

x3:call exit

x4:lea dx,m5
   XYZ 9
   jmp menu

exit proc near
     XYZ 4CH
endp        
	

	
END

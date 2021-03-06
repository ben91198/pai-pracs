; ALP FOR STRING CONCATANATION

.MODEL SMALL

INTR MACRO NUM
     MOV AH, NUM
     INT 21H
ENDM

EXTRN MAX1 : BYTE
EXTRN ACTUAL1 : BYTE
EXTRN STRING1 : BYTE
EXTRN MAX2 : BYTE
EXTRN ACTUAL2 : BYTE
EXTRN STRING2 : BYTE
EXTRN M6 : BYTE
EXTRN M7 : BYTE

PUBLIC COMPARE

.DATA

CONC  DB 80 DUP(0)
SIZE1 DW 0

.CODE

COMPARE PROC FAR

 	MOV AX, @DATA
	MOV DS, AX
        MOV ES, AX

	MOV AL ,ACTUAL1
        CMP AL, ACTUAL2
        JNE NOTEQUAL

        lEA SI, STRING1
        LEA DI, STRING2
	MOV CL, ACTUAL1
	MOV CH ,0
        
	CLD
 REP    CMPSB
        JNE NOTEQUAL

        LEA DX, M6
        INTR 9
        JMP EXIT

NOTEQUAL: LEA DX,M7
          INTR 9
  EXIT:      RET
ENDP

INTR 4CH

END
	


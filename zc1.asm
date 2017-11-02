STACK   SEGMENT  STACK  'STACK'
        DW  100H  DUP(?)
TOP     LABEL WORD
STACK   ENDS
DATA    SEGMENT
VAR1	DB 46H    ;????????????????????????????????
VAR2	DB 15H
VAR3	DB 0A2H
DATA  	ENDS
CODE  	SEGMENT
      	ASSUME  CS:CODE,DS:DATA,ES:DATA,SS:STACK
START:
        MOV  AX, DATA
        MOV  DS, AX
        MOV  ES, AX
        MOV  AX, STACK
        MOV  SS, AX
        LEA SP,TOP
 	    MOV AL,VAR1		;?????§Õ?????
 	    CMP AL,VAR2
	    JAE NO_CHG1
	    XCHG AL,VAR2
NO_CHG1:
        CMP AL,VAR3
	    JAE NO_CHG2
	    XCHG AL,VAR3
NO_CHG2:
	  MOV VAR1,AL		;????????›ÔVAR1
	  MOV AL,VAR2
	  CMP AL,VAR3
	  JAE NO_CHG3
	  XCHG AL,VAR3
	  MOV VAR2,AL		;?¦Ä?????›ÔVAR2

NO_CHG3:
	  mov al,var1
	  call zc1
	  mov al,var2
	  call zc1
	  mov al,var3
	  call zc1	  
	  
	  MOV AH,4CH		;????DOS??????
	  INT 21H
	  
zc1	  proc
		mov bl,al
		mov cl,4
		shr al,cl
		add al,30h
		cmp al,'9'
		jna n0
		add al,7
n0:		mov dl,al
		mov ah,2
		int 21h
		and bl,0fh
		add bl,30h
		cmp bl,'9'
		jna n1
		add bl,7
n1:		mov dl,bl
		mov ah,2
		int 21h
	  	ret
zc1		endp	  
	  
CODE  ENDS
      END START




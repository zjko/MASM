DATA  	SEGMENT
IOPORT	EQU 02400H-0280H
IO8255A	EQU IOPORT+288H      ;A�ڵ�ַ
IO8255K	EQU IOPORT+28BH      ;���ƿڵ�ַ
IO8255C	EQU IOPORT+28AH		 ;C�ڵ�ַ
LED     DB  3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH ;����
BUFFER1 DB  5,6         	;����Ҫ��ʾ��ʮλ�͸�λ
BZ      DW  ?           	;λ��
DATA 	ENDS
CODE  	SEGMENT
	ASSUME CS:CODE,DS:DATA
START:	MOV AX,DATA
	MOV DS,AX
	MOV DX,IO8255K             	 ;д������,��8255��ΪA������
	MOV AL,80H
	OUT DX,AL
LOOP1:	MOV DX,IO8255C
	MOV AL,0                    ;�ص���������ʾ
	OUT DX,AL
	MOV DI,OFFSET BUFFER1      	 
       MOV BYTE PTR BZ,02
       CALL DISP			;��ʾʮλ��
       CALL DELAY
	MOV DX,IO8255C
	MOV AL,0                    ;�ص���������ʾ
	OUT DX,AL
       MOV DI,OFFSET BUFFER1+1      
       MOV BYTE PTR BZ,01
       CALL DISP			;��ʾ��λ��
       CALL DELAY
       MOV DX,0FFH
	MOV  AH,06
	INT  21H
	JE  LOOP1                   ;�м��������˳�
	MOV DX,IO8255C
	MOV AL,0                    ;�ص���������ʾ
	OUT DX,AL
	MOV AH,4CH                  ;����
	INT 21H		
DISP	PROC
	PUSH AX
	PUSH BX
	PUSH DX
	MOV AL,[DI]                  ;ALΪҪ��ʾ����
	MOV BX,OFFSET LED            
	XLAT LED                   	 ;������Ӧ��LED����ֵ��AL		
	MOV DX,IO8255A               ;��8255A�Ŀ�����
	OUT DX,AL
	MOV AL,BYTE PTR BZ           ;ʹ��Ӧ����������
	MOV DX,IO8255C		  ;��8255��C������
	OUT DX,AL
	POP DX
	POP BX
	POP AX
	RET
DISP	ENDP	
DELAY  PROC 
	PUSH CX		
	MOV CX,3000
D1:	LOOP D1    	
	POP CX
	RET
DELAY 	ENDP
		
CODE 	ENDS
	END START







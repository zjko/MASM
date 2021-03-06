;**************************************
;*           LED������ʵ��            *
;*           ��̬��ʾ��56��           *
;**************************************
DATA  	SEGMENT
IOPORT	EQU 02400H-0280H
IO8255A	EQU IOPORT+288H       ;A�ڵ�ַ
IO8255K	EQU IOPORT+28BH       ;���ƿڵ�ַ
IO8255C	EQU IOPORT+28AH	 ;C�ڵ�ַ
LED     DB  3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH ;����
BUFFER1 DB  6,5         ;����Ҫ��ʾ�ĸ�λ��ʮλ
BZ      DW  ?           ;λ��
DATA 	ENDS
CODE  	SEGMENT
	ASSUME CS:CODE,DS:DATA
START:	MOV AX,DATA
	MOV DS,AX
	MOV DX,IO8255K             	;д������,��8255��ΪA������
	MOV AL,80H
	OUT DX,AL
	MOV DI,OFFSET BUFFER1      	;��DIΪ��ʾ��������ַ
LOOP2:	MOV BH,02
LLL:   MOV BYTE PTR BZ,BH
	PUSH DI
	DEC DI
	ADD DI, BZ
	MOV BL,[DI]                  ;BLΪҪ��ʾ����
	POP DI
	MOV DX,IO8255C
	MOV AL,0                    ;�ص���������ʾ
	OUT DX,AL
	MOV BH,0
	MOV SI,OFFSET LED            ;��LED������ƫ�Ƶ�ַΪSI
	ADD SI,BX                    
	MOV AL,BYTE PTR [SI]		 ;������Ӧ��LED����ֵ��AL
	MOV DX,IO8255A               ;��8255A�Ŀ�����
	OUT DX,AL
	MOV AL,BYTE PTR BZ           ;ʹ��Ӧ����������
	MOV DX,IO8255C		  ;��8255��C������
	OUT DX,AL
	MOV CX,3000
DELAY:	LOOP DELAY                   ;��ʱ
	MOV BH,BYTE PTR BZ
	SHR BH,1
	JNZ LLL
	MOV DX,0FFH
	MOV  AH,06
	INT  21H
	JE  LOOP2                   ;�м��������˳�
	MOV DX,IO8255C
	MOV AL,0                    ;�ص���������ʾ
	OUT DX,AL
	MOV AH,4CH                  ;����
	INT 21H
CODE 	ENDS
	END START








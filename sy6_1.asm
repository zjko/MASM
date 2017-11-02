;************************************************
;* ������������(0-9)����LED��������ʾ(��̬��ʾ) *
;************************************************
DATA	SEGMENT
IOPORT	EQU 02400H-0280H
IO8255A	EQU IOPORT+288H				;A�ڿڵ�ַ
IO8255B	EQU IOPORT+28BH             ;���ƿڿڵ�ַ
LED     DB  3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH  ;����0��1��2��������9
MESG1   DB  0DH,0AH,'INPUT A NUM (0--9),OTHER KEY IS EXIT:',0DH,0AH,'$'
DATA 	ENDS

CODE  	SEGMENT
		ASSUME CS:CODE,DS:DATA
START:  MOV AX,DATA
		MOV DS,AX
		MOV DX,IO8255B           ;д������ʹ8255��A��Ϊ������ʽ
		MOV AX,80H
		OUT DX,AL
SSS:    MOV DX,OFFSET MESG1    	 ;��ʾ��ʾ��Ϣ
		MOV AH,09H
		INT 21H
		MOV AH,01                ;�Ӽ��̽����ַ�
		INT 21H
		CMP AL,'0'               ;�Ƿ�С��0
		JL  EXIT                 ;�������˳�
		CMP AL,'9'               ;�Ƿ�����9
		JG  EXIT                 ;�������˳�
		SUB AL,30H               ;�������ַ���ASCII����30H
		MOV BX,OFFSET LED        ;BXΪ����������ʼ��ַ
		XLAT LED                 ;����������Ӧ�Ķ�����AL
		MOV DX,IO8255A           ;��8255��A������
		OUT DX,AL
		JMP SSS                  ;תSSS
EXIT:   MOV AH,4CH               ;����
		INT 21H
CODE 	ENDS
		END START



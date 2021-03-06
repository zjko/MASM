INT_VECT    	EQU 0BH    		;�ж�ԴΪIRQ3����Ӧ���ж����ͺ�Ϊ0BH
IRQ_MASK    	EQU 011110111B  	;�ж�����,��Ƭ�ĵ�3λΪ�㼴IRQ3Ϊ0
DATA 		SEGMENT
MSG1		DB 0DH,0AH,'THIS IS A 8259A INTERRUPT',0DH,0AH,'$'
MSG2		DB 0DH,0AH,'PRESS ANY KEY TO EXIT!',0DH,0AH,'$'
IRQ_TIMES	DW ?			;�жϼ���
CSREG		DW ?
IPREG		DW ?			;���ж����������ռ�
DATA 		ENDS

CODE 	  	SEGMENT
        	ASSUME CS:CODE,DS:DATA,ES:DATA
START: 		MOV AX,DATA
		MOV DS,AX
		MOV ES,AX 
		CLI			;���ж�
;******************************************************************
; ����ԭ�ж�����
        	MOV AL,INT_VECT         
	    	MOV AH,35H		;���ڲ�����AH=35H��AL=�ж����ͺ�
        	INT 21H			;���ڲ�����ES:BX=�ж�����
		MOV AX,ES
		MOV CSREG,AX            ;����ԭ�ж��������洢��Ԫ
		MOV IPREG,BX
;******************************************************************
; �������ж�����
		MOV AX,CS               ;���ڲ�����AH=25H��AL=�ж����ͺ�
		MOV DS,AX			;DS:DX=Ҫд�����ж���������
		MOV DX,OFFSET INT_PROC	;DS=�жϷ����������ڵĴ����εĶλ�ַ
		MOV AL,INT_VECT		;DX=�жϷ����������ڵ���Ч��ַ
		MOV AH,25H
		INT 21H
;*******************************************************************
;�����ж����� 
       		IN  AL,21H         	;����Ƭ�ж����μĴ���
        	AND AL,IRQ_MASK		;����IRQ3�ж�
        	OUT 21H,AL
;*******************************************************************
;ʵ����Ҫ���ܶ�
		MOV AX,DATA
		MOV DS,AX
		MOV DX,OFFSET MSG2       ;��ʾ��ʾ��Ϣ
		MOV AH,09H
		INT 21H
		MOV IRQ_TIMES,10  	;�����жϴ���
		STI			;���ж�
		CALL INIT8253		;����8253ÿ��4S����һ���ж������ź�
LOOP1:		CMP IRQ_TIMES,0		;�ȴ��ж�,�ж��ж�10�κ��˳�
      		JZ exit				
		JMP LOOP1
EXIT:		CLI			;���ж�

;**************************************************************
;�ָ��ж�����
        	MOV 	BL,IRQ_MASK		;�ر�IRQ3�ж�
		NOT	BL			;ȡ��
		IN	AL,21H
		OR	AL,BL
		OUT	21H,AL	
;**************************************************************
;�ָ�ԭ�ж�����
		MOV DX,IPREG                
		MOV AX,CSREG
		MOV DS,AX
		MOV AH,25H
		MOV AL,INT_VECT
        	INT 21H
		MOV AX,4C00H		;����DOS
		INT 21H

;*************************************************************
;�жϷ�������
INT_PROC	PROC FAR               	
        	push ax
		push dx
		MOV AX,DATA
		MOV DS,AX
   		MOV DX,OFFSET MSG1      ;��ʾ��ʾ��Ϣ
		MOV AH,09H
		INT 21H
		DEC IRQ_TIMES		;�жϼ�������һ
        	MOV AL,20H              ;����EOI�����ж�
          	OUT 20H,AL			;����8259A��
		OUT 0A0H,AL			;����8259A��
		pop dx
		pop ax		
        	IRET
INT_PROC	ENDP
;*************************************************************
INIT8253	PROC
		MOV DX,283H     	;��8253���ƿ�д������
		MOV AL,36H       	;ʹ0ͨ��Ϊ������ʽ3    00110110
		OUT DX,AL
		MOV AX,2000      	;д��ѭ��������ֵ2000
		MOV DX,280H
		OUT DX,AL        	;��д�����ֽ�
		MOV AL,AH
		OUT DX,AL        	;��д�����ֽ�
		MOV DX,283H
		MOV AL,74H       	;��8253ͨ��1������ʽ2   01110100
		OUT DX,AL
		MOV AX,2000      	;д��ѭ��������ֵ2000
		MOV DX,281H
		OUT DX,AL        	;��д���ֽ�
		MOV AL,AH
		OUT DX,AL        	;��д���ֽ�
		RET
INIT8253	ENDP
CODE		ENDS
		END START


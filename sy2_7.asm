DATA	SEGMENT
DATA1	DB 5 DUP(?)    			 ;����5λ��������ASCII����ʽ����λ��ǰ5
DATA2	DB 5 DUP(?)    			 ;����5λ������ASCII����ʽ����λ��ǰ5
DATA3   DB 6 DUP(0)              ;����6�����Ž����ĵ�Ԫ6
DATA4   DB 'Please enter the five augend:',0dh,0ah,'$';32 
DATA5	DB 0dh,0ah,'$' ;3
DATA	ENDS

STACK 	SEGMENT STACK
		STA	DB 100 DUP(?)
		NUM EQU LENGTH STA
STACK 	ENDS

CODE	SEGMENT
		ASSUME  CS:CODE,DS:DATA,SS:STACK
START:	MOV AX,DATA
	    MOV DS,AX
		
		MOV AX,STACK
		MOV SS,AX
		MOV SP,NUM
		
		MOV DX,OFFSET DATA4
		call zd9
				
		mov cx,5
		MOV SI,4
INPUT1:	call zd1
		MOV DATA1[SI],AL
		DEC SI
		loop INPUT1
		
		MOV DX,OFFSET DATA5
		call zd9
		
		MOV DX,OFFSET DATA4
		call zd9
		
		MOV CX,5
		MOV SI,4
INPUT2:	call zd1
		MOV DATA2[SI],AL
		DEC SI
		loop INPUT2
		
		MOV DX,OFFSET DATA5
		call zd9
 
		MOV CX,5			     ;ѭ��������5��5��λҪ����5��
		MOV SI,0			     ;SI�ŵ�ַλ������ÿ�����ĵ�һ�ֽڵ�ַλ����Ϊ0
		CLC                      ;CF��0����ֹ��1���ֽ�����ʱADCָ������CF�п��ܵ�1
NEXT:	MOV AL,DATA1[SI]         ;ȡ������һ���ֽ���AL��DATA1ƫ�Ƶ�ַ��SIΪ��Ч��ַ
		ADC AL,DATA2[SI]         ;AL��������Ӧ�ֽڣ�CF����λ����ʱ���ܵĽ�λ��������AL
		AAA			             ;AL�����ֽ����ӵĺ͵����ɷ�ѹ����BCD�룬��λ��CF��
		MOV DATA3[SI],AL         ;��������DATA3��Ӧ�ֽڵ�Ԫ��
		INC SI			         ;��ַλ������1ָ����һλ�ֽڵ�Ԫ 
    	LOOP NEXT			     ;5��δ��������ѭ��	
		ADC  DATA3[SI],0
		
		MOV CX,5
		MOV SI,4		         ;��ʾ5��λ��SI�е�������ѭ������������ַλ����
DISP1:  MOV DL,DATA1[SI]       ;��ASCII����DL������2�Ź��ܵ��õĹ涨Ҫ��
	    call zd2
	    DEC SI                   ;������1
	    loop DISP1 
	                   			;5��δ��������ѭ��
DISP2:	MOV	DL,2BH
		call zd2
				
		MOV CX,5
		MOV SI,4
DISP3:	MOV DL,DATA2[SI]         ;��ASCII����DL������2�Ź��ܵ��õĹ涨Ҫ��
	    call zd2
	    DEC SI                   ;������1
	    loop DISP3 
	                                  ;5��δ��������ѭ��
DISP4:	MOV	DL,3DH
		call zd2
		
		mov cx,5
		MOV SI,5
		mov al,DATA3[SI]
		cmp al,0
		jz  disp5
		mov dl,31h
		call zd2
disp5:	dec si
	    
DISP6:	ADD DATA3[SI],30H      ;�������Ӹ�λ��Ԫ��ʼ�ѷ�ѹ����BCD������ASCII��
	    MOV DL,DATA3[SI]       ;��ASCII����DL������2�Ź��ܵ��õĹ涨Ҫ��
	    call zd2
	    DEC SI                   ;������1
	    loop DISP6                 ;5��δ��������ѭ��
	    
	    MOV AH,4CH			     ;���ܺ���AH
	    INT 21H                  ;����4CH�Ź��ܣ�����DOS

zd1     proc
		MOV AH,1			     ;���ܺ���AH
	    INT 21H                  ;����2�Ź��ܣ���ʾһλ����
		ret
zd1		endp

zd2     proc
		MOV AH,2			     ;���ܺ���AH
	    INT 21H                  ;����2�Ź��ܣ���ʾһλ����
		ret
zd2		endp

zd9     proc
		MOV AH,9
		INT 21H
		ret
zd9		endp

CODE	ENDS
	    END START








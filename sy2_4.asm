DATA	SEGMENT
DATA1	DB 33H,39H,31H,37H,38H   ;���ű�����87193��ASCII����ʽ����λ��ǰ
DATA2	DB 36H,35H,30H,38H,37H   ;���ż���78056��ASCII����ʽ����λ��ǰ
DATA3   DB 6 DUP(0)              ;����5�����Ž����ĵ�Ԫ
DATA	ENDS
CODE	SEGMENT
		ASSUME  CS:CODE,DS:DATA
START:	MOV AX,DATA
	    MOV DS,AX
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
		MOV SI,5		         ;��ʾ5��λ��SI�е�������ѭ������������ַλ����
DISP1:  MOV DL,DATA1[SI-1]       ;��ASCII����DL������2�Ź��ܵ��õĹ涨Ҫ��
	    MOV AH,2			     ;���ܺ���AH
	    INT 21H                  ;����2�Ź��ܣ���ʾһλ����
	    DEC SI                   ;������1
	    JNZ DISP1                ;5��δ��������ѭ��
DISP2:	MOV	DL,2BH
		MOV AH,2			     ;���ܺ���AH
	    INT 21H                  ;����2�Ź��ܣ���ʾһλ����
		MOV SI,5
DISP3:	MOV DL,DATA2[SI-1]       ;��ASCII����DL������2�Ź��ܵ��õĹ涨Ҫ��
	    MOV AH,2			     ;���ܺ���AH
	    INT 21H                  ;����2�Ź��ܣ���ʾһλ����
	    DEC SI                   ;������1
	    JNZ DISP3                ;5��δ��������ѭ��
DISP4:	MOV	DL,3DH
		MOV AH,2			     ;���ܺ���AH
	    INT 21H                  ;����2�Ź��ܣ���ʾһλ����
		MOV SI,6
DISP5:	ADD DATA3[SI-1],30H      ;�������Ӹ�λ��Ԫ��ʼ�ѷ�ѹ����BCD������ASCII��
	    MOV DL,DATA3[SI-1]       ;��ASCII����DL������2�Ź��ܵ��õĹ涨Ҫ��
	    MOV AH,2			     ;���ܺ���AH
	    INT 21H                  ;����2�Ź��ܣ���ʾһλ����
	    DEC SI                   ;������1
	    JNZ DISP5                 ;5��δ��������ѭ��
	    MOV AH,4CH			     ;���ܺ���AH
	    INT 21H                  ;����4CH�Ź��ܣ�����DOS
CODE	ENDS
	    END START





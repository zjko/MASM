DATA	SEGMENT
DATA1	DB 34H,37H,31H,39H,33H   ;���ű�����47193��ASCII����ʽ����λ��ǰ
DATA2	DB 32H,38H,30H,35H,36H   ;���ż���28056��ASCII����ʽ����λ��ǰ
DATA3   DB 5 DUP(?)              ;����5�����Ž����ĵ�Ԫ
DATA	ENDS
CODE	SEGMENT
		ASSUME  CS:CODE,DS:DATA
START:	MOV AX,DATA
	    MOV DS,AX
		MOV CX,5			     ;ѭ��������5��5��λҪ����5��
		MOV SI,4			     ;SI�ŵ�ַλ������ÿ�����ĵ�һ�ֽڵ�ַλ����Ϊ0
		CLC                      ;CF��0����ֹ��1���ֽ�����ʱADCָ������CF�п��ܵ�1
NEXT:	MOV AL,DATA1[SI]         ;ȡ������һ���ֽ���AL��DATA1ƫ�Ƶ�ַ��SIΪ��Ч��ַ
		ADC AL,DATA2[SI]         ;AL��������Ӧ�ֽڣ�CF����λ����ʱ���ܵĽ�λ��������AL
		AAA			             ;AL�����ֽ����ӵĺ͵����ɷ�ѹ����BCD�룬��λ��CF��
		MOV DATA3[SI],AL         ;��������DATA3��Ӧ�ֽڵ�Ԫ��
		DEC SI			         ;��ַλ������1ָ����һλ�ֽڵ�Ԫ 
    	LOOP NEXT			     ;5��δ��������ѭ��	
		MOV SI,0		         ;��ʾ5��λ��SI�е�������ѭ������������ַλ����
		MOV	CX,5
DISP:	ADD DATA3[SI],30H      ;�������Ӹ�λ��Ԫ��ʼ�ѷ�ѹ����BCD������ASCII��
	    MOV DL,DATA3[SI]       ;��ASCII����DL������2�Ź��ܵ��õĹ涨Ҫ��
	    MOV AH,2			     ;���ܺ���AH
	    INT 21H                  ;����2�Ź��ܣ���ʾһλ����
	    INC SI                   ;������1
	    LOOP DISP                 ;5��δ��������ѭ��
	    MOV AH,4CH			     ;���ܺ���AH
	    INT 21H                  ;����4CH�Ź��ܣ�����DOS
CODE	ENDS
	    END START


DATA	SEGMENT
DATA1	DB 33H,39H,31H,37H,34H   ;���ű�����47193��ASCII����ʽ����λ��ǰ
DATA2	DB 36H,35H,30H,38H,32H   ;���ż���28056��ASCII����ʽ����λ��ǰ
DATA3   DB 5 DUP(?)              ;����5�����Ž����ĵ�Ԫ
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
		MOV SI,5		         ;��ʾ5��λ��SI�е�������ѭ������������ַλ����
DISP:	ADD DATA3[SI-1],30H      ;�������Ӹ�λ��Ԫ��ʼ�ѷ�ѹ����BCD������ASCII��
	    MOV DL,DATA3[SI-1]       ;��ASCII����DL������2�Ź��ܵ��õĹ涨Ҫ��
	    MOV AH,2			     ;���ܺ���AH
	    INT 21H                  ;����2�Ź��ܣ���ʾһλ����
	    DEC SI                   ;������1
	    JNZ DISP                 ;5��δ��������ѭ��
	    MOV AH,4CH			     ;���ܺ���AH
	    INT 21H                  ;����4CH�Ź��ܣ�����DOS
CODE	ENDS
	    END START



; *********************************************************************************
; * Rotina que atualiza o display hexadecimal
; *********************************************************************************

atualizar_segmentos:
	PUSH R0
	PUSH R1
	PUSH R2
	MOV R0, local_Segmentos ; R0 com o endereco do display hexadecimal
	MOVB R1, [R0] ; Mete em R1 o valor atual do display hexadecimal
	ADD R1, R2 ; Adiciona o valor recebido ao valor atual do display
	MOVB [R0], R1 ; Mete o valor novo no display
	POP R2
	POP R1
	POP R0
	RET

; *********************************************************************************
; * Rotina que atualiza o display hexadecimal
; *********************************************************************************

apagar_linha:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	MOV R0, local_Ecra ; R0 com o endereco do ecra
	MOV R1, elem_Ecra ; Numero total de bytes do ecra
	MOV R2, 255 ; Mascara para testar o primeiro byte
	MOV R3, 240 ; Mascara para testar 
	

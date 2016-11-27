; *********************************************************************************
; * Rotina que limpa o ecra
; *********************************************************************************

limpar:
	PUSH R0 ; Guarda R0
	PUSH R1 ; Guarda R1
	PUSH R2 ; Guarda R2
	MOV R0, local_Ecra ; R0 com o endereco do Ecra
	MOV R1, 128 ; Valor de bytes totais do ecra
	MOV R2, 00H ; Valor que permite limpar todos os bytes do ecra
loop_limpar:
	MOV [R0], R2 ; Limpa 1 byte do ecra
	ADD R0, 1 ; Acede ao byte seguinte do ecra
	SUB R1, 1 ; Atualiza o contador de bytes
	JNZ loop_limpar ; Corre o loop outra vez ate todos os bytes estarem limpos
	POP R2 ; Devolve R2
	POP R1 ; Devolve R1
	POP R0 ; Devolve R0
	RET ; Termina a rotina
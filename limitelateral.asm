; *********************************************************************************
; * Rotina que cria o limite lateral do ecra
; *********************************************************************************

ecra_linhalateral:
	PUSH R0 ; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R3
	MOV R0, 32 ; R0 com um contador para ver se todas as linhas estao pintadas
	MOV R1, 1 ; Valor a escrever
	MOV R2, 0 ; Linha inicial onde comecar a pintada
loop_desenharlinha:
	MOV R3, 12 ; Coluna fixa onde escrever o limite lateral
	CALL desenhar_pixel ; Rotina que desenha 1 pixel
	SUB R0, 1 ; Atualiza o contador de linhas
	JZ fim_linhalateral ; Se ja desenhou todas as linhas acaba
	ADD R2, 1
	JMP loop_desenharlinha ; Corre o loop outra vez ate todas as linhas estarem pintadas
fim_linhalateral:
	POP R3 ; Devolve Registos
	POP R2
	POP R1
	POP R0
	RET ; Termina a rotina
; *********************************************************************************
; * Rotina que cria o limite lateral do ecra
; *********************************************************************************

ecra_linhalateral:
	PUSH R0 ; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	MOV R0, local_Ecra ; R0 com o endereco do ecra
	MOV R2, 128 ; Numero de bytes totais do ecra
repor_elementos:
	MOV R1, ecra_linha ; R1 com a tabela de strings que cria a linha lateral
	MOV R3, 4 ; Numero de elementos da tabela de strings (0, 1, 2, 3)
escrever_linhalateral:
	MOVB R4, [R1]
	MOVB [R0], R4 ; Move o valor da tabela de strings para o ecra
	ADD R0, 1 ; Acede ao byte seguinte do ecra
	ADD R1, 1 ; Acede ao proximo elemento da tabela de strings
	SUB R2, 1 ; Atualiza o contador de bytes do ecra
	JZ fim_linhalateral ; Se ja tiver pintado todas as linhas acaba
	SUB R3, 1 ; Atualiza o contador de elementos da tabela de strings
	JZ repor_elementos ; Caso ja tenha percorrido todos os elementos repoe o contador
	JMP escrever_linhalateral ; Corre o loop ate  o ecra estar todo pintada
fim_linhalateral:
	POP R4
	POP R3 ; Devolve Registos
	POP R2
	POP R1
	POP R0
	RET ; Termina a rotina
; *********************************************************************************
; * Mover Direita
; * Recebe da Memoria:
; * 	R0 - Tabela de strings a desenhar
; * 	R2 - Linha da posicao atual
; *		R3 - Coluna da posicao atual
; * Saidas:
; * 	R2 - Linha onde vai ser desenhado
; * 	R3 - Coluna onde vai ser desenhado
; *********************************************************************************

mover_direita:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	MOV R6, adr_x ; Atualiza R0 com o valor correspondente a linha atual onde desenhar o tetramino
	MOVB R2, [R6] ; Mete em R2, o valor da linha onde comecar a desenhar
	MOV R6, adr_y ; Acede a tabela que contem as posicoes 
	MOVB R3, [R6] ; Mete em R3, o valor da coluna onde comecar a desenhar
	ADD R3, 1 ; Adidicona 1 ao valor da coluna para mover para a direita
	MOVB R4, [R0] ; R4 com o valor correspondente ao numero de linhas da tabela
	ADD R0, 1 ; Acede ao proximo elemento da tabela de strings
	MOVB R5, [R0] ; R5 com o valor correspondente ao numero de colunas da tabela
	CALL verifica_desenhar
	AND R11, R11 (O registo depende da funcao verifica_desenhar)
	JZ fim_mover_direita ; Se nao poder desenhar acaba
	CALL apagar
	CALL desenhar_tetra
fim_mover_direita:
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
; *********************************************************************************
; * Mover Esquerda
; * Recebe da Memoria:
; * 	R0 - Tabela de strings a desenhar
; * 	R2 - Linha da posicao atual
; *		R3 - Coluna da posicao atual
; * Saidas:
; * 	R2 - Linha onde vai ser desenhado
; * 	R3 - Coluna onde vai ser desenhado
; *********************************************************************************

mover_direita:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	MOV R6, adr_x ; Atualiza R0 com o valor correspondente a linha atual onde desenhar o tetramino
	MOVB R2, [R6] ; Mete em R2, o valor da linha onde comecar a desenhar
	MOV R6, adr_y ; Acede a tabela que contem as posicoes 
	MOVB R3, [R6] ; Mete em R3, o valor da coluna onde comecar a desenhar
	SUB R3, 1 ; Subtrai 1 ao valor da coluna para mover para a esquerda
	MOVB R4, [R0] ; R4 com o valor correspondente ao numero de linhas da tabela
	ADD R0, 1 ; Acede ao proximo elemento da tabela de strings
	MOVB R5, [R0] ; R5 com o valor correspondente ao numero de colunas da tabela
	CALL verifica_desenhar
	AND R11, R11 (O registo depende da funcao verifica_desenhar)
	JZ fim_mover_direita ; Se nao poder desenhar acaba
	CALL apagar
	CALL desenhar_tetra
fim_mover_direita:
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET

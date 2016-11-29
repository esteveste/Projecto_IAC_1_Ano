; *********************************************************************************
; * Mover Tetramino
; * Recebe da Memoria:
; * 	R0 - Tabela de strings a desenhar
; * 	R2 - Linha da posicao atual
; *		R3 - Coluna da posicao atual
; * 	R9 - 1 Direita, 0 Esquerda
; * Saidas:
; * 	R2 - Linha onde vai ser desenhado
; * 	R3 - Coluna onde vai ser desenhado
; *********************************************************************************

mover_tetramino:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	MOV R6, adr_x ; Atualiza R0 com o valor correspondente a linha atual onde desenhar o tetramino
	MOVB R2, [R6] ; Mete em R2, o valor da linha onde comecar a desenhar
	MOV R6, adr_y ; Acede a tabela que contem as posicoes 
	MOVB R3, [R6] ; Mete em R3, o valor da coluna onde comecar a desenhar
direita:
	ADD R3, 1 ; Adidicona 1 ao valor da coluna para mover para a direita
	JMP mover ; Salta para concluir o movimento
esquerda:
	SUB R3, 1 ; Subtrai 1 para mover para a esquerda
mover:
	MOVB R4, [R0] ; R4 com o valor correspondente ao numero de linhas da tabela
	ADD R0, 1 ; Acede ao proximo elemento da tabela de strings
	MOVB R5, [R0] ; R5 com o valor correspondente ao numero de colunas da tabela
	CALL verifica_desenhar ; Chama a rotina que verifica se pode desenhar, se R11 for 0 nao pode, se for 1 pode
	AND R11, R11 (O registo depende da funcao verifica_desenhar)
	JZ fim_mover_tetra ; Se nao poder desenhar acaba
	MOV R9, 0 ; Mete em R9 1 valor para decidir de desenha ou apaga, se 1 escreve se 0 apaga
	CALL desenhar_tetra
	MOV R9, 1 ; Mete em R9 1 valor para decidir de desenha ou apaga, se 1 escreve se 0 apaga
	CALL desenhar_tetra
fim_mover_tetra:
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
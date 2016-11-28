; **********************************************************************
; * Desenha Tetramino ou Monstro
; *  Desenha tetraminos ou monstros nas posicoes devidas
; *Entradas:
; *  R0 - Tabela de strings do tetramino a desenhar
; * Recebe da Memoria:
; *  R2 - Linha da posicao onde desenhar
; *  R3 - Coluna da posicao onde desenhar
; *Saídas:
; *  R2 e R3 nao alterados
; **********************************************************************

desenhar_tetra:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	MOV R8, adr_x ; Atualiza R0 com o valor correspondente a linha inicial onde desenhar o tetramino
	MOVB R2, [R8] ; Mete em R2, o valor da linha onde comecar a desenhar
	MOV R8, adr_y ; Acede a tabela que contem as posicoes 
	MOVB R3, [R8] ; Mete em R3, o valor da coluna onde comecar a desenhar
	MOV R0, tabelatetramino ; R0 com a tabela de strings correspondente a variante de tetramino a desenhar
	MOVB R4, [R0] ; R4 com o valor correspondente ao numero de linhas da tabela
	ADD R0, 1 ; Acede ao proximo elemento da tabela de strings
	MOVB R5, [R0] ; R5 com o valor correspondente ao numero de colunas da tabela
	MOV R7, R4 ; Duplica o valor das linhas em registo para criar 1 contador
	MUL R7, R5 ; Multiplica o valor das linhas pelas colunas, para criar 1 contador do numero de elementos da tabela
	ADD R3, 2 ; Permite repor corretamente os contadores
	SUB R2, 1 ; Permite repor corretamente os contadores
repor_colunas:
	MOV R6, R5 ; Duplica o valor das colunas em registo para fazer um contador
	SUB R3, 2 ; Repoe o valor da coluna onde escrever
	ADD R2, 1 ; Muda a linha onde escrever
loop_desenhar_tetra:
	ADD R0, 1 ; Acede ao proximo elemento da tabela
	MOVB R1, [R0] ; R1 com o valor a escrever no ecra
	AND R1, R1 ; Afeta as flags
	JZ nao_desenhar0 ; Se for 0 nao desenha
	CALL desenhar_pixel ; Chama a rotina que desenha 1 pixel da tabela de strings
nao_desenhar0:
	ADD R3, 1 ; Muda a coluna onde escrever
	SUB R6, 1 ; Atualiza o contador de colunas
	JZ repor_colunas ; Se for 0 repoe as colunas
	SUB R7, 1
	JNZ loop_desenhar_tetra
fim_desenhar_tetra:
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

	
; **********************************************************************
; * Apagar Tetramino
; *  Testa se pode desenhar o tetramino na posicao recebida
; *Entradas:
; *  R0 - Tabela de strings do tetramino a desenhar
; * Recebe da Memoria:
; *  R2 - Linha da posicao onde desenhar
; *  R3 - Coluna da posicao onde desenhar
; *Saídas:
; *  R2 e R3 nao alterados
; **********************************************************************


; **********************************************************************
; * Teste Pre Desenho Tetramino
; *  Testa se pode desenhar o tetramino na posicao recebida
; *Entradas:
; *  R0 - Tabela de strings do tetramino a desenhar
; * Recebe da Memoria:
; *  R2 - Linha da posicao onde desenhar
; *  R3 - Coluna da posicao onde desenhar
; *Saídas:
; *  R2 e R3 nao alterados
; **********************************************************************
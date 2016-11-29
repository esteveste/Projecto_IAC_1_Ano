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


local_Ecra EQU 8000H

; ***********************************************************************
; * Definir SP
; ***********************************************************************
PLACE 1000H
pilha:
	table 100H               ; Tabela para stack pointer
SP_pilha:					 ; Etiqueta com o endereço final da pilha

adr_x:
STRING 6

adr_y:
STRING 0

tetraminoS1:
STRING 2, 3; linhas e colunas
STRING 0, 1, 1
STRING 1, 1, 0

PLACE      0
inicializacao:		     ; Inicializações gerais
	mov  SP, SP_pilha

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
	MOV R8, adr_y ; Atualiza R0 com o valor correspondente a linha inicial onde desenhar o tetramino
	MOVB R2, [R8] ; Mete em R2, o valor da linha onde comecar a desenhar
	MOV R8, adr_x ; Acede a tabela que contem as posicoes 
	MOVB R3, [R8] ; Mete em R3, o valor da coluna onde comecar a desenhar
	MOV R0, tetraminoS1 ; R0 com a tabela de strings correspondente a variante de tetramino a desenhar
	MOVB R4, [R0] ; R4 com o valor correspondente ao numero de linhas da tabela
	ADD R0, 1 ; Acede ao proximo elemento da tabela de strings
	MOVB R5, [R0] ; R5 com o valor correspondente ao numero de colunas da tabela
	MOV R7, R4 ; Duplica o valor das linhas em registo para criar 1 contador
	MUL R7, R5 ; Multiplica o valor das linhas pelas colunas, para criar 1 contador do numero de elementos da tabela
	ADD R3, R5 ; Permite repor corretamente os contadores
	SUB R2, 1 ; Permite repor corretamente os contadores
repor_colunas:
	MOV R6, R5 ; Duplica o valor das colunas em registo para fazer um contador
	SUB R3, R5 ; Repoe o valor da coluna onde escrever
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
	SUB R7, 1 ; Atualiza o contador de elementos da tabela
	JNZ loop_desenhar_tetra ; Se ainda nao acabou corre outra vez
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
; * Desenha Pixel
; *  Desenha ou apaga um pixel no ecrã com base nas linhas e colunas
; *Entradas:
; *  R1 - Valor a escrever (1 ou 0)
; *  R2 - Linha onde escrever
; *  R3 - Coluna onde escrever
; *Saídas:
; *  Nenhuma
; **********************************************************************

desenhar_pixel:
    PUSH  R0 ; Guarda R0
    PUSH  R1 ; Guarda R1
    PUSH  R2 ; Guarda R2
    PUSH  R3 ; Guarda R3
    PUSH  R4 ; Guarda R4
    PUSH  R5 ; Guarda R5
    PUSH  R6 ; Guarda R6
    PUSH  R7 ; Guarda R7
    PUSH  R8 ; Guarda R8
	MOV R0, local_Ecra ; Atualiza R0 com o endereco do ecra
	MOV R4, 4H ; Atualiza R4 com o numero de bytes de cada linha do ecra (linhas)
	MOV R5, 8H ; Atualiza R5 com o numero de bits por byte do ecra (colunas)
	MOV R6, 80H ; (10000000) Mascara que permite escrever nas colunas de cada byte atraves de shifts
	MUL R4, R2 ; Transforma R2 numa linha do ecra
	ADD R0, R4 ; Acede a linha do ecra onde e suposto escrever
	MOV R7, R3 ; R7 com o valor da coluna para dividir pelo numero de colunas
	DIV R7, R5 ; Transforma R7 numa coluna da linha onde escrever
	ADD R0, R7 ; Acede a coluna onde escrever
	MOD R3, R5 ; R3 com o bit onde escrever (R3 sera um valor de 0-7 que sao o numero de colunas)
selecao_pixel:
	AND R3, R3 ; Afectar as flags
	JZ escrever_ou_apagar ; Quando for o ultimo bit a verificar salta para decidir se desenha ou apaga
	SHR R6, 1 ; Atualiza a mascara para o bit seguinte ate ao bit onde e suposto escrever
	SUB R3, 1 ; Atualiza a coluna (avanca para o proximo bit)
	JMP selecao_pixel ; Verifica os bits todos de R3
escrever_ou_apagar:
	MOVB R8, [R0] ; Move para R8 o que esta escrito no byte do ecra
	AND R1, R1 ; Afectar as flags
	JNZ escrever; Caso seja para escrever salta para escrever
	NOT R6 ; Nega a mascara para poder apagar o bit
	AND R8, R6 ; Apaga apenas o bit escolhido
	JMP fim_desenhar_pixel ; Acaba de desenhar o pixel
escrever:
	OR R8, R6 ; Cria a mascara com o bit final a desenhar
fim_desenhar_pixel:
	MOVB [R0], R8 ; Escreve no ecra
    POP R8 ; Devolve R8
    POP R7 ; Devolve R7
    POP R6 ; Devolve R6
    POP R5 ; Devolve R5
    POP R4 ; Devolve R4
    POP R3 ; Devolve R3
    POP R2 ; Devolve R2
    POP R1 ; Devolve R1
    POP R0 ; Devolve R0
    RET ; Termina rotina
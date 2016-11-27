; **********************************************************************
; * Desenha Pixel
; *  Desenha ou apaga um pixel no ecrã com base nas linhas e colunas
; *Entradas:
; *  R1 - Valor a escrever (1 ou 0)
; *  R2 - Linha onde escrever
; *  R3 - Coluna onde escrever
; *Saídas:
; *  Nenhuma
; *COMENTARIO
; * Em termos logicos o que isto faz seria, receber o valor a escrever, a linha e coluna
; * e depois sabendo que o bit a escrever seria 4*linha + coluna/8, ele descobre onde escrever
; * e cria uma mascara baseado no 80H para poder escrever em qualquer bit de um byte
; * e depois escreve no ecra sem apagar o que ja esta escrito nesse byte 
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
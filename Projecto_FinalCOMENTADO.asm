; ***********************************************************************
; *
; * Projecto IAC 1 - Versão Final
; *
; ***********************************************************************

; ***********************************************************************
; *
; * Grupo nº:11
; * Nomes:	 Bernardo Esteves, Nº87633
; *			 Daniela Oliveira, Nº87647
; *			 Bernardo Santos, Nº87635
; *
; ***********************************************************************

; ***********************************************************************
; * Constantes
; ***********************************************************************


;
teclado_Jumper_FLAG			EQU 1470H
monstro_ativo 				EQU 1478H ;indica se existe um monstro ativo
Flag_Pausa_Display			EQU 1480h ;Saber se e para criar um novo tetramino
Flag_Tecla_Pressionada 		EQU 1486H ;De modo a permitir uma rotina correr apenas 1 vez numa funcao
adr_Tecla_Valor         EQU 1490H	 ; Endereço de memória onde se guarda a tecla premida
pontuacao 				EQU 1498H	 ; Endereco de memoria onde se guarda a pontuacao
adr_Nr_rANDom 			EQU 1410H	 ; Endereco onde se guarda o valor aleatorio de selecao dos tetraminos
adr_x					EQU 1420H  	 ; Endereco onde esta guardada a coluna atual do tetramino
adr_y					EQU 1430H    ; Endereco onde esta guardada a linha atual do tetramino
adr_x_teste				EQU 1428H  	 ; Endereco onde esta guardada a coluna onde sera testada o desenho do tetramino
adr_y_teste				EQU 1438H    ; Endereco onde esta guardada a linha onde sera testada o desenho do tetramino
adr_x_monstro			EQU 1448H	 ; Endereco onde esta guardada a coluna atual do monstro
const_y_monstro 		EQU 24  	 ; Valor constante da linha do monstro
adr_tetra_tipo			EQU 1450H    ; Endereco onde esta guardado o tipo atual dos tetraminos (I, S, T, L)
adr_tetra_rot 			EQU 1460H 	 ; Endereco onde esta guardado a rotacao de cada tetramino (1, 2, 3, 4 para cada peca)
adr_tetra_rot_teste		EQU 1468H    ; Endereco onde esta guardado a rotacao que vai ser testada
linha	                EQU 8H       ; Posição do bit correspondente à linha a testar
local_Segmentos	        EQU 0A000H 	 ; Endereco do display de 7 segmentos
out_Teclado	            EQU 0C000H   ; Endereço do porto de escrita do teclado
in_Teclado		        EQU 0E000H   ; Endereço do porto de leitura do teclado
elem_Ecra               EQU 128      ; Número de bytes do ecrã
elem_tabelas 	        EQU 128		 ; Numero de elementos das tabelas de inicio, about e fim
tecla_pausa             EQU 0CH		 ; Valor atribuido a tecla para pausar o jogo
tecla_about             EQU 0AH		 ; Valor atribuido a tecla para aceder ao menu about
tecla_gameover          EQU 0EH		 ; Valor atribuido a tecla para terminar o jogo
tecla_jogar             EQU 0BH		 ; Valor atribuido a tecla para jogar
tecla_rodar				EQU 01H		 ; Valor atribuido a tecla para rodar o tetramino
tecla_direita			EQU 06H		 ; Valor atribuido a tecla para MOVer o tetramino para a direita
tecla_esquerda			EQU 04H		 ; Valor atribuido a tecla para MOVer o tetramino para a esquerda
tecla_descer			EQU 05H		 ; Valor atribuido a tecla para descer o tetramino
tecla_sair_estado		EQU 0FFH	 ; Valor atribuido a tecla neutra
local_Ecra	            EQU 8000H	 ; Endereco do pixelscreen
x_monstro_inicial		EQU 21		 ; Valor inicial da coluna onde desenhar o monstro
valor_max_decimal		EQU 9		 ; Valor maximo da pontuacao em decimal
linha_tetris_completa	EQU 3		 ; Valor de bytes a ser testados para verificacao das linhas completas durante o jogo
forcar_saida			EQU 1		 ; 
OFF                     EQU 0        ; Valor da tecla nao premida
ON                      EQU 1        ; Valor da tecla premida
estado_Welcome          EQU 0		 ; Valor do estado Welcome
estado_Preparar_jogo    EQU 1		 ; Valor do estado Preparar Jogo
estado_Criar_Tetra      EQU 2		 ; Valor do estado Criar Tetraminos
estado_Jogo             EQU 3		 ; Valor do estado Jogo
estado_Suspender        EQU 4		 ; Valor do estado Suspender
estado_Gameover         EQU 5		 ; Valor do estado Gameover
estado_About            EQU 6		 ; Valor do estado About
mascara_0_1bits 		EQU 3H		 ; Mascara para testar os primeiros 2 bits
mascara_2_3bits 		EQU 0CH		 ; Mascara para testar os bits 2 e 3
mascara_bit0			EQU 1H		 ; Mascara para testar o bit 0
mascara_bit1			EQU 2H		 ; Mascara para testar o bit 1
mascara_bit2			EQU 4H		 ; Mascara para testar o bit 2
mascara_bit3			EQU 8H		 ; Mascara para testar o bit 3
mascara_bit4			EQU 10H		 ; Mascara para testar o bit 4
mascara_bits_0_3		EQU 0FH		 ; Mascara para testar os primeiros 4 bits
mascara_bits_4_7		EQU 0F0H     ; Mascara para testar os ultimos 4 bits
mascara_bits_6_7		EQU 0C0H     ; Mascara para testar os ultimos 2 bits
sequencia_tetraminoI 	EQU 00H		 ; Valor atribuido a sequencia de variantes tetraminos I
sequencia_tetraminoL 	EQU 01H		 ; Valor atribuido a sequencia de variantes tetraminos L
sequencia_tetraminoT 	EQU 02H		 ; Valor atribuido a sequencia de variantes tetraminos T
sequencia_tetraminoS 	EQU 03H		 ; Valor atribuido a sequencia de variantes tetraminos S
sequencia_monstro 		EQU 00H		 ; Valor atribuido a sequencia do monstro
valor_rot_Max			EQU 3		 ; Valor de rotacoes permitidas ate reiniciar (0, 1 , 2 ,3)
valor_apos_decimal		EQU 0A0H 	 ; 1 valor que excede a base decimal na base hexadecimal
; ***********************************************************************
; * Ecras
; ***********************************************************************
PLACE       1500H
ecra_inicio:  						; ecra que due diz "Tetris Invaders, press B"
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00C1H, 0008H, 0021H, 0043H
STRING 00F7H, 007EH, 00EDH, 005FH
STRING 00F7H, 000EH, 00E3H, 0067H
STRING 00F7H, 007EH, 00EBH, 007BH
STRING 00F7H, 000EH, 00EDH, 0043H
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 0092H, 0049H, 0092H, 0049H
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00ADH, 0051H, 0031H, 0031H
STRING 00ADH, 0055H, 0057H, 0057H
STRING 00A5H, 0055H, 0057H, 0057H
STRING 00A5H, 0051H, 0051H, 003BH
STRING 00A9H, 0055H, 0051H, 005DH
STRING 00A9H, 00B5H, 0057H, 005DH
STRING 00ADH, 00B5H, 0031H, 0051H
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 0087H
STRING 00C4H, 0044H, 0045H, 00BBH
STRING 00C5H, 004CH, 00CFH, 0087H
STRING 00DCH, 00DFH, 0077H, 00BBH
STRING 00DDH, 0044H, 0045H, 00BBH
STRING 00FFH, 00FFH, 00FFH, 0087H
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH

ecra_fim: 							; ecra que diz "Game Over"
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00C0H, 0081H, 0099H, 0003H
STRING 00C0H, 0081H, 0099H, 0003H
STRING 00C7H, 0099H, 0081H, 003FH
STRING 00C7H, 0099H, 0081H, 003FH
STRING 00C7H, 0099H, 0081H, 003FH
STRING 00C7H, 0099H, 0081H, 0003H
STRING 00C7H, 0099H, 0081H, 0003H
STRING 00C7H, 0099H, 0081H, 0003H
STRING 00C8H, 0081H, 0081H, 0003H
STRING 00C8H, 0081H, 0081H, 003FH
STRING 00CCH, 0099H, 0099H, 003FH
STRING 00CCH, 0099H, 0099H, 003FH
STRING 00CCH, 0099H, 0099H, 003FH
STRING 00C0H, 0099H, 0099H, 0003H
STRING 00C0H, 0099H, 0099H, 0003H
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00C0H, 0099H, 0002H, 0007H
STRING 00C0H, 0099H, 0002H, 0077H
STRING 00CCH, 0099H, 003EH, 0077H
STRING 00CCH, 0099H, 0002H, 0077H
STRING 00CCH, 0099H, 0002H, 0007H
STRING 00CCH, 00DBH, 0002H, 001FH
STRING 00CCH, 00DBH, 003EH, 004FH
STRING 00C0H, 00C3H, 0002H, 0067H
STRING 00C0H, 00E7H, 0002H, 0067H
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH

ecra_about:							; ecra com os nomes de quem fez o projeto
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00DDH, 0013H, 0019H, 00AFH
STRING 00C9H, 0055H, 007AH, 00ABH
STRING 00D5H, 0055H, 0018H, 00DFH
STRING 00DDH, 0015H, 007AH, 00DBH
STRING 00DDH, 0053H, 0019H, 00DFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00C4H, 0044H, 0054H, 0047H
STRING 00CCH, 00ECH, 00D4H, 00CFH
STRING 00DFH, 006DH, 00D5H, 00F7H
STRING 00C4H, 006CH, 006CH, 0047H
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00CEH, 00DAH, 008BH, 00DFH
STRING 00D5H, 004AH, 009BH, 00AFH
STRING 00D4H, 0052H, 00BBH, 008FH
STRING 00CDH, 005AH, 0088H, 00AFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00C6H, 00DAH, 0022H, 003FH
STRING 00CDH, 004BH, 006AH, 007FH
STRING 00F4H, 0053H, 006BH, 00BFH
STRING 00C5H, 005BH, 0062H, 003FH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH

tetraminos:							; Tabela com os 4 tetraminos diferentes
WORD tetraminoI
WORD tetraminoL
WORD tetraminoT
WORD tetraminoS

tetraminoI:							; Tabela com as variantes do tetramino I
WORD tetraminoI1
WORD tetraminoI2
WORD tetraminoI3
WORD tetraminoI4

tetraminoI1:
STRING 4, 1							; dimensao - linhas e colunas
STRING 1
STRING 1
STRING 1
STRING 1
		
tetraminoI2:
STRING 1, 4							; dimensao - linhas e colunas
STRING 1, 1, 1, 1
			
tetraminoI3:
STRING 4, 1							; dimensao - linhas e colunas
STRING 1
STRING 1
STRING 1
STRING 1
		
tetraminoI4:
STRING 1, 4							; dimensao - linhas e colunas
STRING 1, 1, 1, 1
	
tetraminoL:							; Tabela com as variantes do tetramino L
WORD tetraminoL1
WORD tetraminoL2
WORD tetraminoL3
WORD tetraminoL4

tetraminoL1:
STRING 3, 2							; dimensao - linhas e colunas
STRING 1, 0
STRING 1, 0
STRING 1, 1
			
tetraminoL2:
STRING 2, 3							; dimensao - linhas e colunas
STRING 1, 1, 1
STRING 1, 0, 0
			
tetraminoL3:
STRING 3, 2							; dimensao - linhas e colunas
STRING 1, 1
STRING 0, 1
STRING 0, 1
			
tetraminoL4:
STRING 2, 3							; dimensao - linhas e colunas
STRING 0, 0, 1
STRING 1, 1, 1
		
tetraminoS:							; Tabela com as variantes do tetramino S
WORD tetraminoS1
WORD tetraminoS2
WORD tetraminoS3
WORD tetraminoS4

tetraminoS1:
STRING 2, 3							; dimensao - linhas e colunas
STRING 0, 1, 1
STRING 1, 1, 0
		
tetraminoS2:
STRING 3, 2							; dimensao - linhas e colunas
STRING 1, 0
STRING 1, 1
STRING 0, 1
			
tetraminoS3:
STRING 2, 3							; dimensao - linhas e colunas
STRING 1, 1, 0
STRING 0, 1, 1
			
tetraminoS4:
STRING 3, 2							; dimensao - linhas e colunas
STRING 0, 1
STRING 1, 1
STRING 1, 0
			
tetraminoT:							; Tabela com as variantes do tetramino T
WORD tetraminoT1
WORD tetraminoT2
WORD tetraminoT3
WORD tetraminoT4

tetraminoT1:
STRING 2, 3							; dimensao - linhas e colunas
STRING 1, 1, 1
STRING 0, 1, 0
			
tetraminoT2:
STRING 3, 2							; dimensao - linhas e colunas
STRING 0, 1
STRING 1, 1
STRING 0, 1
		
tetraminoT3:
STRING 2, 3							; dimensao - linhas e colunas
STRING 0, 1, 0
STRING 1, 1, 1
			
tetraminoT4:
STRING 3, 2							; dimensao - linhas e colunas
STRING 1, 0
STRING 1, 1
STRING 1, 0

monstro:
STRING 3, 3							; dimensao - linhas e colunas
STRING 1, 0, 1
STRING 0, 1, 0
STRING 1, 0, 1

; ***********************************************************************
; * Definir SP
; ***********************************************************************
PLACE 1000H
pilha:
	table 100H               ; Tabela para stack pointer
SP_pilha:					 ; Etiqueta com o endereço final da pilha

; *********************************************************************************
; * Tabela de Interrupções
; *********************************************************************************
;Place 2500H
; Tabela de vectores de interrupção
tab_int:        WORD    int0
				WORD    int1

; *********************************************************************************
; * Tabela de endereços de estados do loop de controlo
; *********************************************************************************

;PLACE       1500H

tab_estado:
    WORD Welcome     	; 0
	WORD Preparar_jogo	; 1
	WORD Criar_tetra    ; 2
	WORD Jogo 			; 3
	Word Suspender 		; 4 
	Word Gameover 		; 5
	Word About 			; 6
estado_programa:        ; variavel que guarda o estado actual do controlo
    STRING 0H; Comeca no welcome

; ***********************************************************************
; * Código
; ***********************************************************************

PLACE      0
inicializacao:		     ; Inicializações gerais
	MOV  SP, SP_pilha
	MOV  BTE, tab_int	 ; Inicializacao BTE
	EI
	;EI1
; ***********************************************************************
; * Estados
; * Código
; * Código
; * Código
; * R0 R1
; ***********************************************************************
loop_estados:
	MOV R0, estado_programa ; Obter o estado atual do programa
	MOVB R1, [R0]			; R1 com o valor correspondente ao estado atual
	SHL R1,1  				; Multiplicar por dois visto os endereços de 2 bytes em 2 (WORDS)
	MOV   R0, tab_estado    ; Endereço base dos processos do jogo
    ADD   R1, R0            ; Agora R0 aponta para a rotina correspondente ao estado actual
    MOV   R0, [R1]          ; Obter o endereço da rotina a chamar
    CALL  R0                ; Invoca o processo correspondente ao estado atual
    JMP   loop_estados      ; Volta a correr o loop de estados
	
; ***********************************************************************
; * Rotina Welcome
; ***********************************************************************

Welcome:
	PUSH R0					; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R3
	MOV  R1, 255           ; Corresponde ao valor FF no ecra
	CALL ecra_segmentos	   ; Chama a rotina que atualiza o display hexadecimal
	MOV R0, ecra_inicio	   ; Mete em R0 a tabela para escrever
	CALL escreve_tabela_ecra ; Chama a rotina que escreve a tabela no pixelscreen
esperar_tecla:
	CALL teclado 		   ; Chama a rotina que varre o teclado
	MOV R0, adr_Tecla_Valor ; Mete em R0 o endereco onde esta guardada a tecla pressionada
	MOVB R2,[R0]		   ; Mete em R2 o valor da tecla que esta na memoria
	MOV R3, tecla_jogar    ; Mete em R3 o valor da tecla jogar
	CMP R2, R3 			   ; Verifica se e a tecla pressionada e a de jogar
	JNZ esperar_tecla      ; Se nao for continua a espera de uma tecla
	MOV R0, estado_programa ; Obtem o endereco do estado do programa
	MOV R1, estado_Preparar_jogo ; Obtem o valor do estado de prepara o jogo 
	MOVB [R0], R1		   ; Atualiza o estado do programa com o estado de preparar o jogo 
	POP R3				   ; Devolve Registos
	POP R2
	POP R1
	POP R0
	RET					   ; Termina a rotina
	
; *********************************************************************************
; * Rotina Suspender
; *********************************************************************************
	
Suspender:
    PUSH R1 				; Guarda registos
    PUSH R2 
	PUSH R3
	DI    					; Desliga as interrupcoes
    CALL inverte_ecra 		; Chama a rotina de inverter o ecra para diferenciar do estado normal de jogo
ciclo_suspender:
    CALL  teclado 			; Chama a rotina do teclado e devolve em R1 a tecla pressionada
    MOV   R2, tecla_jogar 	; Atualiza R2 com o valor da tecla de suspender
	MOV   R1, adr_Tecla_Valor ; Vai a memoria buscar o valor da tecla carregada
	MOVB   R3, [R1]         ; Mete em registo o valor da memoria
    CMP   R3, R2 			; Verifica se a tecla pressionada e a tecla de suspender
    JNZ   ciclo_suspender 	; Caso nao seja a tecla de suspender, repete ate receber a tecla de suspender para tirar do modo de pausa
    MOV   R2, estado_Jogo	; Atualiza R2 com o novo estado (estado jogar)
    MOV   R1, estado_programa ; Mete em R1, o endereco do estado_programa
    MOVB  [R1], R2 			; Atualiza o estado_programa com o novo estado
    CALL inverte_ecra       ; Chama a rotina que inverte o ecra para criar um efeito visual
	EI						; Liga as interrupcoes
	POP R3  				; Retorna registos
    POP R2
    POP R1 
    RET 					; Termina a rotina

; *********************************************************************************
; * Rotina About
; *********************************************************************************

About:
	PUSH R0 				; Guarda registos
	PUSH R1 
	PUSH R2 
	PUSH R3
	MOV R0, ecra_about 		; Guarda em R0 a tabela de strings ecra_about
	CALL escreve_tabela_ecra ; Chama a rotina para escrever no ecra a tabela de strings ecra_about
about_loop:
	CALL teclado 			; Chama a rotina que devolve o valor de uma tecla premida
	MOV R2, tecla_gameover  ; Atualiza R2 com o valor da tecla terminar
	MOV R1, adr_Tecla_Valor ; Vai buscar o valor da tecla carregada a memoria
	MOVB R3, [R1]           ; R3 com o valor da tecla na memoria
	CMP R3, R2 				; Verifica se a tecla e' a tecla de terminar
	JNZ verif_jogar 		; Se nao for verifica se e a de jogar
	MOV R2, estado_Gameover ; Atualiza R2 com o valor do novo estado (estado terminar)
	JMP terminar 			; Termina caso seja a tecla terminar
verif_jogar:
	MOV R2, tecla_jogar 	; Atualiza R2 com o valor da tecla jogar
	CMP R3, R2 				; Verifica se a tecla e' a tecla de jogar
	JNZ about_loop 			; Se nao for corre o loop outra vez
	MOV R2, estado_Preparar_jogo ; Atualiza R2 com o valor do novo estado (estado jogar)
terminar:
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOVB [R1], R2 			; Atualiza o estado programa com o valor do estado atual (estado terminar)
sair_about:
	POP R3 					; Retorna registos
	POP R2
	POP R1 
	POP R0 
	RET 					; Termina a rotina
; *********************************************************************************
; * Rotina Game Over
; *********************************************************************************

Gameover:
	PUSH R0 				; Guarda registos
	PUSH R1 
	PUSH R2
	DI1 ;Desativa a interrupção do monstro
	DI0 ;Desativa  a interrupcao da peca
	CALL inverte_ecra 		; Chama a rotina para inverter o ecra
	MOV R2, Flag_Pausa_Display ; Mete em R2 o endereco da flag que decide se cria ou nao tetraminos
	MOV R1, 1				; Valor que ativa a flag
	MOV [R2],R1			    ; Ativa a flag
	MOV R0, ecra_fim 		; Guarda em R0 a tabela de strings ecra_fim
	CALL escreve_tabela_ecra ; Chama a rotina para escrever no ecra a tabela de strings ecra_fim
	MOV R1,0				; Valor que desativa a flag
	MOV [R2],R1 			; Desativa a flag para nao acontecerem pausas nas outras rotinas
gameover_loop:
	CALL teclado 			; Chama a rotina que devolve o valor de uma tecla
	MOV R2, tecla_jogar 	; Atualiza R2 com o valor da tecla jogar
	MOV R1, adr_Tecla_Valor ; Vai buscar a memoria a tecla carregada do teclado
	MOVB R3, [R1]           ; R3 com o valor da tecla em memoria
	CMP R3, R2              ; Verifica se e a tecla de jogar
	JNZ verif_about 		; Se nao for verifica se e a de about
	MOV R2, estado_Preparar_jogo ; Atualiza R2 com o estado novo (estado preparar jogo)
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOVB [R1], R2 			; Atualiza o estado programa com o valor do estado atual (estado preparar jogo)
	JMP sair_gameover       ; Sai do modo gameover
verif_about:
	MOV R2, tecla_about 	; Atualiza R2 com o valor da tecla about
	CMP R3, R2 				; Verifica se e a tecla about
	JNZ gameover_loop 		; Volta a correr o loop gameover
	MOV R2, estado_About 	; Atualiza R2 com o estado novo (estado about)
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOVB [R1], R2 			; Atualiza o estado programa com o valor do estado atual (estado about)
sair_gameover:
	POP R2 					; RETorna registos
	POP R1 
	POP R0 
	RET 					; Termina a rotina
	
; *********************************************************************************
; * Rotina que cria prepara o jogo
; *********************************************************************************

Preparar_jogo:
	PUSH R0					; Guarda registos
	PUSH R1
	EI					    ; Liga as interrupcoes
	CALL limpar				; Chama a rotina que limpa o ecra
	CALL ecra_linhalateral 	; Chama a rotina para desenhar o limite lateral
	MOV R1,0 				; valor 00 para mostrar no ecra de segmentos
	CALL ecra_segmentos		; Chama a rotina que atualiza os displays hexadecimais
	MOV R0,pontuacao 		; Mete em R0 o endereco onde e guardado a pontuacao
	MOVB [R0],R1 			; Reinicia a pontuacao do jogo para 0
	MOV R0,monstro_ativo    ; Endereco da flag que diz que se existe ou nao um monstro ativo
	MOV [R0],R1 			; Define a flag como 0 (Nao existe monstro ativo)
	MOV R0, estado_programa ; Move o endereco do estado_programa para R0
	MOV R1, estado_Criar_Tetra 	; Atualiza R1 com o valor do estado jogar
	MOVB [R0], R1 			; Atualiza o valor do estado_programa para o estado atual (estado jogar)
	POP R1					; Retorna registos
	POP R0
	RET						; Termina a rotina
	
	

; *********************************************************************************
; * Rotina que permite a criacao das pecas quANDo necessario
; *********************************************************************************
Criar_tetra:
	AND R0,R0 ; BUG pepe, por vezes o pepe nao excuta o PUSH R0 deixo o professor testar por si proprio ao comentar este codigo
	PUSH R0					; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R8
	PUSH R9
	PUSH R10
	CALL apagar_linha 		; Chama a rotina que verifica se ha linhas completas para apagar e apaga
	MOV R1,1				; Mete em R1 o valor para ativar a flag que decide se existe tetraminos para criar ou nao
	MOV [R0],R1 			; Ativa a flag
	MOV R1, adr_Nr_rANDom   ; Mete em R1 o endereco onde e guardado o valor aleatorio de selecao dos tetraminos
	MOV R0, [R1] 			; Vai buscar a memoria o valor aleaorio para R0
	MOV R1, mascara_0_1bits ; Mete em R1 o valor da mascara para testar os primeiros 2 bits
	AND R0, R1 				; Isola os primeiros 2 bits do numero aleatorio
select_tetra:
	MOV R1,0 				; Valor inicial da tabela dos tetraminos
	CMP R0, sequencia_tetraminoI ; Verifica se a tabela e a tabela de variantes do tetramino I
	JZ write_tab_tetra		; Se for salta para atualizar a tabela de tetraminos 
	ADD R1,1				; Atualiza o valor da tabela
	CMP R0, sequencia_tetraminoL ; Verifica se a tabela e a tabela de variantes do tetramino L
	JZ write_tab_tetra
	ADD R1,1				; Atualiza o valor da tabela
	CMP R0, sequencia_tetraminoT ; Verifica se a tabela e a tabela de variantes do tetramino T
	JZ write_tab_tetra
	ADD R1,1				; Atualiza o valor da tabela
	CMP R0, sequencia_tetraminoS ; Verifica se a tabela e a tabela de variantes do tetramino S
	JZ write_tab_tetra
write_tab_tetra:
	MOV R8, adr_x 			; Mete em R8 o endereco onde e guardado a posicao das colunas do tetramino
	MOV R3, 6				; Valor inicial da coluna onde desenhar o tetramino
	MOVB [R8],R3 			; Atualiza a memoria com o valor da coluna
	MOV R8, adr_y 			; Mete em R8 o endereco onde e guardado a posicao das linhas do tetramino
	MOV R3, 0				; Valor inicial da linha onde desenhar o tetramino
	MOVB [R8], R3 			; Atualiza a memoria com o valor da linha
	MOV R2, tetraminos 		; Mete em R2 o endereco da tabela para selecionar o tetramino a ser desenhado
	SHL R1,1 				; Multiplica por 2 por serem WORDS (2 em 2 bytes)
	ADD R2, R1				; Atualiza o valor da tabela que vai ser selecionada
	MOV R1, [R2] 			; Mete em R1 o endereco da tabela selecionada
	MOV R0, adr_tetra_tipo  ; Mete em R0 o endereco que guarda a variante do tetramino (I, L, T, S)
	MOV [R0], R1 			; Mete a tabela escolhida dessas variantes em na memoria
	MOV R0, adr_tetra_rot 	; Mete em R0 o endereco que guarda as rotacoes de cada tetramino (1, 2, 3, 4)
	MOV R1, 0H				; Mete em R1 o valor inicial 			
	MOV [R0], R1			; Mete em R0 o valor da primeira rotacao
	CALL load_tetra_x_y_rot_teste ; Chama a rotina que inicializa as variaveis necessarias para desenhar o tetramino
	CALL verifica_desenhar	; Chama a rotina que verifica se pode ou nao desenhar o tetramino
	AND R10,R10				; Testa a flag recebida de verifica_desenhar, se for 0 nao desenha se for 1 desenha
	JZ criar_tetra_gameover ; Nao desenha
	MOV R9,1				; Flag que permite distinguir entre apagar ou desenhar o tetramino, 1 desenha e 0 apaga, e recebida por desenhar_tetra
	CALL desenhar_tetra		; Chama a rotina que desenha os tetraminos
	EI0
rANDom_monstro:
	MOV R0,monstro_ativo 	; Mete em R0 o endereco onde e guardada a flag que diz se existe ou nao monstros ativos
	MOV R1,[R0]				; Mete em R1 o valor da flag
	AND R1,R1 				; Testa a flag se 1 existe monstro, se 0 nao existe
	JNZ fim_Criar_Tetra 	; Nao desenha monstro
	MOV R1, adr_Nr_rANDom	; Mete em R1 o endereco que guarda o valor aleatorio
	MOV R0, [R1] 			; Mete em R0 o valor do numero aleatorio na memoria
	MOV R1, mascara_2_3bits ; Mete em R1 a mascara que testa os bits 2 e 3
	AND R0, R1				; Isola os bits 2 e 3 do numero aleatorio
	CMP R0, sequencia_monstro ; Verifica se R0 corresponde ao valor da sequencia_monstro
	JZ criar_monstro		; Desenha o monstro
	JMP fim_Criar_Tetra     ; Acaba
criar_monstro:
	MOV R0,monstro_ativo 	; Mete em R0 o endereco onde e guardada a flag que diz se existe ou nao monstros ativos 	
	MOV R1,1				; Valor que ativa a flag 
	MOV [R0],R1 			; Ativa a flag
	MOV R0, adr_x_monstro	; Mete em R0 o endereco onde e guardado o valor da coluna do monstro
	MOV R1, x_monstro_inicial ; Mete em R1 o valor inicial da coluna onde desenhar o monstro
	MOVB [R0],R1			; Guarda na memoria o valor 
	MOV R9,1				; Flag que permite distinguir entre apagar ou desenhar o tetramino, 1 desenha e 0 apaga, e recebida por desenhar_tetra 
	CALL desenhar_monstro   ; Chama a rotina que desenha o monstro
	EI1						; Liga as interrupcoes do monstro
	JMP fim_Criar_Tetra		; Acaba
criar_tetra_gameover:
	MOV R0, teclado_Jumper_FLAG ; Mete em R0 o endereco onde esta guardada a flag
	MOV R1, [R0]			; Mete em R1 o valor da flag
	SET R1, 3 				; Liga o 3 bit da flag
	MOV [R0],R1				; Volta a guardar na memoria o valor da flag
fim_Criar_Tetra:
	MOV R0, estado_programa ; Meter em R0 o endereco do estado_programa
	MOV R1, estado_Jogo 	; Meter em R1 o valor do estado	jogo
	MOVB [R0], R1 			; MOVer para o estado_programa o estado atual
	POP R10					; Deolve Registos
	POP R9
	POP	R8
	POP R3
	POP R2
	POP R1
	POP R0
	RET						; Termina a rotina
	
; *********************************************************************************
; * Rotina que permite jogar
; *********************************************************************************
Jogo:
	PUSH R0					; Guarda Registos
	PUSH R1
	PUSH R2 
	PUSH R3
	PUSH R8
	PUSH R9
esperar_tecla_jogo:
	CALL teclado 			; Chama a rotina do teclado e devolve uma tecla em memoria
	MOV R0, adr_Tecla_Valor ; Vai buscar para R0 o endereco onde esta a tecla carregada
	MOVB R2,[R0] 			; R2 com o valor da tecla carregada da memoria
	MOV R3, tecla_pausa 	; Mete em R3 o valor da tecla de pausa
	CMP R2, R3 				; Verifica se e a tecla de pausa
	JNZ verif_tecla_gameover ; Se nao for a tecla de pausa verifica se e a de terminar
	MOV R0, estado_programa ; Meter em R0 o endereco do estado_programa
	MOV R1, estado_Suspender ; Meter em R1 o valor do estado suspender 
	MOVB [R0], R1 			; MOVer para o estado_programa o estado atual
	JMP jogo_fim 			; Sai do modo jogo
verif_tecla_gameover:
	MOV R3, tecla_gameover  ; R3 com o valor da tecla de terminar
	CMP R2, R3 				; Verifica se e a tecla de terminar
	JNZ verif_tecla_rodar ; Se nao for espera por uma nova tecla	
	MOV R0, estado_programa ; Meter em R0 o endereco do estado_programa
	MOV R1, estado_Gameover ; Meter em R1 o valor do estado gameover
	MOVB [R0], R1 			; MOVer para o estado_programa o estado atual
	JMP jogo_fim 			; Sai do modo jogo
verif_tecla_rodar:
	MOV R3, tecla_rodar 	; R3 com o valor da tecla de rodar
	CMP R2, R3 				; Verifica se e a tecla de rodar
	JNZ verif_tecla_direita ; Se nao for verifica se e a de MOVer direita
	CALL rodar_tetra 		; Chama a rotina que roda o tetramino
	JMP esperar_tecla_jogo  ; Volta a esperar por uma tecla
verif_tecla_direita:
	MOV R3, tecla_direita 	; R3 com o valor da tecla para MOVer para a direita
	CMP R2, R3 				; Verifica se e a tecla de MOVer para a direita
	JNZ verif_tecla_esquerda ; Se nao for verifica se e a de MOVer para a esquerda
	MOV R9, 1 				; R9 vai ser recebido pela rotina de MOVer o tetramino (1 - direita)
	CALL MOVer_tetramino 	; Chama a rotina que MOVe o tetramino
	JMP esperar_tecla_jogo 	; Volta a esperar por uma tecla
verif_tecla_esquerda:
	MOV R3, tecla_esquerda  ; R3 com o valor da tecla para MOVer a esquerda
	CMP R2, R3 				; Verifica se e a tecla de MOVer para a esquerda
	JNZ verif_tecla_descer 	; Se nao for verifica se e a tecla de descer a peca
	MOV R9, 0 				; R9 vai ser recebido pela rotina de MOVer o tetramino (0 - esquerda)
	CALL MOVer_tetramino 	; Chama a rotina que MOVe o tetramino
	JMP esperar_tecla_jogo  ; Volta a esperar por uma tecla
verif_tecla_descer:
	MOV R3, tecla_descer 	; R3 com o valor da tecla para descer
	CMP R2, R3 				; Verifica se e a tecla de MOVer para a esquerda
	JNZ verif_tecla_sair_estado ; Ira forcar a saida do modo Jogo
	CALL descer_tetra 		; Chama a rotina para descer o tetramino
	JMP esperar_tecla_jogo  ; Volta a esperar por uma tecla
verif_tecla_sair_estado:
	MOV R3, tecla_sair_estado ; Mete em R3 o valor da tecla para sair dos estados
	CMP R2, R3 				; Verifica se e a tecla de forcar a saida do modo jogo
	JNZ esperar_tecla_jogo 	; Caso nao for nenhuma das teclas continuar a espera por tecla
	JMP jogo_fim 			;Sai do modo jogo
jogo_fim:
	POP R9					; Devolve Registos
	POP R8
	POP R3 
	POP R2
	POP R1
	POP R0
	RET						; Termina a rotina
	
; **********************************************************************
; * Desenha Monstro
; *  Inicia as posicoes onde desenhar o monstro
; *Entradas:
; * Recebe da Memoria para os registos:
; *  R0 - Tabela de strings do monstro
; *  R2 - Linha da posicao onde desenhar
; *  R3 - Coluna da posicao onde desenhar
; *Saídas:
; *  R2 e R3 nao alterados
; **********************************************************************
desenhar_monstro:
	PUSH R0					; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	MOV R0, monstro			; Tabela de strings que corresponde ao monstro
	;ir buscar x e y do monstro
	MOVB R4,[R0] 			; Valor da linha
	ADD R0,1 				; Acede ao proximo elemento da tabela que corresponde a coluna
	MOVB R5,[R0]			; Valor da coluna
	MOV R2, const_y_monstro ; Usa o valor constante da linha do monstro
	MOV R8, adr_x_monstro 	; Acede ao endereco que contem os valores da coluna
	MOVB R3, [R8] 			; Mete em R3, o valor da coluna onde comecar a desenhar	
	MOV R7, R4				; Duplica o valor das linhas em registo para criar 1 contador
	MUL R7, R5 				; Multiplica o valor das linhas pelas colunas, para criar 1 contador do numero de elementos da tabela
	ADD R3, R5 				; Permite repor corRETamente os contadores
	SUB R2, 1 				; Permite repor corRETamente os contadores
	CALL completar_desenho 	; Chama a rotina que conclui o desenho
	POP R8					; Devolve Registos
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
; * Desenha Tetramino
; *  Inicia as posicoes onde desenhar o tetramino
; *Entradas:
; * Recebe da Memoria:
; *	 R0 - Tabela de strings do tetramino a desenhar
; *  R2 - Linha da posicao onde desenhar
; *  R3 - Coluna da posicao onde desenhar
; *Saídas:
; *  R2 e R3 nao alterados
; **********************************************************************

desenhar_tetra:
	PUSH R0					; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	MOV R0, adr_tetra_tipo	; Mete em R0 o endereco onde e guardado a tabela de variantes dos tetraminos
	MOV R1,[R0]				; Guarda em R1 a tabela
	MOV R0, adr_tetra_rot 	; Mete em R0 o endereco onde e guardado a rotacao a desenhar
	MOV R2, [R0]			; Guarda em R2 a tabela
	SHL R2,1 				; Multiplica por 2
	ADD R1,R2 				; Valor da tabela a desenhar
	MOV R0,[R1]				; Atualiza a tabela
	;ir buscar x e y do tetramino 
	MOVB R4,[R0] 			; Valor da linha
	ADD R0,1 				; Acede ao proximo elemento da tabela que corresponde a coluna
	MOVB R5,[R0]			; Valor da coluna
	MOV R8, adr_y 			; Atualiza R0 com o valor correspondente a linha inicial onde desenhar o tetramino
	MOVB R2, [R8] 			; Mete em R2, o valor da linha onde comecar a desenhar
	MOV R8, adr_x 			; Acede a tabela que contem as posicoes 
	MOVB R3, [R8] 			; Mete em R3, o valor da coluna onde comecar a desenhar	
	MOV R7, R4 				; Duplica o valor das linhas em registo para criar 1 contador
	MUL R7, R5				; Multiplica o valor das linhas pelas colunas, para criar 1 contador do numero de elementos da tabela
	ADD R3, R5 				; Permite repor corRETamente os contadores
	SUB R2, 1 				; Permite repor corRETamente os contadores
	CALL completar_desenho  ; Chama a rotina que conclui o desenho
	POP R8					; Devolve Registos
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET						; Termina a rotina
	
; **********************************************************************
; * Completar Desenho
; *  Com as inicializacoes feitas nas rotinas desenhar monstro e tetramino, termina o desenho
; *Entradas:
; *  R9 - 1 (escreve) ou 0 (apaga)
; * Recebe da Memoria:
; *  R0 - Tabela de strings do tetramino a desenhar
; *  R2 - Linha da posicao onde desenhar
; *  R3 - Coluna da posicao onde desenhar
; *Saídas:
; *  R2 e R3 nao alterados
; **********************************************************************
completar_desenho:
	PUSH R0					; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R9
repor_colunas:
	MOV R6, R5 				; Duplica o valor das colunas em registo para fazer um contador
	SUB R3, R5 				; Repoe o valor da coluna onde escrever
	ADD R2, 1 				; Muda a linha onde escrever
loop_desenhar_tetra:
	ADD R0, 1 				; Acede ao proximo elemento da tabela
	MOVB R1, [R0] 			; R1 com o valor a escrever no ecra
	AND R1, R1 				; Afeta as flags
	JZ nao_desenhaR0 		; Se for 0 nao desenha
	MOV R1,R9
	CALL desenhar_pixel 	; Chama a rotina que desenha 1 pixel da tabela de strings
nao_desenhaR0:
	SUB R7,1				; Atualiza os contadores
	JZ fim_desenhar_tetra 	; Se ainda nao acabou corre outra vez
	ADD R3, 1 				; Muda a coluna onde escrever
	SUB R6, 1 				; Atualiza o contador de colunas
	JZ repor_colunas 		; Se for 0 repoe as colunas
	JMP loop_desenhar_tetra ; Corre o loop ate tar tudo desenhado
fim_desenhar_tetra:
	POP R9					; Devolve Registos
	POP R7
	POP R6
	POP R5
	POP R3
	POP R2
	POP R1
	POP R0
	RET						; Termina a rotina

; **********************************************************************
; Teclado
;   Verifica se alguma tecla foi premida e guarda o valor na memória
; Entradas
;   Nenhuma
; Saídas 
;   Guarda na memória (100H) o valor da tecla
; 
; **********************************************************************
teclado:
	PUSH R1					; Guarda registos
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R8
	PUSH R10
	CALL definir_Linha
	POP R10
	POP R8
	POP R6					; RETorna registos
	POP r5
	POP R4
	POP R3
	POP R2
	POP R1
	RET
	
;definir_
definir_Linha:             	; Redifine a linha quANDo o SHR chegar a 0
	CALL rANDom 			; Criar numeros aleatorios
	MOV  R1, linha         	; Valor maximo das linhas  
	MOV R2,teclado_Jumper_FLAG
	MOV R3,[R2]
	AND R3,R3   			;Se existe valor no Jumper_Flag
	JNZ CALL_Jumper_Flag 	;vai chamar a rotina que vai lidar com as flags
	JMP scan_Teclado
CALL_Jumper_Flag:
	CALL Jumper_FLAG
	CMP R10,forcar_saida 	;Ver se a saida do Jumper_FLAG e forcar a saida para o loop de estado
	JZ forcar_saida_estado
	JMP definir_Linha
forcar_saida_estado:
	MOV R6, tecla_sair_estado ;carrega uma tecla inacessivel no teclado que ira fazer ir para o loop estado
	JMP gravar_Mem_Teclado ;e vai gravar na memoria como se tivesse sido pressionada
scan_Teclado:              	; Rotina que lê o teclado 
	MOV  R2, out_Teclado   	; R2 fica com o valor 0C000H(porto de escrita)
	MOVB [R2], R1      	   	; Escreve no periférico de saída
	MOV  R2, in_Teclado    	; R2 fica com o valor 0E000H(porto de leitura)
    MOVB R3, [R2]      	   	; Lê do periférico de entrada	
	MOV R8, 0FH				; Mascara para isolar apenas os primeiros 4 bits
    AND  R3, R8      	   	; Isola apenas os bits do teclado com a mascara_bits_0_3
    JZ   mudar_Linha       	; Se nenhuma foi tecla premida, muda de linha
    JMP  tecla_Pressionada 	; Caso tecla premida, começa a função
mudar_Linha:
	SHR  R1,1			   	; Vai alterANDo a linha a varrer
	JZ   alterar_Flag_T_Press ; Verificar estado da tecla apos varrimento das 4 linhas
	JMP  scan_Teclado      	; Caso ainda não acabou o varrimento de todas as linhas, fazer scan linha seguite
alterar_Flag_T_Press:
	MOV R3, Flag_Tecla_Pressionada
	MOV R2,0 				;Definir tecla nao clicada
	MOV [R3],R2
	JMP definir_Linha


tecla_Pressionada:         	; Verifica qual a tecla premida
	MOV r5, 0 			   	; Redifinir contadores
	MOV R6, 0 
	CALL linha_Count
	CALL coluna_Count
	CALL transform_Hex
	CALL gravar_Mem_Teclado
	RET					   	; Termina a rotina
linha_Count:               	; Ciclo que conta o nº de linhas
	ADD  R5,1			   
	SHR  R1,1			   	; Conta o nº de shift ate dar 0
	JNZ  linha_Count
	SUB  R5,1 			   	; Fazer o contador comecar em 0
	RET		               	; Vai para coluna_Count

coluna_Count:              	; Ciclo que conta o nº de colunas
	ADD  R6,1 			   
	SHR  R3,1			   	; Conta o nº de shift ate dar 0
	JNZ  coluna_Count
	SUB  R6,1 			   	; Fazer o contador comecar em 0
	RET

transform_Hex:             	; Vai transformar o numero de colunas e linhas no valor do teclado
	SHL  R5,2 			   	; Multiplica por 4,valor a somar a linha
	ADD  R6,R5			   	; Valor da tecla em R6
	RET

gravar_Mem_Teclado:
    MOV  R4, adr_Tecla_Valor        
	MOVB [R4], R6      	   	; Guarda tecla premida na memória de endereço 100H
	RET
	
; **********************************************************************
; * Atualiza Ecra de segmentos
; *  Atualiza a pontuacao
; *Entradas:
; *  R10 - Valor a somar(nao e capaz de somar valores superiores a 5)
; *Saídas:
; *  Nenhuma
; **********************************************************************
soma_ecra_segmentos:
	PUSH R0				   	; Guarda registos
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R10
	MOV R1,0 				; Contador caso aconteca descrepancia na base das unidades 
	MOV  R0, pontuacao   	; Vai buscar o endereco da pontuacao 
	MOVB R2,[R0] 			; Le a pontuacao
	ADD R2,R10 				; Adiciona a R2 o valor que queriamos somar
	MOV R3,R2
	MOV R4,mascara_bits_0_3 ; Mete em R3 a mascara que isola os primeiros 4 bits
	AND R3, R4  			; Isola o ecra das unidades
	MOV R4,valor_max_decimal
	DIV R3,R4 ;verificar se as unidades ultrapassarem a base decimal
	JZ gravar_pontuacao ;se a soma nao mexe o digito das dezenas grava
	
	
	MOV R3,R2 ;volta a fazer backup
	MOV R4, mascara_bits_0_3;vai buscar as unidades
	AND R3,R4
	MOV R4,valor_max_decimal;e vamos calcular o resto
	MOD R3,R4;Obtendo as unidades na base decimal
	
	MOV R4, mascara_bits_4_7
	AND R2,R4 ;isola as dezenas
	
	MOV R4,10H
	ADD R2, R4 ;adiciona 1 dezena visto q ultrapassou a base decimal nas unidades
	
	MOV R4,valor_apos_decimal ;vamos verificar  se ja passamos o valor 99
	CMP R2,R4 ; se o valor das dezenas passar a base decimal
	JZ gameover_pontuacao 
	

	add R2,R3 ;adiciona as unidades 
	
	

	
	JMP gravar_pontuacao
	
gravar_pontuacao:
	MOVB [R0],R2           	; Grava nova pontuacao na memoria
	MOV R0,local_Segmentos 	; Vai buscar o endereco do ecra de segmentos
	MOVB [R0],R2           	; Escrever no display o valor da tecla	
	JMP fim_soma_ecra_segmentos
gameover_pontuacao:
	MOV R0, teclado_Jumper_FLAG
	MOV R1, [R0]
	SET R1, 3 				; Liga o bit 3 de R1
	MOV [R0],R1 			; Mete no Jumper flag a flag que forca o game over
fim_soma_ecra_segmentos:
	POP R10				   	; RETorna registos
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET						; Termina a rotina

; **********************************************************************
; * Escreve no ecra de segmentos
; *  Desenha ou apaga um pixel no ecrã com base nas linhas e colunas
; *Entradas:
; *  R1 - Valor a escrever 

; *Saídas:
; *  Nenhuma
; **********************************************************************
ecra_segmentos:             ; Mostra que tecla foi premida, no ecra de segmentos
	PUSH R0				   	; Guarda registos
	PUSH R1
	PUSH R2
	MOV  R0, local_Segmentos ; Define endereço de escrita display (0A000H)
	MOVB [R0],R1           ; Escrever no display o valor da tecla
	POP  R2				   ; RETorna registos
	POP  R1
	POP  R0
	RET						; Termina a rotina

; **********************************************************************
; * Rotina que atualiza a jumper flag
; *  Define a flag caso se perca ou nao
; *Entradas:
; *  Recebe da memoria para os registos:
; *  	R2 - endereco da memoria para teclado_Jumper_FLAG
; *  	R3 - valor do teclado_Jumper_FLAG
; *Saídas:
; *  	R10- 1-caso seja para forcar a saida para loop de estados
; **********************************************************************
Jumper_FLAG:
	PUSH R2
	PUSH R3
	PUSH R4
	MOV R10,0 				; Carrega a saida da routina como 0 
	MOV R4, mascara_bit4 	; Mete em R4 o valor que permite isolar o bit 4, porque e prioritario
	AND R4,R3				; Isola o bit 4
	JNZ force_Criar_Tetra	; que representa a flag de forcar modo Criar Tetra
	MOV R4,mascara_bit0 	; Mete em R4 o valor que permite isolar o bit 0
	AND R4,R3
	JNZ CALL_descer_tetra 	; que representa a flag do descer_tetra
	MOV R4, mascara_bit1 	; Mete em R4 o valor que permite isolar o bit 1
	AND R4,R3
	JNZ CALL_MOVer_monstro	; que representa a flag do MOVer monstro
	MOV R4, mascara_bit2 	; Mete em R4 o valor que permite isolar o bit 2
	AND R4,R3
	JNZ clear_flag_tecla	; que representa a flag de que uma tecla esta presisonada
	MOV R4, mascara_bit3 	; Mete em R4 o valor que permite isolar o bit 3
	AND R4,R3
	JNZ force_gameover		; que representa a flag de forcar modo gameover
	JMP fim_JUMPER
CALL_MOVer_monstro:
	CLR R3,1
	MOV [R2],R3 			;Gravar alteracoes na Jumper_FLAG
	CALL MOVer_monstro
	JMP fim_JUMPER
CALL_descer_tetra:
	CLR R3,0
	MOV [R2],R3 			;Gravar alteracoes na Jumper_FLAG
	CALL descer_tetra
	JMP fim_JUMPER
clear_flag_tecla:
	CLR R3,2
	MOV [R2],R3 			;Gravar alteracoes na Jumper_FLAG
	JMP fim_JUMPER
force_gameover:
	DI 						; Desativa interrupcoes visto q acaba o jogo
	MOV R3,0 				; Apagas as flags para nao ocorrerem apos o gameover
	MOV [R2],R3 			; Gravar alteracoes na Jumper_FLAG
	MOV R2, estado_Gameover ; Atualiza R2 com o estado novo (estado Gameover)
	MOV R4, estado_programa ; Atualiza R4 com o endereco do estado programa
	MOVB [R4], R2 			; Atualiza o estado programa com o valor do estado atual (estado Gameover)
	MOV R10,forcar_saida 	; Carrega a saida da rotina de modo a forcar saida do estado atual para o loop de estado
	JMP fim_JUMPER	
force_Criar_Tetra:
	CLR R3,4
	MOV [R2],R3 			;Gravar alteracoes na Jumper_FLAG
	MOV R2, estado_Criar_Tetra ; Atualiza R2 com o estado novo (estado criar tetramino)
	MOV R4, estado_programa ; Atualiza R4 com o endereco do estado programa
	MOVB [R4], R2 			; Atualiza o estado programa com o valor do estado atual (estado criar tetramino)
	MOV R10,forcar_saida 	;Carrega a saida da rotina de modo a forcar saida do estado atual para o loop de estado
	JMP fim_JUMPER
fim_JUMPER:	
	POP R4					; Devolve Registos
	POP R3
	POP R2
	RET						; Termina a rotina
	
; *********************************************************************************
; * Rotina que limpa o ecra
; *********************************************************************************

limpar:
	PUSH R0 				; Guarda registos
	PUSH R1 
	PUSH R2 
	MOV R0, local_Ecra 		; R0 com o endereco do Ecra
	MOV R1, 128 			; Valor de bytes totais do ecra
	MOV R2, 00H 			; Valor que permite limpar todos os bytes do ecra
loop_limpar:
	MOVB [R0], R2 			; Limpa 1 byte do ecra
	ADD R0, 1 				; Acede ao byte seguinte do ecra
	SUB R1, 1 				; Atualiza o contador de bytes
	JNZ loop_limpar 		; Corre o loop outra vez ate todos os bytes estarem limpos
	POP R2 					; RETorna registos
	POP R1 
	POP R0 
	RET 					; Termina a rotina

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
    PUSH  R0				; Guarda Registos
    PUSH  R1
    PUSH  R2
    PUSH  R3
    PUSH  R4
    PUSH  R5
    PUSH  R6
    PUSH  R7
    PUSH  R8
	MOV R0, local_Ecra 		; Atualiza R0 com o endereco do ecra
	MOV R4, 4 				; Atualiza R4 com o numero de bytes de cada linha do ecra (linhas)
	MOV R5, 8 				; Atualiza R5 com o numero de bits por byte do ecra (colunas)
	MOV R6, 80H 			; (10000000) Mascara que permite escrever nas colunas de cada byte atraves de shifts
	MUL R4, R2 				; Transforma R2 numa linha do ecra
	ADD R0, R4 				; Acede a linha do ecra onde e suposto escrever
	MOV R7, R3 				; R7 com o valor da coluna para dividir pelo numero de colunas
	DIV R7, R5 				; Transforma R7 numa coluna da linha onde escrever
	ADD R0, R7 				; Acede a coluna onde escrever
	MOD R3, R5 				; R3 com o bit onde escrever (R3 sera um valor de 0-7 que sao o numero de colunas)
selecao_pixel:
	AND R3, R3 				; Afectar as flags
	JZ escrever_ou_apagar 	; QuANDo for o ultimo bit a verificar salta para decidir se desenha ou apaga
	SHR R6, 1 				; Atualiza a mascara para o bit seguinte ate ao bit onde e suposto escrever
	SUB R3, 1 				; Atualiza a coluna (avanca para o proximo bit)
	JMP selecao_pixel 		; Verifica os bits todos de R3
escrever_ou_apagar:
	MOVB R8, [R0] 			; MOVe para R8 o que esta escrito no byte do ecra
	AND R1, R1 				; Afectar as flags
	JNZ escrever			; Caso seja para escrever salta para escrever
	NOT R6 					; Nega a mascara para poder apagar o bit
	AND R8, R6 				; Apaga apenas o bit escolhido
	JMP fim_desenhar_pixel 	; Acaba de desenhar o pixel
escrever:
	OR R8, R6 				; Cria a mascara com o bit final a desenhar
fim_desenhar_pixel:
	MOVB [R0], R8 			; Escreve no ecra
    POP R8 					; Devolve Registos
    POP R7 
    POP R6
    POP R5 
    POP R4 
    POP R3 
    POP R2 
    POP R1 
    POP R0 
    RET 					; Termina rotina
	
; **********************************************************************
; Escreve Ecrã
;   Rotina que desenha uma tabela de strings no ecrã
; Entradas
;   R0 - Tabela de strings a escrever
; Saídas
;   Nenhuma
; *********************************************************************
escreve_tabela_ecra:     
    PUSH R0                 ; Guarda registos
    PUSH R1
    PUSH R2
    PUSH R3
	PUSH R4
    MOV R3, local_Ecra    	; Endereço do ecrã
	MOV R1,Flag_Pausa_Display ;Vai ver se o ecra q vamos apresentar vai usar a pausa
	MOV R4,[R1]				; Mete em R4 o valor da flag
    MOV R2, elem_tabelas  	; Número de elementos da tabela de strings
verificar_pausa_ecra:
	AND R4,R4				; Verifica se e preciso fazer pausa
	JNZ chamar_pausa 		; Vai chamar a pausa caso Flag_Pausa_Display for 1
	JMP ciclo_ecra
chamar_pausa:
	CALL pausa				; Chama a rotina que faz uma pausa
	JMP ciclo_ecra	
ciclo_ecra:  
    MOVB  R1, [R0]          ; Elemento actual da tabela de strings
    MOVB  [R3], R1          ; Escreve o elemento da tabela de strings no ecrã
    ADD   R0, 1             ; Acede ao índice seguinte da tabela de strings
    ADD   R3, 1             ; Avança para o byte seguinte do ecrã
    SUB   R2, 1             ; Actualiza o contador
    JNZ   verificar_pausa_ecra ; Volta ao ciclo para escrever o que falta
	POP R4                	; Recupera registos
    POP R3
    POP R2
    POP R1
    POP R0
    RET   					; Termina a rotina
	
; *********************************************************************************
; * Rotina que cria o limite lateral do ecra
; *********************************************************************************
ecra_linhalateral:
	PUSH R0 				; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R3
	MOV R0, 32 				; R0 com um contador para ver se todas as linhas estao pintadas
	MOV R1, 1 				; Valor a escrever
	MOV R2, 0 				; Linha inicial onde comecar a pintada
loop_desenharlinha:
	MOV R3, 12 				; Coluna fixa onde escrever o limite lateral
	CALL desenhar_pixel 	; Rotina que desenha 1 pixel
	SUB R0, 1 				; Atualiza o contador de linhas
	JZ fim_linhalateral 	; Se ja desenhou todas as linhas acaba
	ADD R2, 1
	JMP loop_desenharlinha 	; Corre o loop outra vez ate todas as linhas estarem pintadas
fim_linhalateral:
	POP R3 					; Devolve Registos
	POP R2
	POP R1
	POP R0
	RET 					; Termina a rotina
	
; **********************************************************************
; Inverte Ecrã
;   Inverte o ecrã
; Entradas:
;   Nenhuma
; Saidas:
;   Nenhuma
; **********************************************************************
inverte_ecra:
    PUSH  R0               	; Guarda registos
    PUSH  R1
    PUSH  R2
    MOV   R0, local_Ecra   	; Endereço do ecrã
    MOV   R1, elem_Ecra     ; Contador de bytes do ecrã
ciclo_inverte:
    MOVB  R2, [R0]         	; Obtem o byte actual do ecrã
    NOT   R2               	; Inverte o conteúdo do byte actual
    MOVB  [R0], R2         	; Coloca no ecrã o inverso do que estava escrito anteriormente
    ADD   R0, 1            	; Avança para o byte seguinte
    SUB   R1, 1            	; Actualiza o contador
    JNZ   ciclo_inverte    	; Enquanto que o contador for diferente de 0 tem que percorrer o ecrã
    POP   R2               	; Recupera registos
    POP   R1
    POP   R0
    RET                   	; Termina rotina

; **********************************************************************
; Pausa
;   Rotina que faz uma pausa.
; Entradas:
;    - 
; Saidas:
;   Nenhuma
; **********************************************************************
pausa:
    PUSH  R0                ; Guarda registos
    MOV   R0, 1000          ; R0 com um valor grANDe para fazer uma contagem decrescente, apenas para fazer uma pausa entre rotinas
ciclo_pausa:
    SUB   R0, 1             ; SUBtrai R0 
    JNZ   ciclo_pausa       ; Enquanto não for 0 continua a SUBtrair
    POP   R0                ; Recupera registos
    RET
; **********************************************************************
; Numeros aleatorio
;   Rotina que cria um valor aleatorio
; Entradas:
;  
; Saidas:
;   Memoria adr_Nr_rANDom
; **********************************************************************

rANDom:
	PUSH R0					; Guarda registos
	PUSH R1
	MOV R0, adr_Nr_rANDom	; Mete em R0 o endereco onde e guardado o valor aleatorio
	MOV R1, [R0]			; Guarda em R1 o valor
	ADD R1,1				; Adiciona 1 ao valor
	MOV [R0],R1				; Volta a guardar o valor
	POP R1					; Recupera registos
	POP R0
	RET						; Termina a rotina
	
; **********************************************************************
; Rodar tetramino
;   Rotina que roda o tetramino
; Entradas:
;  	Nenhuma
; Saidas:
;   Nenhuma
; **********************************************************************
rodar_tetra:
	PUSH R0					; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R8
	PUSH R9
	PUSH R10
	MOV R0,Flag_Tecla_Pressionada ; R0 com o endereco da flag do teclado
	MOV R1,[R0]				; Guarda valor da flag para testar
	AND R1,R1  				; Ve se ja corremos esta rotina atravez da flag
	JNZ fim_rot_tetra		; Se a flag estiver ativa acaba a rotacao
	MOV R1,1 				; Definir tecla como clicada
	MOV [R0],R1				; Ativa a flag
	MOV R9,0 				; Mete 0 em R9 para apagar o tetramino
	CALL desenhar_tetra		; Chama a rotina que vai apagar o tetramino
	MOV R0, adr_tetra_rot	; Mete em R0 o endereco da tabela de rotacoes a desenhar
	MOV R1,[R0]				; Mete em R1 o valor da tabela a desenhar
	MOV R2, valor_rot_Max   ; Mete em R2 o valor da ultima rotacao 
	CMP R1,R2				; Se for igual volta a rotacao inicial
	JZ redefinir_rot_tetra	
	ADD R1,1 				; Se nao for faz a rotacao seguinte
	JMP verificar_rodar
redefinir_rot_tetra:
	MOV R1,0 				;Faz reset a rotacao
verificar_rodar:
	CALL load_tetra_x_y_rot_teste ; Chama a rotina que inicializa as variaveis 
	MOV R3,adr_tetra_rot_teste ; Mete em R3 o endereco onde se guarda a tabela de rotacoes a testar
	MOV [R3],R1				; Mete em R3 a tabela a testar
	CALL verifica_desenhar	; Chama a rotina que verifica se se pode desenhar
	AND R10,R10				; Testa a flag
	JZ fim_rot_tetra		; Se nao poder desenha, desenha a anterior
set_rot_tetra:
	MOV [R0],R1				; Mete em R0 a proxima tabela a desenhar
fim_rot_tetra:
	MOV R9,1 				; MODO escrever peca
	CALL desenhar_tetra		; Chama a rotina que desenha o tetramino
	POP R10					; Devolve Registos
	POP R9
	POP R8
	POP R3
	POP R2
	POP R1
	POP R0
	RET						; Termina a rotina
	
; **********************************************************************
; Descer Tetramino
;   Rotina que desce o tetramino mais rapido
; Entradas:
;   Nenhuma
; Saidas:
;   Nenhuma
; **********************************************************************
descer_tetra:
	PUSH R0					; Guarda Registos
	PUSH R1
	PUSH R8
	PUSH R9
	PUSH R10
	MOV R9,0 				; Atualiza a flag, se 1 apaga o tetramino
	CALL desenhar_tetra     ; Chama a rotina que apaga o tetramino
	CALL load_tetra_x_y_rot_teste ; Chama a rotina que faz as inicializacoes das posicoes a testar
	MOV R0, adr_y			; Mete em R0 o endereco da linha atual
	MOV R9, adr_y_teste     ; Mete em R9 o endereco da linha a testar
	MOVB R1,[R0]			; Mete em R1 o valor da linha atual
	ADD R1,1				; Adiciona 1 a esse valor para testar a proxima linha
	MOVB [R9],R1			; Mete em R9 o valor para testar
	CALL verifica_desenhar	; Chama a rotina que verifica se pode desenhar
	AND R10,R10				; Testa a flag
	JZ criar_novo_tetra_flag ; Atualiza a flag se for necessario criar outra flag	
	MOVB [R0],R1			; Mete em R0 o valor para desenhar a nova peca
	MOV R9,1 				; Mete 1 em R9 para desenhar o tetramino
	JMP fim_descer			; Conclui
criar_novo_tetra_flag:
	MOV R0, teclado_Jumper_FLAG 
	MOV R1, [R0]
	SET R1, 4				
	MOV [R0],R1				; Grava alteracoes na flag
	CALL verificar_matou_monstro ; Chama a rotina que verifica se matou o monstro
	AND R10,R10				; Testa a flag
	JNZ se_matou_monstro  	; Se nao for 0 ve se o monstro morreu
	MOV R9,1 				; Mete 1 em R9 para desenhar o tetramino
	JMP fim_descer
se_matou_monstro:
	MOV R0,adr_x_monstro
	MOV R1,x_monstro_inicial ; Vai meter o x do monstro de novo na posicao inicial 
	MOV [R0],R1 			; Guarda em R0 a posicao onde desenhar o monstro
	MOV R9,0 				; Para apagar o tetramino
	CALL ecra_linhalateral  ; Chama a rotina para repor a linha que o monstro apagou
fim_descer:	
	CALL desenhar_tetra 	; Chama a rotina para desenhar o tetramino
	POP R10					; Devolve Registos
	POP R9
	POP R8
	POP R1
	POP R0
	RET						; Termina a rotina
	
; **********************************************************************
; Verificar se matou monstro
;   Permite saber se o monstro foi atingido ou nao
; Entradas:
; *  R8 - Linha a verificar
; *  R9 - Coluna a verificar
; Saidas:
;   R10, 2 se matou, 0 se n
; **********************************************************************
verificar_matou_monstro:
    PUSH R1 				 ; Guarda R1
    PUSH R2
    PUSH R4
    PUSH R8
	PUSH R9
	MOV R10,0 				; Caso n for alterado indica q o mosntro n foi morto
	MOV R1,const_y_monstro
	CMP R8, R1 				; Se o y for igual aos quadrados superiores do monstro 
	JZ verificar_x 			; Vai verificar se o x esta alinhado com o monstro
	ADD R1,1 				; Para ver se tocou no quadrado mais pequeno
	CMP R8, R1 				; Se o y for igual ao quadrado inferior do monstro 
	JZ verificar_x 			; Vai verificar se o x esta alinhado com o monstro
	JMP fim_verif_m_monstro
verificar_x:
	MOV R4,R9 				; Backup do y do tetramino
	MOV R1,adr_x_monstro
	MOVB R2,[R1] 			; Valor de x do monstro
	ADD R2,3 				; Valor do x que ja nao pertence ao monstro
	SUB R4,R2
	JNN fim_verif_m_monstro ; Se for superior ao x maximo entao nao matou
	SUB R2,4 				; Valor do x limite que ja nao pertence ao monstro 
	SUB R2,R9
	JNN fim_verif_m_monstro ; Se for inferior ao x minimo entao nao matou
	DI1						; Desliga as interrupcoes do monstro
	MOV R9,teclado_Jumper_FLAG
	MOV R1,[R9]
	CLR R1,1 				; Vai apagar a flag que mexe o montro
	MOV [R9],R1 			; Visto que ja nao ta ativo
	MOV R9,monstro_ativo 	; Endereco do valor que indica se um monstro se encontra ativo
	MOV R1,0
	MOV [R9],R1 			; Ira indicar q o monstro ja n se encontra ativo
	MOV R9,0 				; Ira apagar o monstro atual 
	CALL desenhar_monstro	; Chama a rotina que desenha o monstro 
	MOV R10,2  				; Ira somar 2 a pontuacao
	CALL soma_ecra_segmentos ; Chama a rotina que atualiza os displays hexadecimal
fim_verif_m_monstro:
	POP R9					; Devolve Registos
	POP R8
	POP R4
	POP R2
	POP R1
	RET						; Termina a rotina

; **********************************************************************
; Verificar Pixel
;   Rotina que faz uma pausa.
; Entradas:
; *  R1 - Valor a escrever (1 ou 0)
; *  R2 - Linha onde escrever
; *  R3 - Coluna onde escrever
; Saidas:
;   R10 - 1, se pode desenhar 0, se n pode
; **********************************************************************


verificar_pixel:
    PUSH R0 				; Guarda Registos
    PUSH R1 
    PUSH R2 
    PUSH R3 
    PUSH R4 
    PUSH R5
    PUSH R6 
    PUSH R7 
    PUSH R8 
	MOV R0, local_Ecra 		; Atualiza R0 com o endereco do ecra
	MOV R4, 4 				; Atualiza R4 com o numero de bytes de cada linha do ecra (linhas)
	MOV R5, 8 				; Atualiza R5 com o numero de bits por byte do ecra (colunas)
	MOV R6, 80H 			; (10000000) Mascara que permite escrever nas colunas de cada byte atraves de shifts
	MUL R4, R2 				; Transforma R2 numa linha do ecra
	ADD R0, R4 				; Acede a linha do ecra onde e suposto escrever
	MOV R7, R3 				; R7 com o valor da coluna para dividir pelo numero de colunas
	DIV R7, R5 				; Transforma R7 numa coluna da linha onde escrever
	ADD R0, R7 				; Acede a coluna onde escrever
	MOD R3, R5 				; R3 com o bit onde escrever (R3 sera um valor de 0-7 que sao o numero de colunas)
selecao_pixel0:
	AND R3, R3 				; Afectar as flags
	JZ verif_pintado 		; QuANDo for o ultimo bit a verificar salta para decidir se desenha ou apaga
	SHR R6, 1 				; Atualiza a mascara para o bit seguinte ate ao bit onde e suposto escrever
	SUB R3, 1 				; Atualiza a coluna (avanca para o proximo bit)
	JMP selecao_pixel0 		; Verifica os bits todos de R3
verif_pintado:
	MOVB R8, [R0] 			; MOVe para R8 o que esta escrito no byte do ecra
	AND R8, R6 				; Apaga apenas o bit escolhido
	JNZ nao_pode_pintar
	MOV R10, 1
	JMP fim_verificar_pixel
nao_pode_pintar:
	MOV R10, 0
fim_verificar_pixel:
    POP R8 					; Devolve Registos
    POP R7
    POP R6 
    POP R5 
    POP R4 
    POP R3 
    POP R2 
    POP R1 
    POP R0 
    RET 					; Termina rotina

	
; **********************************************************************
; Rotina Verifica Desenhar
;   Rotina que testa a ver se pode desenhar a peca
; Entradas:
;   Nenhuma
; Saidas:
;	R8 - Linha que nao pode ser desenhada
; 	R9 - Coluna que nao pode ser desenhada
;   R10 - 1 (Pode desenhar) ou 0 (Nao pode desenhar)
; **********************************************************************

verifica_desenhar:
    PUSH  R0 				; Guarda Registo
    PUSH  R1 
    PUSH  R2 
    PUSH  R3 
    PUSH  R4 
    PUSH  R5 
    PUSH  R6 
    PUSH  R7 
	MOV R0, adr_tetra_tipo	; R0 com o endereco da tabela da variante de tetramino a testar
	MOV R1,[R0]				; Guarda a tabela da variante
	MOV R0, adr_tetra_rot_teste ; R0 com o endereco onde e guardado a tabela da rotacao dessa variante
	MOV R2, [R0]			; Guarda a tabela da rotacao
	SHL R2,1 				; Multiplica por 2
	ADD R1,R2 				; Endereco da tabela a testar
	MOV R0,[R1]				; R0 com a tabela a ser testada
	;ir buscar x e y do tetramino 
	MOVB R4,[R0] 			; Linha
	ADD R0,1 				; adr coluna
	MOVB R5,[R0]			; Coluna
	MOV R8, adr_y_teste 	; Atualiza R0 com o valor correspondente a linha inicial onde desenhar o tetramino
	MOVB R2, [R8] 			; Mete em R2, o valor da linha onde comecar a desenhar
	MOV R8, adr_x_teste 	; Acede a tabela que contem as posicoes 
	MOVB R3, [R8] 			; Mete em R3, o valor da coluna onde comecar a desenhar
	MOV R8, 13 				; Valor limite nas colunas
	MOV R7, R3  
	ADD R7, R5 				; Adiciona a coluna a testar o numero de colunas da tabela
	CMP R8, R7 				; Se for igual nao desenha
	JZ nao_pode 			; Salta para nao desenhar
	MOV R8, 0FFH 			; Valor limite nas colunas
	CMP R8, R3 				; Se for igual nao desenha
	JZ nao_pode 			; Salta para nao desenhar
	MOV R8, 21H 			; Valor limite das linhas
	MOV R7,R2 
	ADD R7,R4 				; Adicionar o nr de linhas de modo a verificar o y max em q quer escrever
	CMP R8, R7 				; Se for igual nao desenha
	JZ nao_pode 			; Salta para nao desenhar
	MOV R7, R4 				; Duplica o valor das linhas em registo para criar 1 contador
	MUL R7, R5 				; Multiplica o valor das linhas pelas colunas, para criar 1 contador do numero de elementos da tabela
	ADD R3, R5 				; Permite repor corRETamente os contadores
	SUB R2, 1 				; Permite repor corRETamente os contadores
repor_contadores:
	MOV R6, R5 				; Duplica o valor das colunas em registo para fazer um contador
	SUB R3, R5 				; Repoe o valor da coluna onde escrever
	ADD R2, 1 				; Muda a linha onde escrever
loop_testar_tetra:
	ADD R0, 1 				; Acede ao proximo elemento da tabela
	MOVB R1, [R0] 			; R1 com o valor a escrever no ecra
	AND R1, R1 				; Afeta as flags
	JZ nao_testar 			; Se for um 0 nao testa
	CALL verificar_pixel 	; Chama a rotina que verifica 1 pixel da tabela de strings, e ve se esta desenhado ou nao
	AND R10, R10
	JZ nao_pode
nao_testar:
	SUB R7,1 				; Atualiza o contador
	JZ pode 				; Se ainda nao acabou corre outra vez
	ADD R3, 1 				; Muda a coluna onde escrever
	SUB R6, 1 				; Atualiza o contador de colunas
	JZ repor_contadores 	; Se for 0 repoe as colunas
	JMP loop_testar_tetra
nao_pode:
	MOV R10, 0
	MOV R8,R2 				; Linha que nao pode ser escrita
	MOV R9,R3 				; Coluna que nao pode ser escrita
	JMP fim_verifica_desenhar
pode:
	MOV R10, 1
	MOV R8,0 				; RETornara linha 
	MOV R9,0 				; Coluna sem significado
fim_verifica_desenhar:
    POP R7 					; Devolve Registos
    POP R6 
    POP R5 
    POP R4 
    POP R3 
    POP R2 
    POP R1 
    POP R0 
    RET 					; Termina rotina
	
; **********************************************************************
; Apagar linha e descer
;   Ve se existe uma linha toda vermelha
; Entradas:
;   Nenhuma
; Saidas:
;   Nenhuma
; **********************************************************************


apagar_linha:
	PUSH R0					; Guardar Registos
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R10
	MOV R0, local_Ecra 		; R0 com o endereco do ecra
	MOV R1, elem_Ecra 		; Numero total de bytes do ecra
	MOV R2, 255 			; Mascara para testar o primeiro byte
	MOV R3, 240 			; Mascara para testar metade do byte
	MOV R6, 2 				; Valor de bytes necessarios preenchidos para apagar a linha
	SUB R0, 1
loop_byte:
	ADD R0, 1
	MOV R5, 0 				; Contador para ver se sao 1 byte e meio preenchidos
	MOVB R4, [R0] 			; R4 com o conteudo de 1 byte do ecra
	SUB R1, 1 				; Atualiza o contador de bytes
	CMP R4, R2 				; Verifica se a linha esta toda preenchida
	JNZ loop_meiobyte 		; Se nao estiver toda preenchida passa o proximo byte
	ADD R5, 1 				; Adiciona 1 ao contador se o byte estiver preenchido
loop_meiobyte:
	ADD R0, 1 				; Acede ao byte seguinte do ecra
	MOVB R4, [R0] 			; R4 com o conteudo de 1 byte do ecra
	AND R4, R3
	SUB R1, 1 				; Atualiza o contador de bytes
	CMP R4, R3 				; Verifica se metade esta preenchida
	JNZ loop_ADD2 			; Se nao estiver preenchido passa de linha
	ADD R5, 1 				; Atualiza o contador de bytes preenchidos
	CMP R5, R6 				; Verifica se estao 2 bytes preenchidos
	JZ apagar 				; Se estiverem 2 bytes preenchidos salta para apagar a linha
loop_ADD2:
	ADD R0, 2 				; Passa a frente dos 2 bytes
	SUB R1, 2 				; Atualiza o contador de bytes
	JZ fim_apagar_linha 	; Se ja testou os bytes todos acaba
	JMP loop_byte 			; Volta a correr o loop ate ja ter testado todos os bytes
apagar:
	MOV R5, 08H 			; Valor a escrever para apagar meio byte
	MOVB [R0], R5 			; Apaga os bits de maior valor do 2 byte da linha
	SUB R0, 1 				; Acede ao byte anterior
	MOV R5, 00H 			; Valor a escrever para apagar o byte
	MOVB [R0], R5 			; Apaga o byte
	ADD R0, 1 				; Acede ao byte seguinte para voltar ao normal
	MOV R6,R0 				; Guardar localizacao ultimo byte em R2
	MOV R10,5 				; Vai adicionar 5 pontos no ecra de segmentos
	CALL soma_ecra_segmentos ; Chama a rotina para atualizar os pontos
	MOV R0, local_Ecra 		; R0 com o endereco do ecra
	MOV R1,R6
	SUB R1,4 				; A linha a cima do R0
	JMP baixar_linhas 		; Vai para o loop para continuar a testar as linhas
baixar_linhas:
	MOVB R2,[R1]
	MOVB [R6],R2 			; Vai por byte na linha a seguir
	SUB R6,1 				; Vai para o byte seguinte
	SUB R1,1 				; Vai para o byte seguinte
	MOVB R2,[R1]
	MOVB [R6],R2 			; Vai por byte na linha a seguir
	cmp R1,R0 				; Vai verificar se ja chegamos ao fim da linha
	JZ fim_apagar_linha
	SUB R6,3 				; Vai para a linha seguinte ignorANDo os bytes q nao queremos alterar
	SUB R1,3 
	JMP baixar_linhas
fim_apagar_linha:
	POP R10					; Devolver Registos
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET						; Terminar a rotina

; **********************************************************************
; MOVer Monstro
;   Rotina que move o monstro
; Entradas:
;   Nenhuma
; Saidas:
;   Nenhuma
; **********************************************************************
MOVer_monstro:
	PUSH R0					; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R9
	MOV R9,0 				; Valor para apagar o monstro atual
	CALL desenhar_monstro   ; Chama a rotina para apagar o monstro atual
	MOV R0, adr_x_monstro	; R0 com o endereco onde e guardado o valor das colunas do monstro
	MOVB R1,[R0]			; Mete em R1 o valor das colunas
	SUB R1,1				; Subtrai 1 para mexer para a esquerda
	MOVB [R0],R1			; Atualiza a posicao
	MOV R9,1				; Valor para desenhar o novo monstro
	CALL desenhar_monstro	; Chama a rotina para desenhar o novo monstro
	AND R1,R1 				; Afeta as flags
	JZ monstro_gameover
	JMP monstro_fim
monstro_gameover:
	MOV R0, teclado_Jumper_FLAG
	MOV R1, [R0]
	SET R1, 3 				; Mete no Jumper flag a flag que forca o game over
	MOV [R0],R1				; Grava as alteracoes na flag
monstro_fim:
	POP R9					; Devolve Registos
	POP R2
	POP R1
	POP R0
	RET						; Termina a rotina
	
; *********************************************************************************
; * MOVer Tetramino
; * Recebe da Memoria:
; * 	R0 - tabela
; * 	R9 - 1 Direita, 0 Esquerda
; * Saidas:
; * 	Nenhuma
; *********************************************************************************

MOVer_tetramino:
	PUSH R0					; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9
	MOV R0,Flag_Tecla_Pressionada 
	MOV R1,[R0]
	AND R1,R1  				; Testa a flag
	JNZ fim_MOVer_tetra		; Se a tecla estiver pressionada 
	MOV R1,1 				; Definir tecla como clicada
	MOV [R0],R1
	MOV R0, adr_tetra_tipo
	MOV R1,[R0]
	MOV R0, adr_tetra_rot
	MOV R2, [R0]
	SHL R2,1 				; multiplica por 2
	ADD R1,R2 				;endereco tabela final
	MOV R0,[R1]
	MOV R6, adr_x 			; Acede a tabela que contem as posicoes 
	MOVB R3, [R6] 			; Mete em R3, o valor da coluna onde comecar a desenhar
	AND R9,R9
	JZ esquerda
direita:
	ADD R3, 1 				; Adidicona 1 ao valor da coluna para MOVer para a direita
	JMP MOVer 				; Salta para concluir o MOVimento
esquerda:
	SUB R3, 1 				; SUBtrai 1 para MOVer para a esquerda
MOVer:
	MOV R9, 0 				; Mete em R9 1 valor para decidir de desenha ou apaga, se 1 escreve se 0 apaga
	CALL desenhar_tetra  	; Chama a rotina para apagar o tetramino
	CALL load_tetra_x_y_rot_teste ; Chama a rotina que faz as inicializacoes das posicoes a testar
	MOV R7,adr_x_teste		; Mete em R7 o endereco com a posicao a testar
	MOVB [R7],R3			; Atualiza a posicao
	CALL verifica_desenhar 	; Chama a rotina que verifica se pode desenhar, se R10 for 0 nao pode, se for 1 pode
	AND R10, R10 			; Testa a flag para saber se pode desenhar
	JZ fim_MOVer_tetra 		; Se nao poder desenhar acaba
	MOVB [R6],R3			; Atualiza o valor de x do monstro na memoria
fim_MOVer_tetra:
	MOV R9, 1 				; Mete em R9 1 valor para decidir de desenha ou apaga, se 1 escreve se 0 apaga
	CALL desenhar_tetra		; Chama a rotina para desenhar o tetramino
	POP R9					; Devolve Registos
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET						; Termina a rotina
	
; **********************************************************************
; Carrega a localizacao e rotacao atual do tetramino para as variaveis teste
;   Rotina que faz uma pausa.
; Entradas:
;  	Nenhuma
; Saidas:
;   Nenhuma
; **********************************************************************
load_tetra_x_y_rot_teste:
	PUSH R0					; Guarda Registos
	PUSH R1
	PUSH R2
	MOV R0, adr_x 			; Tabela de posicao atual das colunas
	MOV R1 ,adr_x_teste 	; Tabela de posicao teste das colunas
	MOVB R2, [R0] 
	MOVB [R1],R2 			; Mete o valor na tabela
	MOV R0, adr_y 			; Tabela de posicao atual das linhas
	MOV R1 ,adr_y_teste 	; Tabela de posicao teste das linhas
	MOVB R2, [R0] 
	MOVB [R1],R2 			; Mete o valor na tabela
	MOV R0, adr_tetra_rot 	; Tabela de rotacao atual
	MOV R1 ,adr_tetra_rot_teste ; Tabela de rotacao teste
	MOV R2, [R0] 
	MOV [R1],R2 			; Mete o valor na tabela
	POP R2					; Devolve Registos
	POP R1
	POP R0
	RET						; Termina a rotina
	
; **********************************************************************
; Interrupçao 0
;   Rotina da interrupcao que ativa algumas flags
; Entradas:
;   Nenhuma
; Saidas:
;   Nenhuma
; **********************************************************************
int0:
	PUSH R0					; Guarda registos
	PUSH R1
	MOV R0, teclado_Jumper_FLAG
	MOV R1, [R0]
	SET R1, 0
	MOV [R0],R1				; Grava alteracoes na flag
	POP R1					; Devolve Registos
	POP R0
	RFE						; Termina a interrupcao
	
; **********************************************************************
; Interrupçao 1
;   Rotina da interrupcao que ativa outras flags
; Entradas:
;   Nenhuma
; Saidas:
;   Nenhuma
; **********************************************************************
int1:
	PUSH R0					; Guarda registos
	PUSH R1
	MOV R0, teclado_Jumper_FLAG
	MOV R1, [R0]
	SET R1, 1
	MOV [R0],R1				; Grava alteracoes na flag
	POP R1					; Devolve Registos
	POP R0
	RFE						; Termina a interrupcao
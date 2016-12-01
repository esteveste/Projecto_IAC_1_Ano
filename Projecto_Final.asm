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
pontuacao 				EQU 1498H
adr_Nr_random 			EQU 1410H
adr_x					EQU 1420H  	 ; linha
adr_y					EQU 1430H    ; coluna
adr_x_teste				EQU 1428H  	 ; linha
adr_y_teste				EQU 1438H    ; coluna
adr_x_monstro			EQU 1448H
const_y_monstro 		EQU 24
adr_tetra_tipo			EQU 1450H  
adr_tetra_rot 			EQU 1460H 	 ; nr a adicionar ao tipo na tabela(melhorar coment)
adr_tetra_rot_teste		EQU 1468H    ; rotacao teste para testar
linha	                EQU 8H       ; Posição do bit correspondente à linha a testar
local_Segmentos	        EQU 0A000H 	 ; Endereco do display de 7 segmentos
out_Teclado	            EQU 0C000H   ; Endereço do porto de escrita do teclado
in_Teclado		        EQU 0E000H   ; Endereço do porto de leitura do teclado
elem_Ecra                EQU 128     ; Número de bytes do ecrã
elem_tabelas 	            EQU 128
tecla_pausa             EQU 0CH
tecla_about             EQU 0AH
tecla_gameover          EQU 0EH
tecla_jogar             EQU 0BH
tecla_rodar				EQU 01H
tecla_direita			EQU 06H
tecla_esquerda			EQU 04H
tecla_descer			EQU 05H
tecla_sair_estado		EQU 0FFH
local_Ecra	            EQU 8000H
x_monstro_inicial		EQU 21			

valor_max_decimal		EQU 9
linha_tetris_completa	EQU 3;nr de bytes q irao ser verificados
forcar_saida			EQU 1
OFF                     EQU 0        ; Valor da tecla nao premida
ON                      EQU 1        ; Valor da tecla premida
estado_Welcome          EQU 0
estado_Preparar_jogo    EQU 1
estado_Criar_Tetra      EQU 2
estado_Jogo             EQU 3
estado_Suspender        EQU 4
estado_Gameover         EQU 5
estado_About            EQU 6
mascara_0_1bits 		EQU 3H
mascara_2_3bits 		EQU 0CH
mascara_bit0			EQU 1H
mascara_bit1			EQU 2H
mascara_bit2			EQU 4H
mascara_bit3			EQU 8H
mascara_bit4			EQU 10H

mascara_bits_0_3		EQU 0FH
mascara_bits_4_7		EQU 0F0H
mascara_bits_6_7		EQU 0C0H
sequencia_tetraminoI 	EQU 00H
sequencia_tetraminoL 	EQU 01H
sequencia_tetraminoT 	EQU 02H
sequencia_tetraminoS 	EQU 03H
sequencia_monstro 		EQU 00H
valor_rot_Max			EQU 3
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

tetraminos:
WORD tetraminoI
WORD tetraminoL
WORD tetraminoT
WORD tetraminoS

tetraminoI:
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
	
tetraminoL:
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
		
tetraminoS:
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
			
tetraminoT:
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
	MOV R0, estado_programa ; Fazer comentarios diferentes ; Obter o estado actual
	MOVb R1, [R0]
	shl R1,1  				; Multiplicar por dois visto os endereços de 2 bytes em 2
	MOV   R0, tab_estado    ; Endereço base dos processos do jogo
    add   R1, R0            ; Agora R0 aponta para a rotina correspondente ao estado actual
    MOV   R0, [R1]          ; Obter o endereço da rotina a chamar
    call  R0                ; invocar o processo correspondente ao estado
    jmp   loop_estados      ; loop
	
; ***********************************************************************
; * Welcome
; * Código
; * Código
; * Código
; * 
; ***********************************************************************

Welcome:
	Push R0
	Push R1
	Push R2
	Push R3
	MOV  R1, 255           ; Corresponde ao valor FF no ecra
	call ecra_segmentos
	MOV R0, ecra_inicio
	call escreve_tabela_ecra
esperar_tecla:
	call teclado ;
	MOV R0, adr_Tecla_Valor
	MOVb R2,[R0]
	MOV R3, tecla_jogar
	CMP R2, R3 ; tecla b
	JNZ esperar_tecla
	MOV R0, estado_programa ; Fazer comentarios diferentes ; Obter o estado actual adrress
	MOV R1, estado_Preparar_jogo  ; 
	MOVb [R0], R1
	pop R3
	pop R2
	pop R1
	pop R0
	ret
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
	MOVB   R3, [R1]          ; Mete em registo o valor da memoria
    CMP   R3, R2 			; Verifica se a tecla pressionada e a tecla de suspender
    JNZ   ciclo_suspender 	; Caso nao seja a tecla de suspender, repete ate receber a tecla de suspender para tirar do modo de pausa
    MOV   R2, estado_Jogo		; Atualiza R2 com o novo estado (estado jogar)
    MOV   R1, estado_programa ; Mete em R1, o endereco do estado_programa
    MOVB  [R1], R2 			; Atualiza o estado_programa com o novo estado
    CALL inverte_ecra       ; Chama a rotina que inverte o ecra para criar um efeito visual
	EI


	POP R3 
    POP R2 					; Retorna registos
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
	CALL teclado 		; Chama a rotina que devolve o valor de uma tecla premida
	MOV R2, tecla_gameover ; Atualiza R2 com o valor da tecla terminar
	MOV R1, adr_Tecla_Valor ; Vai buscar o valor da tecla carregada a memoria
	MOVb R3, [R1]            ; R3 com o valor da tecla na memoria
	CMP R3, R2 				; Verifica se a tecla e' a tecla de terminar
	JNZ verif_jogar 		; Se nao for verifica se e a de jogar
	MOV R2, estado_Gameover 			; Atualiza R2 com o valor do novo estado (estado terminar)
	JMP terminar 			; Termina caso seja a tecla terminar
verif_jogar:
	MOV R2, tecla_jogar 	; Atualiza R2 com o valor da tecla jogar
	CMP R3, R2 				; Verifica se a tecla e' a tecla de jogar
	JNZ about_loop 			; Se nao for corre o loop outra vez
	MOV R2, estado_Preparar_jogo 			; Atualiza R2 com o valor do novo estado (estado jogar)
terminar:
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOVb [R1], R2 			; Atualiza o estado programa com o valor do estado atual (estado terminar)
sair_about:
	POP R3
	POP R2 					; Retorna registos
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

	MOV R2, Flag_Pausa_Display
	MOV R1, 1				;vamos ativar a flag da pausa no ecra para dar um efeito de transiçao
	MOV [R2],R1
	MOV R0, ecra_fim 		; Guarda em R0 a tabela de strings ecra_fim
	CALL escreve_tabela_ecra ; Chama a rotina para escrever no ecra a tabela de strings ecra_fim
	MOV R1,0
	MOV [R2],R1 ;Voltamos a desativar a Flag da pausa para n ser chamada nas outras rotinas
gameover_loop:
	CALL teclado 			; Chama a rotina que devolve o valor de uma tecla
	MOV R2, tecla_jogar 	; Atualiza R2 com o valor da tecla jogar
	MOV R1, adr_Tecla_Valor ; Vai buscar a memoria a tecla carregada do teclado
	MOVb R3, [R1]            ; R3 com o valor da tecla em memoria
	CMP R3, R2              ; Verifica se e a tecla de jogar
	JNZ verif_about 		; Se nao for verifica se e' a de about
	MOV R2, estado_Preparar_jogo 		; Atualiza R2 com o estado novo (estado preparar jogo)
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOVb [R1], R2 			; Atualiza o estado programa com o valor do estado atual (estado preparar jogo)
	JMP sair_gameover
verif_about:
	MOV R2, tecla_about 	; Atualiza R2 com o valor da tecla about
	CMP R3, R2 				; Verifica se e' a tecla about
	JNZ gameover_loop 		; Volta a correr o loop gameover
	MOV R2, estado_About 	; Atualiza R2 com o estado novo (estado about)
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOVb [R1], R2 			; Atualiza o estado programa com o valor do estado atual (estado about)
sair_gameover:
	
	POP R2 					; Retorna registos
	POP R1 
	POP R0 
	RET 					; Termina a rotina
; *********************************************************************************
; * Rotina que cria prepara o jogo
; *********************************************************************************

Preparar_jogo:
	PUSH R0					; Guarda registos
	PUSH R1
	EI
	CALL limpar
	CALL ecra_linhalateral 	; Chama a rotina para desenhar o limite lateral
	MOV R1,0 				; valor 00 para mostrar no ecra de segmentos
	call ecra_segmentos
	mov R0,pontuacao ;carraga o endereco da pontuacao
	movb [R0],R1 ;vamos redefinir a pontucao do jogo a 0
	
	mov r0,monstro_ativo ;tab memoria q indica se ja existe um monstro ativo
	mov [r0],r1 ;volta a definir q nao existe nenhum monstro ativo
	
	MOV R0, estado_programa ; MOVe o endereco do estado_programa para R0
	MOV R1, estado_Criar_Tetra 	; Atualiza R1 com o valor do estado jogar
	MOVB [R0], R1 			; Atualiza o valor do estado_programa para o estado atual (estado jogar)
	;MOV R0, l_centro_tetramino ; Atualiza R0 com a word que contem a linha inicial para desenhar o tetramino
	;MOV R2, [R0] ; Atualiza R1 com o valor da linha
	;MOV R0, c_centro_tetramino ; Atualiza R0 com a word que contem a coluna inicial para desenhar o tetramino
	;MOV R3, [R0] ; Atualiza R2 com o valor da coluna
	;CALL desenha_tetramino ; Chama a rotina que vai desenhar o tetramino
	;CALL inicializar_pontos ; Chama a rotina que vai inicializar a contagem dos pontos
	;EI ; Liga as interrupcoes para permitir o MOVimento dos tetraminos
	POP R1					; Retorna registos
	POP R0
	RET						; Termina a rotina
	
	

; *********************************************************************************
; * Rotina que permite a criacao das pecas quando necessario
; *********************************************************************************
Criar_tetra:
	AND R0,R0 ; pus isto aki disto um problema do PEPE q devez em quando n faz o push 0
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R8
	Push R9
	PUSH R10
	;MOV R1, adr_x
	;MOV R0,0
	;MOV [R1], R0 			; mete a posicao padrao para ser escrita
	;MOV R0,0
	call apagar_linha ;vai ver se existe alguma linha completa 
	MOV R1,1
	MOV [R0],R1 ;vai indicar que vamos criar um tetramino para jogarmos
	MOV R1, adr_Nr_random
	MOV R0, [R1] 			; Nr aleatorio
	MOV R1, mascara_0_1bits
	and R0, R1 				; isola os ultimos 2 bits
select_tetra:
	MOV R1,0 				; valor a saltar na tab tetraminos
	CMP R0, sequencia_tetraminoI
	JZ write_tab_tetra
	add R1,1
	CMP R0, sequencia_tetraminoL
	JZ write_tab_tetra
	add R1,1
	CMP R0, sequencia_tetraminoT
	JZ write_tab_tetra
	add R1,1
	CMP R0, sequencia_tetraminoS
	JZ write_tab_tetra
	
write_tab_tetra:
	MOV R8, adr_x ; Atualiza R0 com o valor correspondente a linha inicial onde desenhar o tetramino
	MOV R3, 6
	MOVB [R8],R3 ; Mete em R2, o valor da linha onde comecar a desenhar
	MOV R8, adr_y ; Acede a tabela que contem as posicoes 
	MOV R3, 0
	MOVB [R8], R3 ; Mete em R3, o valor da coluna onde comecar a desenhar	
	
	MOV R2, tetraminos 		; endereco para selecionar tetra
	shl R1,1 ;multiplica por 2 
	add R2, R1				; mete o pointer no tetra
	MOV R1, [R2] 			; mete na variavel endereco tabela rotacao de tetra
	MOV R0, adr_tetra_tipo 
	MOV [R0], R1 			; escreve a tabela rotacao de tetra em adr_tetra_tipo
	MOV R0, adr_tetra_rot 	; para registar na memoria o valor inicial da rotacao
	MOV R1, 0H
	MOV [R0], R1; rotacao inicial de tetra
	call load_tetra_x_y_rot_teste
	call verifica_desenhar
	AND R10,R10
	JZ criar_tetra_gameover
	MOV R9,1 ;Modo Escreve
	call desenhar_tetra
	EI0
random_monstro:
	MOV R0,monstro_ativo ;tab memoria q indica se ja existe um monstro ativo
	MOV r1,[r0]
	and r1,r1 ;se ja existe um monstro ativo no jogo
	jnz fim_Criar_Tetra ;nao cria novo monstro
	MOV R1, adr_Nr_random
	MOV R0, [R1] 			; Nr aleatorio
	MOV R1, mascara_2_3bits
	and R0, R1
	CMP R0, sequencia_monstro
	jz criar_monstro
	jmp fim_Criar_Tetra
criar_monstro:
	
	MOV R0,monstro_ativo ;tab memoria q indica se ja existe um monstro ativo
	MOV R1,1
	MOV [r0],R1 ;indica q ja existe um monstro ativo
	
	MOV R0, adr_x_monstro
	MOV R1, x_monstro_inicial
	MOVB [R0],R1
	MOV R9,1
	call desenhar_monstro
	EI1
	jmp fim_Criar_Tetra
	
criar_tetra_gameover:
	MOV R0, teclado_Jumper_FLAG
	MOV R1, [R0]
	SET R1, 3 ;Mete no Jumper flag a flag que forca o game over
	;mete a mesma o modo jogo,pois sera no modo jogo q o teclado_Jumper_FLAG sera processado
	MOV [R0],R1
	
fim_Criar_Tetra:
	MOV R0, estado_programa ; Meter em R0 o endereco do estado_programa
	MOV R1, estado_Jogo ; Meter em R1 o valor do estado suspender 
	MOVB [R0], R1 ; Mover para o estado_programa o estado atual
	POP R10
	POP R9
	POP	R8
	POP R3
	POP R2
	POP R1
	POP R0
	RET
; *********************************************************************************
; * Rotina que permite jogar
; *********************************************************************************
Jogo:
	PUSH R0
	PUSH R1
	PUSH R2 
	PUSH R3
	PUSH R8
	PUSH R9
esperar_tecla_jogo:
	CALL teclado ; Chama a rotina do teclado e devolve uma tecla em memoria
	MOV R0, adr_Tecla_Valor ; Vai buscar para R0 o endereco onde esta a tecla carregada
	MOVB R2,[R0] ; R2 com o valor da tecla carregada da memoria
	MOV R3, tecla_pausa ; Mete em R3 o valor da tecla de pausa
	CMP R2, R3 ; Verifica se e a tecla de pausa
	JNZ verif_tecla_gameover ; Se nao for a tecla de pausa verifica se e a de terminar
	MOV R0, estado_programa ; Meter em R0 o endereco do estado_programa
	MOV R1, estado_Suspender ; Meter em R1 o valor do estado suspender 
	MOVB [R0], R1 ; Mover para o estado_programa o estado atual
	JMP jogo_fim ; Sai do modo jogo
verif_tecla_gameover:
	MOV R3, tecla_gameover ; R3 com o valor da tecla de terminar
	CMP R2, R3 ; Verifica se e a tecla de terminar
	JNZ verif_tecla_suspender ; Se nao for espera por uma nova tecla	
	MOV R0, estado_programa ; Meter em R0 o endereco do estado_programa
	MOV R1, estado_Gameover  ; Meter em R1 o valor do estado gameover
	MOVB [R0], R1 ; Mover para o estado_programa o estado atual
	JMP jogo_fim ; Sai do modo jogo
verif_tecla_suspender:
	MOV R3, tecla_pausa ; R3 com o valor da tecla de pausa
	CMP R2, R3 ; Verifica se e a tecla de suspender
	JNZ verif_tecla_rodar ; Se nao for verifica se e a tecla de rodar
	MOV R0, estado_programa ; Meter em R0 o endereco do estado_programa
	MOV R1, estado_Suspender  ; Meter em R1 o valor do estado suspender
	MOVB [R0], R1 ; Mover para o estado_programa o estado atual
	JMP jogo_fim ; Sai do modo jogo
verif_tecla_rodar:
	MOV R3, tecla_rodar ; R3 com o valor da tecla de rodar
	CMP R2, R3 ; Verifica se e a tecla de rodar
	JNZ verif_tecla_direita ; Se nao for verifica se e a de mover direita
	CALL rodar_tetra ; Chama a rotina que roda o tetramino
	JMP esperar_tecla_jogo ; Volta a esperar por uma tecla
verif_tecla_direita:
	MOV R3, tecla_direita ; R3 com o valor da tecla para mover para a direita
	CMP R2, R3 ; Verifica se e a tecla de mover para a direita
	JNZ verif_tecla_esquerda ; Se nao for verifica se e a de mover para a esquerda
	MOV R9, 1 ; R9 vai ser recebido pela rotina de mover o tetramino (1 - direita)
	CALL mover_tetramino ; Chama a rotina que move o tetramino
	JMP esperar_tecla_jogo ; Volta a esperar por uma tecla
verif_tecla_esquerda:
	MOV R3, tecla_esquerda ; R3 com o valor da tecla para mover a esquerda
	CMP R2, R3 ; Verifica se e a tecla de mover para a esquerda
	JNZ verif_tecla_descer ; Se nao for verifica se e a tecla de descer a peca
	MOV R9, 0 ; R9 vai ser recebido pela rotina de mover o tetramino (0 - esquerda)
	CALL mover_tetramino ; Chama a rotina que move o tetramino
	JMP esperar_tecla_jogo ; Volta a esperar por uma tecla
verif_tecla_descer:
	MOV R3, tecla_descer ; R3 com o valor da tecla para descer
	CMP R2, R3 ; Verifica se e a tecla de mover para a esquerda
	JNZ verif_tecla_sair_estado ; Ira forcar a saida do modo Jogo
	CALL descer_tetra ; Chama a rotina para descer o tetramino
verif_tecla_sair_estado:
	MOV R3, tecla_sair_estado
	CMP R2, R3 ; Verifica se e a tecla de forcar a saida do modo jogo
	JNZ esperar_tecla_jogo ; Caso n for nenhuma das teclas continuar a espera por tecla
	JMP jogo_fim ;Sai do modo jogo
jogo_fim:
	Pop R9
	POP R8
	POP R3 
	POP R2
	POP R1
	POP R0
	RET
	

; **********************************************************************
; * Desenha Monstro
; *  usa parte da funcao desenha_tetramino
; *Entradas:
; * 
; *  R9 - 1 (escreve) ou 0 (apaga)
; * Recebe da Memoria:
; ;; ;;Tabela de strings do tetramino a desenhar
; *  R2 - Linha da posicao onde desenhar
; *  R3 - Coluna da posicao onde desenhar
; *Saídas:
; *  R2 e R3 nao alterados
; **********************************************************************
desenhar_monstro:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	;MOV R0, tabelatetramino ; R0 com a tabela de strings correspondente a variante de tetramino a desenhar
	;MOVB R4, [R0] ; R4 com o valor correspondente ao numero de linhas da tabela
	;ADD R0, 1 ; Acede ao proximo elemento da tabela de strings
	;MOVB R5, [R0] ; R5 com o valor correspondente ao numero de colunas da tabela
	MOV R0, monstro
	;ir buscar x e y do tetramino 
	MOVB R4,[R0] ;linha
	add R0,1 ;adr coluna
	MOVb R5,[R0];coluna
	MOV R2, const_y_monstro ;usa a constante da linha do monstro
	MOV R8, adr_x_monstro ; Acede a tabela que contem as posicoes 
	MOVB R3, [R8] ; Mete em R3, o valor da coluna onde comecar a desenhar	
	MOV R7, R4 ; Duplica o valor das linhas em registo para criar 1 contador
	MUL R7, R5 ; Multiplica o valor das linhas pelas colunas, para criar 1 contador do numero de elementos da tabela
	ADD R3, R5 ; Permite repor corretamente os contadores
	SUB R2, 1 ; Permite repor corretamente os contadores
	CALL completar_desenho ; Chama a rotina que conclui o desenho
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
	
;;Recebe nada	(memoria, adr_tetra_tipo adr_tetra_rot)
; **********************************************************************
; * Desenha Tetramino
; *  Desenha tetraminos ou monstros nas posicoes devidas
; *Entradas:
; * 
; *  R9 - 1 (escreve) ou 0 (apaga)
; * Recebe da Memoria:
; ;; ;;Tabela de strings do tetramino a desenhar
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
	;MOV R0, tabelatetramino ; R0 com a tabela de strings correspondente a variante de tetramino a desenhar
	;MOVB R4, [R0] ; R4 com o valor correspondente ao numero de linhas da tabela
	;ADD R0, 1 ; Acede ao proximo elemento da tabela de strings
	;MOVB R5, [R0] ; R5 com o valor correspondente ao numero de colunas da tabela
	MOV R0, adr_tetra_tipo
	MOV R1,[R0]
	MOV R0, adr_tetra_rot
	MOV R2, [R0]
	shl R2,1 ; multiplica por 2
	add R1,R2 ;endereco tabela final
	MOV R0,[R1]
	;ir buscar x e y do tetramino 
	MOVB R4,[R0] ;linha
	add R0,1 ;adr coluna
	MOVb R5,[R0];coluna
	MOV R8, adr_y ; Atualiza R0 com o valor correspondente a linha inicial onde desenhar o tetramino
	MOVB R2, [R8] ; Mete em R2, o valor da linha onde comecar a desenhar
	MOV R8, adr_x ; Acede a tabela que contem as posicoes 
	MOVB R3, [R8] ; Mete em R3, o valor da coluna onde comecar a desenhar	
	MOV R7, R4 ; Duplica o valor das linhas em registo para criar 1 contador
	MUL R7, R5 ; Multiplica o valor das linhas pelas colunas, para criar 1 contador do numero de elementos da tabela
	ADD R3, R5 ; Permite repor corretamente os contadores
	SUB R2, 1 ; Permite repor corretamente os contadores
	CALL completar_desenho ; Chama a rotina que conclui o desenho
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
; * Completar Desenho
; *  Com as inicializacoes feitas nas rotinas desenhar monstro e tetramino, termina o desenho
; *Entradas:
; *  R9 - 1 (escreve) ou 0 (apaga)
; * Recebe da Memoria:
; * 	  Tabela de strings do tetramino a desenhar
; *  R2 - Linha da posicao onde desenhar
; *  R3 - Coluna da posicao onde desenhar
; *Saídas:
; *  R2 e R3 nao alterados
; **********************************************************************
completar_desenho:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R9
repor_colunas:
	MOV R6, R5 ; Duplica o valor das colunas em registo para fazer um contador
	SUB R3, R5 ; Repoe o valor da coluna onde escrever
	ADD R2, 1 ; Muda a linha onde escrever
	
loop_desenhar_tetra:
	ADD R0, 1 ; Acede ao proximo elemento da tabela
	MOVB R1, [R0] ; R1 com o valor a escrever no ecra
	AND R1, R1 ; Afeta as flags
	JZ nao_desenhar0 ; Se for 0 nao desenha
	MOV R1,R9
	CALL desenhar_pixel ; Chama a rotina que desenha 1 pixel da tabela de strings
nao_desenhar0:
	Sub R7,1
	JZ fim_desenhar_tetra ; Se ainda nao acabou corre outra vez
	ADD R3, 1 ; Muda a coluna onde escrever
	SUB R6, 1 ; Atualiza o contador de colunas
	JZ repor_colunas ; Se for 0 repoe as colunas
	JMP loop_desenhar_tetra
fim_desenhar_tetra:
	POP R9
	POP R7
	POP R6
	POP R5
	POP R3
	POP R2
	POP R1
	POP R0
	RET

	
	
; *Entradas:
; *  R1 - Valor a escrever (1 ou 0)
; *  R2 - Linha onde escrever
; *  R3 - Coluna onde escrever
	
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
	push r1					; Guarda registos
	push r2
	push r3
	push r4
	push R5
	push R6
	push R8
	push R10
	call definir_Linha
	pop R10
	pop R8
	pop r6					; Retorna registos
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	ret
	
;definir_
definir_Linha:             	; Redifine a linha quando o shr chegar a 0
	call random 			;Criar numeros aleatorios
	MOV  R1, linha         	; Valor maximo das linhas  
	MOV R2,teclado_Jumper_FLAG
	MOV R3,[R2]
	AND R3,R3   ;Se existe valor no Jumper_Flag
	JNZ call_Jumper_Flag ;vai chamar a rotina que vai lidar com as flags
	jmp scan_Teclado
	
call_Jumper_Flag:
	call Jumper_FLAG
	CMP R10,forcar_saida ;Ver se a saida do Jumper_FLAG e forcar a saida para o loop de estado
	jz forcar_saida_estado
	jmp definir_Linha
	
forcar_saida_estado:
	MOV R6, tecla_sair_estado ;carrega uma tecla inacessivel no teclado que ira fazer ir para o loop estado
	jmp gravar_Mem_Teclado ;e vai gravar na memoria como se tivesse sido pressionada
scan_Teclado:              	; Rotina que lê o teclado 

	MOV  R2, out_Teclado   	; R2 fica com o valor 0C000H(porto de escrita)
	MOVb [R2], R1      	   	; Escreve no periférico de saída
	MOV  R2, in_Teclado    	; R2 fica com o valor 0E000H(porto de leitura)
    MOVb R3, [R2]      	   	; Lê do periférico de entrada
	
	MOV R8, 0FH
	
    and  R3, R8      	   	; Isola apenas os bits do teclado com a mascara_bits_0_3
    jz   mudar_Linha       	; Se nenhuma foi tecla premida, muda de linha
    jmp  tecla_Pressionada 	; Caso tecla premida, começa a função
	
mudar_Linha:
	shr  R1,1			   	; Vai alterando a linha a varrer
	jz   alterar_Flag_T_Press      ; @@@@@@MALLL DESCRICAO Verificar estado da tecla apos varrimento das 4 linhas
	jmp  scan_Teclado      	; Caso ainda não acabou o varrimento de todas as linhas, fazer scan linha seguite

	
alterar_Flag_T_Press:
	MOV R3, Flag_Tecla_Pressionada
	MOV R2,0 ;Definir tecla nao clicada
	MOV [R3],R2
	jmp definir_Linha


tecla_Pressionada:         	; Verifica qual a tecla premida
	MOV r5, 0 			   	; Redifinir contadores
	MOV r6, 0 
	call linha_Count
	call coluna_Count
	call transform_Hex
	call gravar_Mem_Teclado
	ret					   	; Termina a rotina
linha_Count:               	; Ciclo que conta o nº de linhas
	add  R5,1			   
	shr  R1,1			   	; Conta o nº de shift ate dar 0
	jnz  linha_Count
	sub  R5,1 			   	; Fazer o contador comecar em 0
	ret		               	; Vai para coluna_Count

coluna_Count:              	; Ciclo que conta o nº de colunas
	add  R6,1 			   
	shr  R3,1			   	; Conta o nº de shift ate dar 0
	jnz  coluna_Count
	sub  R6,1 			   	; Fazer o contador comecar em 0
	ret

transform_Hex:             	; Vai transformar o numero de colunas e linhas no valor do teclado
	shl  R5,2 			   	; Multiplica por 4,valor a somar a linha
	add  R6,R5			   	; Valor da tecla em R6
	ret

gravar_Mem_Teclado:
    MOV  R4, adr_Tecla_Valor        
	MOVb [R4], R6      	   	; Guarda tecla premida na memória de endereço 100H
	ret

;###########################################################	
; **********************************************************************
; * escreve o valor no ecra segmentos
; *  Desenha ou apaga um pixel no ecrã com base nas linhas e colunas
; *Entradas:
; *  R10 - Valor a somar(nao e capaz de somar valores superiores a 5)

; *Saídas:
; *  Nenhuma
; **********************************************************************
soma_ecra_segmentos:
	push R0				   	; Guarda registos
	push R1
	push R2
	push R3
	push R4
	push R10
	mov R1,0 ;contador caso aconteca descrepancia na base das unidades 
	MOV  R0, pontuacao   ; vai buscar o endereco da pontuacao 
	movb r2,[r0] ;le a pontuacao
	add r2,r10 ;adiciona a r2 o valor que queriamos somar
	mov r3,mascara_bits_0_3 
	and r3, r2   ;isola o ecra das unidades
	mov r4,valor_max_decimal
	sub r3,r4 ;sub o valor max da base decimal(10)
	jnn ultrapassa_unidades ;caso o valor das unidades ultrapasse a base decimal
	jmp gravar_pontuacao
ultrapassa_unidades:

	add R1,1 ;conta 1 unidade que saio da base decimal
	sub r3,1 ; vai subtrair ate as unidades a mais chegarem a 0
	jnz ultrapassa_unidades
	sub r1,1 ;subtrai valor a mais devido a contagem
	mov r3,mascara_bits_4_7 
	and r2,r3 ;isola o ecra das dezenas
	mov r4,10H
	add r2, r4 ; adiciona 1 dezena
	add r2, r1 ;adiciona as unidades certas
	
	mov r3, mascara_bits_6_7
	and r3,r2 ;isola apenas os numeros hexadecimais
	jnz gameover_pontuacao ;representa se a pontuacao ultrapassou os 99 pontos
	jmp gravar_pontuacao

gravar_pontuacao:
	MOVb [R0],R2           ; grava nova pontuacao na memoria
	mov R0,local_Segmentos ;vai buscar o enderesso do ecra de segmentos
	MOVb [R0],R2           ; Escrever no display o valor da tecla	
	jmp fim_soma_ecra_segmentos
	
gameover_pontuacao:
	MOV R0, teclado_Jumper_FLAG
	MOV R1, [R0]
	SET R1, 3 ;Mete no Jumper flag a flag que forca o game over
	
	MOV [R0],R1


fim_soma_ecra_segmentos:
	
	pop R10
	pop R4
	pop R3
	pop  R2				   ; Retorna registos
	pop  R1
	pop  R0
	ret

; **********************************************************************
; * escreve o valor no ecra segmentos
; *  Desenha ou apaga um pixel no ecrã com base nas linhas e colunas
; *Entradas:
; *  R1 - Valor a escrever 

; *Saídas:
; *  Nenhuma
; **********************************************************************
ecra_segmentos:             ; Mostra que tecla foi premida, no ecra de segmentos
	push R0				   	; Guarda registos
	push R1
	push R2
	MOV  R0, local_Segmentos   ; Define endereço de escrita display (0A000H)
	MOVb [R0],R1           ; Escrever no display o valor da tecla
	pop  R2				   ; Retorna registos
	pop  R1
	pop  R0
	ret

; **********************************************************************
; * Jumspad
; *  Desenha ou apaga um pixel no ecrã com base nas linhas e colunas
; *Entradas:
; *  
; *  R2 - endereco da memoria para teclado_Jumper_FLAG
; *  R3 - valor do teclado_Jumper_FLAG
; *Saídas:
; *  R10-1-caso forcar saida para loop de estados
; **********************************************************************
Jumper_FLAG:
	push R2
	PUSH R3
	PUSH R4
	MOV R10,0 ;Carrega a saida da routina como 0 

	MOV R4, mascara_bit4 ;vai buscar o bit 4, e vem primeiro pk tem prioridade
	AND R4,R3
	JNZ force_Criar_Tetra; que representa a flag de forcar modo Criar Tetra

	MOV R4,mascara_bit0 ;vai buscar o bit 0 do teclado_Jumper_FLAG
	AND R4,R3
	JNZ call_descer_tetra ; que representa a flag do descer_tetra
	MOV R4, mascara_bit1 ;vai buscar o bit 1
	AND R4,R3
	JNZ call_mover_monstro; que representa a flag do mover monstro
	MOV R4, mascara_bit2 ;vai buscar o bit 2
	AND R4,R3
	JNZ clear_flag_tecla; que representa a flag de que uma tecla esta presisonada
	MOV R4, mascara_bit3 ;vai buscar o bit 3
	AND R4,R3
	JNZ force_gameover; que representa a flag de forcar modo gameover

	jmp fim_JUMPER
	
call_mover_monstro:
	CLR R3,1
	mov [R2],R3 		;Gravar alteracoes na Jumper_FLAG
	call mover_monstro
	jmp fim_JUMPER
call_descer_tetra:
	CLR R3,0
	mov [R2],R3 		;Gravar alteracoes na Jumper_FLAG
	call descer_tetra
	jmp fim_JUMPER
clear_flag_tecla:
	CLR R3,2
	mov [R2],R3 		;Gravar alteracoes na Jumper_FLAG
	jmp fim_JUMPER

force_gameover:
	DI ;desativa interrupcoes visto q acaba o jogo
	MOV R3,0 ;Apagas as flags para nao ocorrerem apos o gameover
	mov [R2],R3 		;Gravar alteracoes na Jumper_FLAG
	MOV R2, estado_Gameover 	; Atualiza R2 com o estado novo (estado Gameover)
	MOV R4, estado_programa ; Atualiza R4 com o endereco do estado programa
	MOVb [R4], R2 			; Atualiza o estado programa com o valor do estado atual (estado Gameover)
	MOV R10,forcar_saida ;Carrega a saida da rotina de modo a forcar saida do estado atual para o loop de estado
	jmp fim_JUMPER
	
force_Criar_Tetra:
	CLR R3,4
	mov [R2],R3 		;Gravar alteracoes na Jumper_FLAG
	MOV R2, estado_Criar_Tetra 	; Atualiza R2 com o estado novo (estado criar tetramino)
	MOV R4, estado_programa ; Atualiza R4 com o endereco do estado programa
	MOVb [R4], R2 			; Atualiza o estado programa com o valor do estado atual (estado criar tetramino)
	MOV R10,forcar_saida ;Carrega a saida da rotina de modo a forcar saida do estado atual para o loop de estado
	jmp fim_JUMPER
	

	
	
fim_JUMPER:
	
	POP R4
	POP R3
	POP R2
	ret
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
	MOVb [R0], R2 			; Limpa 1 byte do ecra
	ADD R0, 1 				; Acede ao byte seguinte do ecra
	SUB R1, 1 				; Atualiza o contador de bytes
	JNZ loop_limpar 		; Corre o loop outra vez ate todos os bytes estarem limpos
	POP R2 					; Retorna registos
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
	MOV R4, 4 ; Atualiza R4 com o numero de bytes de cada linha do ecra (linhas)
	MOV R5, 8 ; Atualiza R5 com o numero de bits por byte do ecra (colunas)
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
	MOVB R8, [R0] ; MOVe para R8 o que esta escrito no byte do ecra
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
	
; **********************************************************************
; Escreve Ecrã
;   Rotina que desenha uma tabela de strings no ecrã
; Entradas
;   R0 - Tabela de strings a escrever
;   
; Saídas
;   Nenhuma
; *********************************************************************
escreve_tabela_ecra:     
    PUSH  R0                ; Guarda registos
    PUSH  R1
    PUSH  R2
    PUSH  R3
	push R4
    MOV   R3, local_Ecra    ; Endereço do ecrã
    ;ADD   R3, R1            ; Actualização do endereço onde começar a escrever
	MOV R1,Flag_Pausa_Display ;;Vai ver se o ecra q vamos apresentar vai usar a pausa
	MOV R4,[R1]
    MOV   R2, elem_tabelas       ; Número de elementos da tabela de strings
	
verificar_pausa_ecra:
	AND R4,R4
	JNZ chamar_pausa ;vai chamar a pausa caso Flag_Pausa_Display for 1
	jmp ciclo_ecra

chamar_pausa:
	call pausa
	jmp ciclo_ecra
	
ciclo_ecra:  
    MOVB  R1, [R0]          ; Elemento actual da tabela de strings
    MOVB  [R3], R1          ; Escreve o elemento da tabela de strings no ecrã
    ADD   R0, 1             ; Acede ao índice seguinte da tabela de strings
    ADD   R3, 1             ; Avança para o byte seguinte do ecrã
    SUB   R2, 1             ; Actualiza o contador
    JNZ   verificar_pausa_ecra        ; Volta ao ciclo para escrever o que falta
	POP R4
    POP   R3                ; Recupera registos
    POP   R2
    POP   R1
    POP   R0
    RET   					; Termina a rotina
	
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
	
; **********************************************************************
; Inverte Ecrã
;   Inverte o ecrã, diferenciando o estado de suspensão do de jogo
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
    MOV   R1, elem_Ecra     	; Contador de bytes do ecrã
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
    MOV   R0, 1000          ; R0 com um valor grande para fazer uma contagem decrescente, apenas para fazer uma pausa entre rotinas
ciclo_pausa:
    SUB   R0, 1             ; Subtrai R0 
    JNZ   ciclo_pausa       ; Enquanto não for 0 continua a subtrair
    POP   R0                ; Recupera registos
    RET
; **********************************************************************
; Numeros aleatorio
;   Rotina que faz uma pausa.
; Entradas:
;  
; Saidas:
;   Memoria adr_Nr_random
; **********************************************************************

random:
	push R0					; Guarda registos
	push R1
	MOV R0, adr_Nr_random
	MOV R1, [R0]
	add R1,1
	MOV [R0],R1
	Pop R1					; Recupera registos
	pop R0
	RET						; Termina a rotina
; **********************************************************************
; Rodar tetramino
;   Rotina que faz uma pausa.
; Entradas:
;  none
; Saidas:
;   Nenhuma
; **********************************************************************
rodar_tetra:
	push R0
	push R1
	push R2
	push R3
	push R8
	push R9
	push R10
	
	MOV R0,Flag_Tecla_Pressionada 
	mov R1,[R0]
	AND R1,R1  ;ve se ja corremos esta rotina atravez da flag
	JNZ fim_rot_tetra
	MOV R1,1 ;Definir tecla como clicada
	MOV [R0],R1

	
	mov R9,0 ;apagar posicao atual tetra
	call desenhar_tetra
	
	mov R0, adr_tetra_rot
	MOV R1,[R0]
	MOV R2, valor_rot_Max
	CMP R1,R2
	jz redefinir_rot_tetra
	ADD R1,1 
	jmp verificar_rodar
redefinir_rot_tetra:
	MOV R1,0 ;Faz reset a rotacao
	jmp verificar_rodar
	
verificar_rodar:
	call load_tetra_x_y_rot_teste
	
	mov R3,adr_tetra_rot_teste
	mov [R3],R1
	call verifica_desenhar
	AND R10,R10
	jz fim_rot_tetra
	jmp set_rot_tetra
	
set_rot_tetra:
	MOV [R0],R1
fim_rot_tetra:
	MOV R9,1 ;MODO escrever peca
	CALL desenhar_tetra
	pop R10
	pop R9
	pop R8
	pop R3
	pop R2
	pop R1
	pop R0
	ret
	
	
	
; **********************************************************************
; Descer Tetramino
;   Rotina que faz uma pausa.
; Entradas:
;  
; Saidas:
;   Nenhuma
; **********************************************************************
descer_tetra:
	push R0
	push R1
	push R8
	push R9
	push R10
	;DI ;desativa as interrupcoes para nao ocorrer problemas quando se apaga o monstro e o tetramino
	mov R9,0 ;apagar posicao atual tetra
	call desenhar_tetra

	call load_tetra_x_y_rot_teste
	
	mov R0, adr_y
	mov R9, adr_y_teste
	movb R1,[R0]
	add R1,1
	movb [R9],R1
	
	;movb [R0],R1
	
	call verifica_desenhar
	AND R10,R10
	JZ criar_novo_tetra_flag	
	
	
	
	movb [R0],R1
	
	mov R9,1 ;para desenhar o tetramino
	jmp fim_descer
	
	

	
	
criar_novo_tetra_flag:
	
	
	
	MOV R0, teclado_Jumper_FLAG
	MOV R1, [R0]
	SET R1, 4
	
	MOV [R0],R1
	call verificar_matou_monstro
	AND R10,R10
	jnz se_matou_monstro ;se matou o monstro
	mov R9,1 ;para desenhar o tetramino
	jmp fim_descer
se_matou_monstro:
	MOV R0,adr_x_monstro
	mov R1,x_monstro_inicial;vai meter o x do monstro de novo na posicao inicial 
	MOV [R0],R1 ;para nao ocorrer falsas verificacoes apos o monstro morrer
	mov R9,0 ;para apagar o tetramino
	call ecra_linhalateral
	
	
	
	
fim_descer:	
	
	call desenhar_tetra
	POP R10
	pop R9
	POP R8
	pop R1
	pop R0
	ret
	
	
; **********************************************************************
; Verificar se matou monstro
;   Rotina que faz uma pausa.
; Entradas:
; 
; *  R8 - Linha a verificar
; *  R9 - Coluna a verificar
; Saidas:
;   R10, 2 se matou, 0 se n
; **********************************************************************
verificar_matou_monstro:
    PUSH  R1 ; Guarda R1
    PUSH  R2 ; Guarda R2
    PUSH  R4 ; Guarda R4
    PUSH  R8 ; Guarda R8
	PUSH R9
	

	MOV R10,0 ;Caso n for alterado indica q o mosntro n foi morto
	MOV R1,const_y_monstro

	CMP R8, R1 ; Se o y for igual aos quadrados superiores do monstro 
	JZ verificar_x ; vai verificar se o x esta alinhado com o monstro
	ADD R1,1 ;Para ver se tocou no quadrado mais pequeno
	CMP R8, R1 ; Se o y for igual ao quadrado inferior do monstro 
	JZ verificar_x ; vai verificar se o x esta alinhado com o monstro
	jmp fim_verif_m_monstro
	
verificar_x:
	MOV R4,R9 ;backup do y do tetramino
	MOV R1,adr_x_monstro
	MOVb R2,[R1] ;x do monstro
	ADD R2,3 ;x max onde ja nao e monstro
	SUB R4,R2
	JNN fim_verif_m_monstro ;se for superior ao x maximo ent n matou
	SUB R2,4 ;x min q ja n pertence ao monstro
	SUB R2,R9
	JNN fim_verif_m_monstro ; se x for inferior ao x minimo ent n matou
	
	DI1
	
	MOV R9,teclado_Jumper_FLAG
	MOV R1,[R9]
	CLR R1,1 ;vai apagar a flag q mexe o montro
	MOV [R9],R1 ;visto q ja n ta ativo
	
	MOV R9,monstro_ativo ;endereco do valor q indica se um monstro se econtra ativo
	MOV R1,0
	MOV [R9],R1 ;ira indicar q o monstro ja n se encontra ativo
	
	MOV R9,0 ;ira apagar o monstro atual 
	call desenhar_monstro
	
	MOV R10,2  ;ira somar 2 a pontuacao
	call soma_ecra_segmentos
	

fim_verif_m_monstro:
	
	POP R9
	POP R8
	POP R4
	POP R2
	POP R1
	RET

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
	MOV R4, 4 ; Atualiza R4 com o numero de bytes de cada linha do ecra (linhas)
	MOV R5, 8 ; Atualiza R5 com o numero de bits por byte do ecra (colunas)
	MOV R6, 80H ; (10000000) Mascara que permite escrever nas colunas de cada byte atraves de shifts
	MUL R4, R2 ; Transforma R2 numa linha do ecra
	ADD R0, R4 ; Acede a linha do ecra onde e suposto escrever
	MOV R7, R3 ; R7 com o valor da coluna para dividir pelo numero de colunas
	DIV R7, R5 ; Transforma R7 numa coluna da linha onde escrever
	ADD R0, R7 ; Acede a coluna onde escrever
	MOD R3, R5 ; R3 com o bit onde escrever (R3 sera um valor de 0-7 que sao o numero de colunas)
selecao_pixel0:
	AND R3, R3 ; Afectar as flags
	JZ verif_pintado ; Quando for o ultimo bit a verificar salta para decidir se desenha ou apaga
	SHR R6, 1 ; Atualiza a mascara para o bit seguinte ate ao bit onde e suposto escrever
	SUB R3, 1 ; Atualiza a coluna (avanca para o proximo bit)
	JMP selecao_pixel0 ; Verifica os bits todos de R3
verif_pintado:
	MOVB R8, [R0] ; Move para R8 o que esta escrito no byte do ecra
	AND R8, R6 ; Apaga apenas o bit escolhido
	JNZ nao_pode_pintar
	MOV R10, 1
	JMP fim_verificar_pixel
nao_pode_pintar:
	MOV R10, 0
fim_verificar_pixel:
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

	
; **********************************************************************
; Rotina Verifica Desenhar
;   Rotina que testa a ver se pode desenhar a peca
; Entradas:
;   Nenhuma
; Saidas:
;	R8 -linha
; 	R9 -coluna q n pode ser escrita
;   R10 - 1 (Pode desenhar) ou 0 (Nao pode desenhar)
; **********************************************************************

verifica_desenhar:
    PUSH  R0 ; Guarda R0
    PUSH  R1 ; Guarda R1
    PUSH  R2 ; Guarda R2
    PUSH  R3 ; Guarda R3
    PUSH  R4 ; Guarda R4
    PUSH  R5 ; Guarda R5
    PUSH  R6 ; Guarda R6
    PUSH  R7 ; Guarda R7
    

	MOV R0, adr_tetra_tipo
	MOV R1,[R0]
	MOV R0, adr_tetra_rot_teste
	MOV R2, [R0]
	shl R2,1 ; multiplica por 2
	add R1,R2 ;endereco tabela final
	MOV R0,[R1]
	;ir buscar x e y do tetramino 
	MOVB R4,[R0] ;linha
	add R0,1 ;adr coluna
	MOVb R5,[R0];coluna
	MOV R8, adr_y_teste 				;MALL ALTERAR AQUI E NOS OURTOS LADOS E COLUNA; Atualiza R0 com o valor correspondente a linha inicial onde desenhar o tetramino
	MOVB R2, [R8] ; Mete em R2, o valor da linha onde comecar a desenhar
	MOV R8, adr_x_teste ; Acede a tabela que contem as posicoes 
	MOVB R3, [R8] ; Mete em R3, o valor da coluna onde comecar a desenhar
	MOV R8, 13 ; Valor limite nas colunas
	MOV R7, R3 ; 
	ADD R7, R5 ; Adiciona a coluna a testar o numero de colunas da tabela
	CMP R8, R7 ; Se for igual nao desenha
	JZ nao_pode ; Salta para nao desenhar
	MOV R8, 0FFH ; Valor limite nas colunas
	
	CMP R8, R3 ; Se for igual nao desenha
	JZ nao_pode ; Salta para nao desenhar
	MOV R8, 21H ; Valor limite das linhas
	MOV R7,R2 
	ADD R7,R4 ;adicionar o nr de linhas de modo a verificar o y max em q quer escrever
	CMP R8, R7 ; Se for igual nao desenha
	JZ nao_pode ; Salta para nao desenhar
	MOV R7, R4 ; Duplica o valor das linhas em registo para criar 1 contador
	MUL R7, R5 ; Multiplica o valor das linhas pelas colunas, para criar 1 contador do numero de elementos da tabela
	ADD R3, R5 ; Permite repor corretamente os contadores
	SUB R2, 1 ; Permite repor corretamente os contadores
repor_contadores:
	MOV R6, R5 ; Duplica o valor das colunas em registo para fazer um contador
	SUB R3, R5 ; Repoe o valor da coluna onde escrever
	ADD R2, 1 ; Muda a linha onde escrever
loop_testar_tetra:
	ADD R0, 1 ; Acede ao proximo elemento da tabela
	MOVB R1, [R0] ; R1 com o valor a escrever no ecra
	AND R1, R1 ; Afeta as flags
	JZ nao_testar ; Se for um 0 nao testa
	CALL verificar_pixel ; Chama a rotina que verifica 1 pixel da tabela de strings, e ve se esta desenhado ou nao
	AND R10, R10
	JZ nao_pode
	;call desenhar_pixel ;Debuggin purposes
nao_testar:
	Sub R7,1 ; Atualiza o contador
	JZ pode ; Se ainda nao acabou corre outra vez
	ADD R3, 1 ; Muda a coluna onde escrever
	SUB R6, 1 ; Atualiza o contador de colunas
	JZ repor_contadores ; Se for 0 repoe as colunas
	JMP loop_testar_tetra
nao_pode:
	MOV R10, 0
	MOV R8,R2 ;linha 
	MOV R9,R3 ;e coluna q nao podem ser escritos
	JMP fim_verifica_desenhar
pode:
	MOV R10, 1
	MOV R8,0 ;retornara linha 
	MOV R9,0 ;e coluna sem significado
fim_verifica_desenhar:
	
    
    POP R7 ; Devolve R7
    POP R6 ; Devolve R6
    POP R5 ; Devolve R5
    POP R4 ; Devolve R4
    POP R3 ; Devolve R3
    POP R2 ; Devolve R2
    POP R1 ; Devolve R1
    POP R0 ; Devolve R0
    RET ; Termina rotina

	
	
	
; **********************************************************************
; apaga LINHA
;   ve se existe uma linha toda vermelha
; Entradas:
; *  
; *  
; *  
; Saidas:
;   R10 - 1, se pode desenhar 0, se n pode
; **********************************************************************


apagar_linha:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R10
	MOV R0, local_Ecra ; R0 com o endereco do ecra
	MOV R1, elem_Ecra ; Numero total de bytes do ecra
	MOV R2, 255 ; Mascara para testar o primeiro byte
	MOV R3, 240 ; Mascara para testar metade do byte
	MOV R6, 2 ; Valor de bytes necessarios preenchidos para apagar a linha
	SUB R0, 1
loop_byte:
	ADD R0, 1
	MOV R5, 0 ; Contador para ver se sao 1 byte e meio preenchidos
	MOVB R4, [R0] ; R4 com o conteudo de 1 byte do ecra
	SUB R1, 1 ; Atualiza o contador de bytes
	CMP R4, R2 ; Verifica se a linha esta toda preenchida
	JNZ loop_meiobyte ; Se nao estiver toda preenchida passa o proximo byte
	ADD R5, 1 ; Adiciona 1 ao contador se o byte estiver preenchido
loop_meiobyte:
	ADD R0, 1 ; Acede ao byte seguinte do ecra
	MOVB R4, [R0] ; R4 com o conteudo de 1 byte do ecra
	AND R4, R3
	SUB R1, 1 ; Atualiza o contador de bytes
	CMP R4, R3 ; Verifica se metade esta preenchida
	JNZ loop_add2 ; Se nao estiver preenchido passa de linha
	ADD R5, 1 ; Atualiza o contador de bytes preenchidos
	CMP R5, R6 ; Verifica se estao 2 bytes preenchidos
	JZ apagar ; Se estiverem 2 bytes preenchidos salta para apagar a linha
loop_add2:
	ADD R0, 2 ; Passa a frente dos 2 bytes
	SUB R1, 2 ; Atualiza o contador de bytes
	JZ fim_apagar_linha ; Se ja testou os bytes todos acaba
	JMP loop_byte ; Volta a correr o loop ate ja ter testado todos os bytes
apagar:
	MOV R5, 08H ; Valor a escrever para apagar meio byte
	MOVB [R0], R5 ; Apaga os bits de maior valor do 2 byte da linha
	SUB R0, 1 ; Acede ao byte anterior
	MOV R5, 00H ; Valor a escrever para apagar o byte
	MOVB [R0], R5 ; Apaga o byte
	ADD R0, 1 ; Acede ao byte seguinte para voltar ao normal
	Mov r6,r0 ;guardar localizao ultimo byte em r2
	MOV R10,5 ;vai adicionar 5 pontos no ecra de segmentos
	call soma_ecra_segmentos
	MOV R0, local_Ecra ; R0 com o endereco do ecra
	
	mov R1,r6
	sub R1,4 ;a linha a cima do R0
	
	JMP baixar_linhas ; Vai para o loop para continuar a testar as linhas
	
baixar_linhas:
	movb r2,[r1]
	movb [r6],r2 ;vai por byte na linha a seguir
	sub r6,1 ; vai para o byte seguinte
	sub r1,1 ; vai para o byte seguinte
	movb r2,[r1]
	movb [r6],r2 ;vai por byte na linha a seguir
	cmp r1,r0 ; vai verificar se ja chegamos ao fim da linha
	jz fim_apagar_linha
	sub r6,3 ; vai para a linha seguinte ignorando os bytes q nao queremos alterar
	sub r1,3 
	jmp baixar_linhas
	
fim_apagar_linha:
	POP R10
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET

	
	; **********************************************************************
; Mover Monstro
;   Rotina que faz uma pausa.
; Entradas:
;  
; Saidas:
;   Nenhuma
; **********************************************************************
mover_monstro:
	push R0
	push R1
	push R2
	push R9
	mov R9,0 ;apagar posicao atual tetra
	call desenhar_monstro
	mov R0, adr_x_monstro
	movb R1,[R0]
	sub R1,1
	
	movb [R0],R1
	mov R9,1
	call desenhar_monstro
	AND R1,R1 ; Fazemos este compare depois de desenhar o mosntro para afetar as flags
	jz monstro_gameover ; e permitir a visualizacao do monsto chegar ao fim antes do gameover
	jmp monstro_fim
monstro_gameover:

	MOV R0, teclado_Jumper_FLAG
	MOV R1, [R0]
	SET R1, 3 ;Mete no Jumper flag a flag que forca o game over
	
	MOV [R0],R1
	
monstro_fim:
	pop R9
	pop R2
	pop R1
	pop R0
	ret
; *********************************************************************************
; * Mover Tetramino
; * Recebe da Memoria:
; * 	///R0 - tabela
; * 	R9 - 1 Direita, 0 Esquerda
; * Saidas:
; * 	
; *********************************************************************************

mover_tetramino:
	PUSH R0
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
	mov R1,[R0]
	AND R1,R1  ;ve se ja corremos esta rotina atravez da flag
	JNZ fim_mover_tetra
	MOV R1,1 ;Definir tecla como clicada
	MOV [R0],R1
	
	
	MOV R0, adr_tetra_tipo
	MOV R1,[R0]
	MOV R0, adr_tetra_rot
	MOV R2, [R0]
	shl R2,1 ; multiplica por 2
	add R1,R2 ;endereco tabela final
	MOV R0,[R1]
	

	;mov R6, adr_x
	;movb R3,[R6]
	;add R3,1
	;movb [R6],R1
	
	MOV R6, adr_x ; Acede a tabela que contem as posicoes 
	MOVB R3, [R6] ; Mete em R3, o valor da coluna onde comecar a desenhar
	
	AND R9,R9
	JZ esquerda
	
direita:
	ADD R3, 1 ; Adidicona 1 ao valor da coluna para mover para a direita
	JMP mover ; Salta para concluir o movimento
esquerda:
	SUB R3, 1 ; Subtrai 1 para mover para a esquerda
mover:
	MOV R9, 0 ; Mete em R9 1 valor para decidir de desenha ou apaga, se 1 escreve se 0 apaga
	CALL desenhar_tetra
	
	
	
	
	;MOVB R4, [R0] ; R4 com o valor correspondente ao numero de linhas da tabela
	;ADD R0, 1 ; Acede ao proximo elemento da tabela de strings
	;MOVB R5, [R0] ; R5 com o valor correspondente ao numero de colunas da tabela
	CALL load_tetra_x_y_rot_teste
	MOV R7,adr_x_teste
	MOVB [R7],R3
	CALL verifica_desenhar ; Chama a rotina que verifica se pode desenhar, se R11 for 0 nao pode, se for 1 pode
	AND R10, R10 ; (O registo depende da funcao verifica_desenhar)
	JZ fim_mover_tetra ; Se nao poder desenhar acaba
	
	
	MOVb [R6],R3
	
fim_mover_tetra:
	MOV R9, 1 ; Mete em R9 1 valor para decidir de desenha ou apaga, se 1 escreve se 0 apaga
	CALL desenhar_tetra
	POP R9
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
; Carrega a localizacao e rotacao atual do tetramino para as variaveis teste
;   Rotina que faz uma pausa.
; Entradas:
;  
; Saidas:
;   Nenhuma
; **********************************************************************
load_tetra_x_y_rot_teste:
	PUSH R0
	PUSH R1
	PUSH R2
	
	MOV R0, adr_x ; Tabela de posicao atual
	MOV R1 ,adr_x_teste ; Tabela de posicao teste
	MOVB R2, [R0] 
	MOVB [R1],R2 ;Mete o valor na tabela
	
	MOV R0, adr_y ; Tabela de posicao atual
	MOV R1 ,adr_y_teste ; Tabela de posicao teste
	MOVB R2, [R0] 
	MOVB [R1],R2 ;Mete o valor na tabela
	
	MOV R0, adr_tetra_rot ; Tabela de rotacao atual
	MOV R1 ,adr_tetra_rot_teste ; Tabela de rotacao teste
	MOV R2, [R0] 
	MOV [R1],R2 ;Mete o valor na tabela
	
	POP R2
	POP R1
	POP R0
	RET
	
; **********************************************************************
; Interrupçao 0
;   Rotina que faz uma pausa.
; Entradas:
;  
; Saidas:
;   Nenhuma
; **********************************************************************
int0:
	push R0
	push R1
	MOV R0, teclado_Jumper_FLAG
	MOV R1, [R0]
	SET R1, 0
	
	MOV [R0],R1
	pop R1
	pop R0
	;call descer_tetra
	RFE
; **********************************************************************
; Interrupçao 1
;   Rotina que faz uma pausa.
; Entradas:
;  
; Saidas:
;   Nenhuma
; **********************************************************************
int1:
	push R0
	push R1
	MOV R0, teclado_Jumper_FLAG
	MOV R1, [R0]
	SET R1, 1
	;CLR R1,0
	MOV [R0],R1
	pop R1
	pop R0
	RFE
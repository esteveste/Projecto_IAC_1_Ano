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

adr_Tecla_Valor         EQU 1400H	 ; Endereço de memória onde se guarda a tecla premida
adr_Nr_random 			EQU 1410H
adr_x					EQU 1420H  ;linha
adr_y					EQU 1430H   ;coluna 
adr_tetra_tipo			EQU 1440H  
adr_tetra_rot 			EQU 1450H ;nr a adicionar ao tipo na tabela(melhorar coment)
linha	                EQU 8H       ; Posição do bit correspondente à linha a testar
local_Segmentos	        EQU 0A000H 	 ; Endereco do display de 7 segmentos
out_Teclado	            EQU 0C000H   ; Endereço do porto de escrita do teclado
in_Teclado		        EQU 0E000H   ; Endereço do porto de leitura do teclado
MAX_ECRA                EQU 128H     ; Número de bytes do ecrã
MAX_ELE 	            EQU 128
tecla_pausa             EQU 0CH
tecla_about             EQU 0AH
tecla_terminar          EQU 0EH
tecla_jogar             EQU 0BH
local_Ecra	            EQU 8000H
OFF                     EQU 0        ; Valor da tecla nao premida
ON                      EQU 1        ; Valor da tecla premida
estado_Welcome          EQU 0
estado_Preparar_jogo            EQU 1
estado_Jogo             EQU 2
estado_Suspender        EQU 3
estado_Gameover         EQU 4
estado_About            EQU 5
mascara_0_1bits EQU 3H
mascara_2_3bits EQU 0CH
sequencia_tetraminoI EQU 00H
sequencia_tetraminoL EQU 01H
sequencia_tetraminoT EQU 02H
sequencia_tetraminoS EQU 03H
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

ecra_about:
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

ecralinha:
STRING 0000H, 0008H, 0000H, 0000H

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
STRING 4, 1; linhas e colunas
STRING 1
STRING 1
STRING 1
STRING 1
		
tetraminoI2:
STRING 1, 4; linhas e colunas
STRING 1, 1, 1, 1
			
tetraminoI3:
STRING 4, 1; linhas e colunas
STRING 1
STRING 1
STRING 1
STRING 1
		
tetraminoI4:
STRING 1, 4; linhas e colunas
STRING 1, 1, 1, 1
	
tetraminoL:
WORD tetraminoL1
WORD tetraminoL2
WORD tetraminoL3
WORD tetraminoL4

tetraminoL1:
STRING 3, 2; linhas e colunas
STRING 1, 0
STRING 1, 0
STRING 1, 1
			
tetraminoL2:
STRING 2, 3; linhas e colunas
STRING 1, 1, 1
STRING 1, 0, 0
			
tetraminoL3:
STRING 3, 2; linhas e colunas
STRING 1, 1
STRING 0, 1
STRING 0, 1
			
tetraminoL4:
STRING 2, 3; linhas e colunas
STRING 0, 0, 1
STRING 1, 1, 1
		
tetraminoS:
WORD tetraminoS1
WORD tetraminoS2
WORD tetraminoS3
WORD tetraminoS4

tetraminoS1:
STRING 2, 3; linhas e colunas
STRING 0, 1, 1
STRING 1, 1, 0
		
tetraminoS2:
STRING 3, 2; linhas e colunas
STRING 1, 0
STRING 1, 1
STRING 0, 1
			
tetraminoS3:
STRING 2, 3; linhas e colunas
STRING 1, 1, 0
STRING 0, 1, 1
			
tetraminoS4:
STRING 3, 2; linhas e colunas
STRING 0, 1
STRING 1, 1
STRING 1, 0
			
tetraminoT:
WORD tetraminoT1
WORD tetraminoT2
WORD tetraminoT3
WORD tetraminoT4

tetraminoT1:
STRING 2, 3; linhas e colunas
STRING 1, 1, 1
STRING 0, 1, 0
			
tetraminoT2:
STRING 3, 2; linhas e colunas
STRING 0, 1
STRING 1, 1
STRING 0, 1
		
tetraminoT3:
STRING 2, 3; linhas e colunas
STRING 0, 1, 0
STRING 1, 1, 1
			
tetraminoT4:
STRING 3, 2; linhas e colunas
STRING 1, 0
STRING 1, 1
STRING 1, 0

monstro:
STRING 3, 3; linhas e colunas
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

; Tabela de vectores de interrupção
tab_int:        WORD    int0
				WORD    int1

; *********************************************************************************
; * Tabela de endereços de estados do loop de controlo
; *********************************************************************************

;PLACE       1500H

tab_estado:
    WORD  Welcome     	; 0
	WORD Preparar_jogo	; 1
	WORD  Jogo 			; 2
	Word Suspender 		; 3 
	Word Gameover 		; 4
	Word About 			; 5
estado_programa:        ; variavel que guarda o estado actual do controlo
    STRING 0H; ;;SEMMPREEE MOVB

; ***********************************************************************
; * Código
; ***********************************************************************

PLACE      0
inicializacao:		     ; Inicializações gerais
	mov  SP, SP_pilha
	mov  BTE, tab_int	 ; Inicializacao BTE
	;EI0
	;EI1
; ***********************************************************************
; * Estados
; * Código
; * Código
; * Código
; * R0 R1
; ***********************************************************************
loop_estados:
	mov R0, estado_programa ; Fazer comentarios diferentes ; Obter o estado actual
	movb R1, [R0]
	shl R1,1  				; Multiplicar por dois visto os endereços de 2 bytes em 2
	mov   R0, tab_estado    ; Endereço base dos processos do jogo
    add   R1, R0            ; Agora R0 aponta para a rotina correspondente ao estado actual
    mov   R0, [R1]          ; Obter o endereço da rotina a chamar
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
	mov  R1, 255           ; Corresponde ao valor FF no ecra
	call ecra_segmentos
	mov R0, ecra_inicio
	call escreve_tabela_ecra
esperar_tecla:
	call teclado ;(FAZER MAIS TARDE)
	mov R0, adr_Tecla_Valor
	movb R2,[R0]
	mov R3, tecla_jogar
	CMP R2, R3 ; tecla c
	JNZ esperar_tecla
	mov R0, estado_programa ; Fazer comentarios diferentes ; Obter o estado actual adrress
	mov R1, estado_Preparar_jogo  ; 
	movb [R0], R1
	pop R3
	pop R2
	pop R1
	pop R0
	ret
; *********************************************************************************
; * Rotina Suspender
; * 
; *********************************************************************************
	
Suspender:
    PUSH R1 			; Guarda registos
    PUSH R2 
    DI    				; Desliga as interrupcoes
    CALL inverte_ecra 	; Chama a rotina de inverter o ecra para diferenciar do estado normal de jogo
ciclo_suspender:
    CALL  teclado 		; Chama a rotina do teclado e devolve em R1 a tecla pressionada
    MOV   R2, tecla_pausa ; Atualiza R2 com o valor da tecla de suspender
    CMP   R1, R2 		; Verifica se a tecla pressionada e a tecla de suspender
    JNZ   ciclo_suspender ; Caso nao seja a tecla de suspender, repete ate receber a tecla de suspender para tirar do modo de pausa
    MOV   R2, estado_Jogo		; Atualiza R2 com o novo estado (estado jogar)
    MOV   R1, estado_programa
    MOVB  [R1], R2 		; Atualiza o estado_programa com o novo estado
	;EI1 ; Liga as interrupcoes
    ;EI0 talvez desnecessario
    EI
    CALL inverte_ecra
    POP R2 				; Retorna registos
    POP R1 
    RET 				; Termina a rotina

; *********************************************************************************
; * Rotina About
; * 
; *********************************************************************************

About:
	PUSH R0 			; Guarda registos
	PUSH R1 
	PUSH R2 
	MOV R0, ecra_about 	; Guarda em R0 a tabela de strings ecra_about
	CALL escreve_tabela_ecra ; Chama a rotina para escrever no ecra a tabela de strings ecra_about
about_loop:
	CALL esperar_tecla 	; Chama a rotina que devolve o valor de uma tecla premida
	MOV R2, tecla_terminar ; Atualiza R2 com o valor da tecla terminar
	CMP R1, R2 			; Verifica se a tecla e' a tecla de terminar
	JNZ verif_jogar 	; Se nao for verifica se e a de jogar
	MOV R2, estado_Gameover 			; Atualiza R2 com o valor do novo estado (estado terminar)
	JMP terminar 		; Termina caso seja a tecla terminar
verif_jogar:
	MOV R2, tecla_jogar ; Atualiza R2 com o valor da tecla jogar
	CMP R1, R2 			; Verifica se a tecla e' a tecla de jogar
	JNZ about_loop 		; Se nao for corre o loop outra vez
	MOV R2, estado_Preparar_jogo 			; Atualiza R2 com o valor do novo estado (estado jogar)
terminar:
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOV [R1], R2 		; Atualiza o estado programa com o valor do estado atual (estado terminar)
sair_about:
	POP R2 				; Retorna registos
	POP R1 
	POP R0 
	RET 				; Termina a rotina
; *********************************************************************************
; * Rotina Game Over
; * R1 sera a tecla recebida por esperar tecla, como nao sabia qual seria o registo da tecla usei R1
; *********************************************************************************

Gameover:
	PUSH R0 		; Guarda registos
	PUSH R1 
	PUSH R2 
	CALL inverte_ecra ; Chama a rotina para inverter o ecra
	;DI1 ; Desliga as interrupcoes
    ;DI0
    DI
	MOV R0, ecra_fim ; Guarda em R0 a tabela de strings ecra_fim
	CALL escreve_tabela_ecra ; Chama a rotina para escrever no ecra a tabela de strings ecra_fim
gameover_loop:
	CALL teclado 	; Chama a rotina que devolve o valor de uma tecla
	MOV R2, tecla_jogar ; Atualiza R2 com o valor da tecla jogar
	CMP R1, R2 		; Verifica se a tecla e' a de jogar
	JNZ verif_about ; Se nao for verifica se e' a de about
	MOV R2, estado_Preparar_jogo 		; Atualiza R2 com o estado novo (estado preparar jogo)
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOV [R1], R2 	; Atualiza o estado programa com o valor do estado atual (estado jogar)
	JMP sair_gameover
verif_about:
	MOV R2, tecla_about ; Atualiza R2 com o valor da tecla about
	CMP R1, R2 		; Verifica se e' a tecla about
	JNZ gameover_loop ; Volta a correr o loop gameover
	MOV R2, estado_About 		; Atualiza R2 com o estado novo (estado about)
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOV [R1], R2 	; Atualiza o estado programa com o valor do estado atual (estado about)
sair_gameover:
	POP R2 			; Retorna registos
	POP R1 
	POP R0 
	RET 			; Termina a rotina
; *********************************************************************************
; * Rotina que cria prepara o jogo
; *********************************************************************************

Preparar_jogo:
	PUSH R0			; Guarda registos
	PUSH R1
	CALL limpar
	CALL ecra_linhalateral ; Chama a rotina para desenhar o limite lateral
	mov R1,0 ; valor 00 para mostrar no ecra de segmentos
	call ecra_segmentos
	MOV R0, estado_programa ; Move o endereco do estado_programa para R0
	MOV R1, estado_Jogo ; Atualiza R1 com o valor do estado jogar
	MOVB [R0], R1 ; Atualiza o valor do estado_programa para o estado atual (estado jogar)
	;MOV R0, l_centro_tetramino ; Atualiza R0 com a word que contem a linha inicial para desenhar o tetramino
	;MOV R2, [R0] ; Atualiza R1 com o valor da linha
	;MOV R0, c_centro_tetramino ; Atualiza R0 com a word que contem a coluna inicial para desenhar o tetramino
	;MOV R3, [R0] ; Atualiza R2 com o valor da coluna
	;CALL desenha_tetramino ; Chama a rotina que vai desenhar o tetramino
	;CALL inicializar_pontos ; Chama a rotina que vai inicializar a contagem dos pontos
	;EI ; Liga as interrupcoes para permitir o movimento dos tetraminos
	POP R1			; Retorna registos
	POP R0
	RET				; Termina a rotina
	
	

;####Jogo
Jogo:
	mov R1, adr_x
	mov R0,0
	mov [R1], R0 ;mete a posicao padrao para ser escrita
	mov R0,0
	mov R1, adr_Nr_random
	mov R0, [R1] ;Nr aleatorio
	mov R1, mascara_0_1bits
	and R0, R1 ;;isola os ultimos 2 bits
select_tetra:
	mov R1,0 ;valor a saltar na tab tetraminos
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
	mov R2, tetraminos ;endereco para selecionar tetra
	add R2, R1;mete o pointer no tetra
	mov R1, [R2] ;mete na variavel endereco tabela rotacao de tetra
	mov R0, adr_tetra_tipo 
	mov [R0], R1 ; escreve a tabela rotacao de tetra em adr_tetra_tipo
	mov R0, adr_tetra_rot ;para registar na memoria o valor inicial da rotacao
	mov R1, 0H
	mov [R0], R1; rotacao inicial de tetra

	
	
	
	
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
	call definir_Linha
	pop r6					; Retorna registos
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
definir_Linha:             ; Redifine a linha quando o shr chegar a 0
	mov  R1, linha         ; Valor maximo das linhas  
	;mov  R5,OFF            ; Redefine se a tecla esta pressionada, para ser voltada a ser verificada

scan_Teclado:              ; Rotina que lê o teclado 
	mov  R2, out_Teclado   ; R2 fica com o valor 0C000H(porto de escrita)
	movb [R2], R1      	   ; Escreve no periférico de saída
	mov  R2, in_Teclado    ; R2 fica com o valor 0E000H(porto de leitura)
    movb R3, [R2]      	   ; Lê do periférico de entrada
    and  R3, R3       	   ; Afecta as flags (movs não afectam as flags)
    jz   mudar_Linha       ; Se nenhuma foi tecla premida, muda de linha
    jmp  tecla_Pressionada ; Caso tecla premida, começa a função
	
mudar_Linha:
	shr  R1,1			   ; Vai alterando a linha a varrer
	jz   definir_Linha      ; @@@@@@MALLL DESCRICAO Verificar estado da tecla apos varrimento das 4 linhas
	jmp  scan_Teclado      ; Caso ainda não acabou o varrimento de todas as linhas, fazer scan linha seguite
	
;estado_Tecla:              ; Verifica se alguma tecla foi clicada durante o varrimento
;	and  R5,R5			   ; Afeta as flags
;	jz   verificar_Ciclo   ; Se tecla nao premida 
;	mov  R6,1              ; Se uma tecla foi clicada, define um valor que representa q o display_Inativo ainda não correu
;	jmp  definir_Linha
	
;verificar_Ciclo:
;	and  R6,R6             ; Verifica se o display_Inativo já correu
;	jnz  display_Inativo   ; Vai mostrar que nenhuma tecla desta linha foi premida
;	mov  R5, OFF
;	jmp  definir_Linha     ; Verificar se a tecla premida esta na proxima linha

tecla_Pressionada:         ; Verifica qual a tecla premida
	mov r5, 0 			   ; Redifinir contadores
	mov r6, 0 
	call linha_Count
	call coluna_Count
	call transform_Hex
	call gravar_Mem_Teclado
	ret					   ; Termina a rotina
linha_Count:               ; Ciclo que conta o nº de linhas
	add  R5,1			   
	shr  R1,1			   ; Conta o nº de shift ate dar 0
	jnz  linha_Count
	sub  R5,1 			   ; Fazer o contador comecar em 0
	ret		               ; Vai para coluna_Count

coluna_Count:              ; Ciclo que conta o nº de colunas
	add  R6,1 			   
	shr  R3,1			   ; Conta o nº de shift ate dar 0
	jnz  coluna_Count
	sub  R6,1 			   ; Fazer o contador comecar em 0
	ret

transform_Hex:             ; Vai transformar o numero de colunas e linhas no valor do teclado
	shl  R5,2 			   ; Multiplica por 4,valor a somar a linha
	add  R6,R5			   ; Valor da tecla em R6
	ret

gravar_Mem_Teclado:
    mov  R4, adr_Tecla_Valor        
	movb [R4], R6      	   ; Guarda tecla premida na memória de endereço 100H
	ret

;###########################################################	
	
display_Inativo:           ; Ecra mostra que nao ha tecla premida
	push R0				   ; Guarda registos
	push R9
	;mov  R0, local_Segmentos ; Volta ao endereço 0A000H
	mov  R1, 255           ; Corresponde ao valor FF no ecra
	movb [R0],R9           ; Escreve no local_Segmentos
	pop  R9				   ; Retorna registos
	pop  R0
	;mov  R6,0              ; O ciclo do ecra inativo ja foi corrido
	;mov  R5,OFF; Sem tecla premida
	jmp  definir_Linha
##### Recebe R1
ecra_segmentos:             ; Mostra que tecla foi premida, no ecra de segmentos
	push R0				   ; Guarda registos
	push R1
	push R2
	;mov  R1, adr_Tecla_Valor        ; Endereço de memória com o valor da tecla
	movb R2,[R1]           ; Obtem valor da tecla
	mov  R0, local_Segmentos   ; Define endereço de escrita display (0A000H)
	movb [R0],R2           ; Escrever no display o valor da tecla
	pop  R2				   ; Retorna registos
	pop  R1
	pop  R0
	;mov  R6,1			   ; Define um valor que representa que a tecla ja foi representada no ecra
	jmp  scan_Teclado      ; Volta a varrer o teclado
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
	MOVb [R0], R2 ; Limpa 1 byte do ecra
	ADD R0, 1 ; Acede ao byte seguinte do ecra
	SUB R1, 1 ; Atualiza o contador de bytes
	JNZ loop_limpar ; Corre o loop outra vez ate todos os bytes estarem limpos
	POP R2 ; Devolve R2
	POP R1 ; Devolve R1
	POP R0 ; Devolve R0
	RET ; Termina a rotina
;############################################################
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
    MOV   R3, local_Ecra          ; Endereço do ecrã
    ADD   R3, R1            ; Actualização do endereço onde começar a escrever
    MOV   R2, MAX_ELE       ; Número de elementos da tabela de strings
ciclo_ecra:  
    MOVB  R1, [R0]          ; Elemento actual da tabela de strings
    MOVB  [R3], R1          ; Escreve o elemento da tabela de strings no ecrã
    ADD   R0, 1             ; Acede ao índice seguinte da tabela de strings
    ADD   R3, 1             ; Avança para o byte seguinte do ecrã
    SUB   R2, 1             ; Actualiza o contador
    JNZ   ciclo_ecra        ; Volta ao ciclo para escrever o que falta
    POP   R3                ; Recupera registos
    POP   R2
    POP   R1
    POP   R0
    RET   					; Termina a rotina
	
	
	
; **********************************************************************
; Inverte Ecrã
;   Inverte o ecrã, diferenciando o estado de suspensão do de jogo
; Entradas:
;   Nenhuma
; Saidas:
;   Nenhuma
; **********************************************************************
inverte_ecra:
    PUSH  R0               ; Guarda registos
    PUSH  R1
    PUSH  R2
    MOV   R0, local_Ecra   ; Endereço do ecrã
    MOV   R1, MAX_ECRA     ; Contador de bytes do ecrã
ciclo_inverte:
    MOVB  R2, [R0]         ; Obtem o byte actual do ecrã
    NOT   R2               ; Inverte o conteúdo do byte actual
    MOVB  [R0], R2         ; Coloca no ecrã o inverso do que estava escrito anteriormente
    ADD   R0, 1            ; Avança para o byte seguinte
    SUB   R1, 1            ; Actualiza o contador
    JNZ   ciclo_inverte    ; Enquanto que o contador for diferente de 0 tem que percorrer o ecrã
    POP   R2               ; Recupera registos
    POP   R1
    POP   R0
    RET                   ; Termina rotina
	
; **********************************************************************
; Pausa
;   Rotina que faz uma pausa.
; Entradas:
;   R4 - 
; Saidas:
;   Nenhuma
; **********************************************************************
pausa:
    PUSH  R0                ; Guarda registos
    MOV   R0, 5000          ; R0 com um valor grande para fazer uma contagem decrescente, apenas para fazer uma pausa entre rotinas
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
	mov R0, adr_Nr_random
	mov R1, [R0]
	add R1,1
	mov [R0],R1
	Pop R1					; Recupera registos
	pop R0
	RET						; Termina a rotina

	
; **********************************************************************
; Interrupçao 0
;   Rotina que faz uma pausa.
; Entradas:
;  
; Saidas:
;   Nenhuma
; **********************************************************************
int0:
	call random ;Criar numeros aleatorio
; **********************************************************************
; Interrupçao 1
;   Rotina que faz uma pausa.
; Entradas:
;  
; Saidas:
;   Nenhuma
; **********************************************************************
int1:
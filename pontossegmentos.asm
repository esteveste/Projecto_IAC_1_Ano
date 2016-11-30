; ***********************************************************************
; * Constantes
; ***********************************************************************


;
teclado_Jumper_FLAG			EQU 1470H
Flag_Pausa_Display			EQU 1480h ;Saber se e para criar um novo tetramino
Flag_Tecla_Pressionada 		EQU 1486H ;De modo a permitir uma rotina correr apenas 1 vez numa funcao
adr_Tecla_Valor         EQU 1490H	 ; Endereço de memória onde se guarda a tecla premida
adr_Nr_random 			EQU 1410H
adr_x					EQU 1420H  	 ; linha
adr_y					EQU 1430H    ; coluna
adr_x_teste				EQU 1426H  	 ; linha
adr_y_teste				EQU 1436H    ; coluna
adr_x_monstro			EQU 1440H
const_y_monstro 		EQU 24
adr_tetra_tipo			EQU 1450H  
adr_tetra_rot 			EQU 1460H 	 ; nr a adicionar ao tipo na tabela(melhorar coment)
adr_tab_verif_tipo		EQU 1455H    ; adr tab para verificar se pode escrever
adr_tab_verif_rot		EQU 1465H    ; adr valor de rot para adicionar a verificar
linha	                EQU 8H       ; Posição do bit correspondente à linha a testar
local_Segmentos	        EQU 0A000H 	 ; Endereco do display de 7 segmentos
out_Teclado	            EQU 0C000H   ; Endereço do porto de escrita do teclado
in_Teclado		        EQU 0E000H   ; Endereço do porto de leitura do teclado
elem_Ecra                EQU 128H     ; Número de bytes do ecrã
elem_tabelas 	            EQU 128
tecla_pausa             EQU 0CH
tecla_about             EQU 0AH
tecla_terminar          EQU 0EH
tecla_jogar             EQU 0BH
tecla_rodar				EQU 01H
tecla_direita			EQU 06H
tecla_esquerda			EQU 04H
tecla_descer			EQU 05H
local_Ecra	            EQU 8000H
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
mascara_bits_0_3		EQU 0FH
sequencia_tetraminoI 	EQU 00H
sequencia_tetraminoL 	EQU 01H
sequencia_tetraminoT 	EQU 02H
sequencia_tetraminoS 	EQU 03H
sequencia_monstro 		EQU 00H
valor_rot_Max			EQU 3

PLACE 1500H
ecra_inicio:  						; ecra que due diz "Tetris Invaders, press B"
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH

; ***********************************************************************
; * Definir SP
; ***********************************************************************
PLACE 1000H
pilha:
	table 100H               ; Tabela para stack pointer
SP_pilha:					 ; Etiqueta com o endereço final da pilha

; ***********************************************************************
; * Código
; ***********************************************************************

PLACE      0
inicializacao:		     ; Inicializações gerais
	MOV  SP, SP_pilha
	MOV R0, ecra_inicio
	CALL escreve_tabela_ecra
	CALL apagar_linha
fim:
	JMP fim
	
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


; *********************************************************************************
; * Rotina que atualiza o display hexadecimal
; *********************************************************************************

atualizar_segmentos:
	PUSH R0
	PUSH R1
	PUSH R2
	MOV R0, local_Segmentos ; R0 com o endereco do display hexadecimal
	MOVB R1, [R0] ; Mete em R1 o valor atual do display hexadecimal
	ADD R1, R2 ; Adiciona o valor recebido ao valor atual do display
	MOVB [R0], R1 ; Mete o valor novo no display
	POP R2
	POP R1
	POP R0
	RET

; *********************************************************************************
; * Rotina que atualiza o display hexadecimal
; *********************************************************************************

apagar_linha:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
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
	JMP loop_add2 ; Vai para o loop para continuar a testar as linhas
fim_apagar_linha:
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET

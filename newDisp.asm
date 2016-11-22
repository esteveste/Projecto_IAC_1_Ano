; ***********************************************************************
; * Constantes
; ***********************************************************************

adr_Tecla_Valor         EQU 100H	 ; Endereço de memória onde se guarda a tecla premida 	
linha	                EQU 8H       ; Posição do bit correspondente à linha a testar
local_Ecra	EQU 8000H 	 

    ECRA       EQU 8000H    ; Endereço do ecrã
    LINHA      EQU 8H       ; Corresponde à última linha do teclado, para se iniciar os testes
    COLUNA     EQU 8H       ; Corresponde à última coluna do teclado, para se iniciar os testes
    PIN        EQU 0E000H   ; Endereço do porto de entrada do teclado
    POUT1      EQU 0A000H   ; Endereço do porto de saída 1
    POUT2      EQU 0C000H   ; Endereço do porto de saída 2
    TEC        EQU 0FH      ; Máscara que selecciona os bits do porto de entrada que correspondem ao teclado
    MAX_ECRA   EQU 80H      ; Número de bytes do ecrã
    MAX_LINHA  EQU 3H       ; Número máximo de bits a 1 numa linha de uma nave (alien ou do jogador)
    N_ALIEN    EQU 4H       ; Número de naves alien presentes no jogo
    ENERGIA    EQU 99H      ; Inicialização da energia máxima
    LIN_ECRA   EQU 4H       ; Número de bytes que formam uma linha do ecrã
    MAX_ELE    EQU 128       ; Contador de elementos na tabela de strings de ecrã final (em bytes)
    ECRA_INT   EQU 14H      ; Número de linhas brancas antes das letras nos ecrãs de início e fim
    MASCARA    EQU 80H      ; Máscara que selecciona cada bit a um individualmente
    LIN_NAVE   EQU 15       ; Linha inicial do centro da nave do jogador
    COL_NAVE   EQU 15       ; Coluna inicial do centro da nave do jogador
    LIN_CANHAO EQU 13       ; Linha do canhão na posição inicial
    T_INIC     EQU 03H      ; Tecla de começar jogo
    T_DISPARO  EQU 05H      ; Tecla de disparar o raio
    T_SUSP     EQU 07H      ; Tecla de suspender
    T_TERM     EQU 0BH      ; Tecla de terminar jogo
    T_ROD_ESQ  EQU 0CH      ; Tecla de rodar o canhão à esquerda
    T_IGNORE1  EQU 0DH      ; Tecla sem significado
    T_ROD_DIR  EQU 0EH      ; Tecla de rodar o canhão à direita
    T_IGNORE2  EQU 0FH      ; Tecla sem significado
    T_NEUTRA   EQU 0FFH     ; Tecla neutra (o valor assumido quando não existe uma tecla premida)
    ENE_MOVE   EQU 1H       ; Valor de energia gasto quando a nave se move
    ENE_DISP   EQU 2H       ; Valor inicial de energia gasto a disparar o canhão
    ENE_CANHAO EQU 2H       ; Valor de energia gasto a disparar continuamente o canhão
	ENE_DEST   EQU 10H      ; Valor de energia ganho por destruir alien
; ***********************************************************************
; * Definir SP
; ***********************************************************************
PLACE 1000H
pilha:
	table 100H               ; Tabela para stack pointer
fim_Pilha:					 ; Etiqueta com o endereço final da pilha

ecra_fim:
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

ecraabout:
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
ecra_inicio:
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00C1H, 00F7H, 00DEH, 00BCH
STRING 0008H, 0081H, 0012H, 00A0H
STRING 00F8H, 000EH, 00E3H, 0067H
STRING 00F8H, 0081H, 00EBH, 007BH
STRING 00F8H, 000EH, 00EDH, 0043H
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
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00C4H, 0044H, 0045H, 00C7H
STRING 00C5H, 004CH, 00CFH, 00DFH
STRING 00DCH, 00DFH, 0077H, 00DFH
STRING 00DDH, 0044H, 0045H, 00C7H
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
PLACE      0
inicializacao:		       
    
    mov R2, 0

	mov R3, 0 ; counter
	mov  sp, fim_Pilha

loop1:
	mov r0,ecra_inicio
	mov r1,0
	call ecra_escreve
	call pausa
	call pausa
	call pausa
	call pausa

	call inverte_ecra
	call pausa
	call pausa
	call pausa
	call pausa

	jmp loop1
loop2:
	call display
	add R3,1
	CMP R3, 3
	JZ fim
	jmp loop2

fim:
	jmp fim
display:           
	push R0
	mov  R0, local_Ecra
	
	add  R0, R3
	;mov  R9, 170         
	movb [R0],R9           
	pop  R0
	ret
	; **********************************************************************
; Escreve Ecrã
;   Rotina que desenha uma tabela de strings no ecrã
; Entradas
;   R0 - Tabela de strings a escrever
;   R1 - Linhas em branco antes de escrever
; Saídas
;   Nenhuma
; *********************************************************************
ecra_escreve:     
    PUSH  R0                ; Guarda registos
    PUSH  R1
    PUSH  R2
    PUSH  R3
    PUSH  R4
    MOV   R3, local_Ecra          ; Endereço do ecrã
    ADD   R3, R1            ; Actualização do endereço onde começar a escrever
    MOV   R2, MAX_ELE       ; Número de elementos da tabela de strings
ciclo_ecra:  
    MOVB  R4, [R0]          ; Elemento actual da tabela de strings
    MOVB  [R3], R4          ; Escreve o elemento da tabela de strings no ecrã
    ADD   R0, 1             ; Acede ao índice seguinte da tabela de strings
    ADD   R3, 1             ; Avança para o byte seguinte do ecrã
    SUB   R2, 1             ; Actualiza o contador
    JNZ   ciclo_ecra        ; Volta ao ciclo para escrever o que falta
    POP   R4                ; Recupera registos
    POP   R3
    POP   R2
    POP   R1
    POP   R0
    RET   
	
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
;   Rotina que faz uma pequena pausa.
; Entradas:
;   Nenhuma
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

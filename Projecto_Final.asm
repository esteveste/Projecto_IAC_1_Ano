; ***********************************************************************
; *
; * Projecto IAC 1 - Versão Final
; *
; ***********************************************************************

; ***********************************************************************
; *
; * Grupo nº:11
; * Nomes:	 Bernardo Esteves, Nº87633
; *			 Daniela Olivera, Nº87647
; *			 Bernardo Santos, Nº87635
; *
; ***********************************************************************

; ***********************************************************************
; * Constantes
; ***********************************************************************

adr_Tecla_Valor         EQU 100H	 ; Endereço de memória onde se guarda a tecla premida 	
linha	                EQU 8H       ; Posição do bit correspondente à linha a testar
local_Segmentos	EQU 0A000H 	 ; Endereco do display de 7 segmentos
out_Teclado	            EQU 0C000H   ; Endereço do porto de escrita do teclado
in_Teclado		        EQU 0E000H   ; Endereço do porto de leitura do teclado
MAX_ECRA   EQU 128H      ; Número de bytes do ecrã
MAX_ELE 	EQU 128
local_Ecra	EQU 8000H
OFF         EQU 0        ; Valor da tecla nao premida
ON          EQU 1        ; Valor da tecla premida

; ***********************************************************************
; * Ecras
; ***********************************************************************
PLACE       1500H
ecra_inicio:
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00FFH, 00FFH, 00FFH, 00FFH
STRING 00C1H, 0008H, 0021H, 0042H
STRING 00F7H, 007EH, 00EDH, 00BFH
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
    WORD  Welcome       
	WORD  
estado_programa:                ; variavel que guarda o estado actual do controlo
    STRING 0H;

; ***********************************************************************
; * Código
; ***********************************************************************

PLACE      0
inicializacao:		       ; Inicializações gerais
	mov  SP, SP_pilha
	mov  BTE, tab			;inicializacao BTE

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
	shl R1,1  ; Multiplicar por dois visto os endereços de 2 bytes em 2
	mov   R0, tab_estado    ; Endereço base dos processos do jogo
    add   R1, R0            ; Agora R0 aponta para a rotina correspondente ao estado actual
    mov   R0, [R1]          ; Obter o endereço da rotina a chamar
    call  R0                ; invocar o processo correspondente ao estado
    jmp   loop_controlo     ; loop
	
	
<<<<<<< HEAD
; **********************************************************************
; Teclado
;   Guarda no [BUFFER] (100H) e em registo a tecla lida
; Entradas
;   Nenhuma
; Saídas 
;   R1(tecla premida guardada no registo), R4(tecla premida guardada na memoria)
; 
; **********************************************************************
=======
; ***********************************************************************
; * Welcome
; * Código
; * Código
; * Código
; * 
; ***********************************************************************

Welcome:
	mov R0, ecra_inicio
	call 

; ***********************************************************************
; * Teclado
; * Código
; * Código
; * Código
; * R5 R6 R9
; ***********************************************************************
>>>>>>> 92023422d3a95c83523589bdce7187231a39ba02

definir_Linha:             ; Redifine a linha quando o shr chegar a 0
	mov  R1, linha         ; Valor maximo das linhas  
	mov  R5,OFF            ; Redefine se a tecla esta pressionada, para ser voltada a ser verificada

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
	jz   estado_Tecla      ; Verificar estado da tecla apos varrimento das 4 linhas
	jmp  scan_Teclado      ; Caso ainda não acabou o varrimento de todas as linhas, fazer scan linha seguite
	
estado_Tecla:              ; Verifica se alguma tecla foi clicada durante o varrimento
	and  R5,R5			   ; Afeta as flags
	jz   verificar_Ciclo   ; Se tecla nao premida 
	mov  R6,1              ; Se uma tecla foi clicada, define um valor que representa q o display_Inativo ainda não correu
	jmp  definir_Linha
	
verificar_Ciclo:
	and  R6,R6             ; Verifica se o display_Inativo já correu
	jnz  display_Inativo   ; Vai mostrar que nenhuma tecla desta linha foi premida
	mov  R5, OFF
	jmp  definir_Linha     ; Verificar se a tecla premida esta na proxima linha
	
display_Inativo:           ; Ecra mostra que nao ha tecla premida
	push R0
	push R9
	mov  R0, local_Segmentos ; Volta ao endereço 0A000H
	mov  R9, 255           ; Corresponde ao valor FF no ecra
	movb [R0],R9           ; Escreve no local_Segmentos
	pop  R9
	pop  R0
	mov  R6,0              ; O ciclo do ecra inativo ja foi corrido
	mov  R5,OFF; Sem tecla premida
	jmp  definir_Linha
	
tecla_Pressionada:         ; Verifica qual a tecla premida
	push R1
	push R3
	push R4
	push R9
	push R10
	call linha_Count
	call coluna_Count
	call transform_Hex
	call gravar_Mem_Teclado
	pop  R10
	pop  R9               
	pop  R4
	pop  R3
	pop  R1
	mov  R5, 1             ; Tecla esta pressionada
	and  R6,R6 			   
	jz   display_Tecla     ; Se este ciclo ainda nao foi corrido
	mov  R9,0              ; Redefinir o valor da tecla
	jmp  scan_Teclado
	
linha_Count:               ; Ciclo que conta o nº de linhas
	add  R10,1			   
	shr  R1,1			   ; Conta o nº de shift ate dar 0
	jnz  linha_Count
	sub  R10,1 			   ; Fazer o contador comecar em 0
	ret		               ; Vai para coluna_Count

coluna_Count:              ; Ciclo que conta o nº de colunas
	add  R9,1 			   
	shr  R3,1			   ; Conta o nº de shift ate dar 0
	jnz  coluna_Count
	sub  R9,1 			   ; Fazer o contador comecar em 0
	ret

transform_Hex:             ; Vai transformar o numero de colunas e linhas no valor do teclado
	shl  R10,2 			   ; Multiplica por 4,valor a somar a linha
	add  R9,R10			   ; Valor da tecla em R9
	ret

gravar_Mem_Teclado:
    mov  R4, adr_Tecla_Valor        
	movb [R4], R9      	   ; Guarda tecla premida na memória de endereço 100H
	ret
	
display_Tecla:             ; Mostra que tecla foi premida, no ecra de segmentos
	push R0
	push R1
	push R2
	mov  R1, adr_Tecla_Valor        ; Endereço de memória com o valor da tecla
	movb R2,[R1]           ; Obtem valor da tecla
	mov  R0, local_Segmentos   ; Define endereço de escrita display (0A000H)
	movb [R0],R2           ; Escrever no display o valor da tecla
	pop  R2
	pop  R1
	pop  R0
	mov  R6,1			   ; Define um valor que representa que a tecla ja foi representada no ecra
	jmp  scan_Teclado      ; Volta a varrer o teclado


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
    JNZ   ciclo_ecra        ; Volta ao ciclo para escrever o que falta               ; Recupera registos
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



	
	
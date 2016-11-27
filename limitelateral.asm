; *********************************************************************************
; * Rotina que cria o limite lateral do ecra
; *********************************************************************************

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
tecla_suspender EQU 0CH
tecla_about EQU 0AH
tecla_terminar EQU 0EH
tecla_jogar EQU 0BH
local_Ecra	EQU 8000H
OFF         EQU 0        ; Valor da tecla nao premida
ON          EQU 1        ; Valor da tecla premida

; ***********************************************************************
; * Definir SP
; ***********************************************************************
PLACE 1000H
pilha:
	table 100H               ; Tabela para stack pointer
SP_pilha:					 ; Etiqueta com o endereço final da pilha

ecra_linha:
STRING 00H, 08H, 00H, 00H

; ***********************************************************************
; * Código
; ***********************************************************************

PLACE      0
inicializacao:		       ; Inicializações gerais
	mov  SP, SP_pilha
	CALL ecra_linhalateral

ecra_linhalateral:
	PUSH R0 ; Guarda Registos
	PUSH R1
	PUSH R2
	PUSH R3
	MOV R0, local_Ecra ; R0 com o endereco do ecra
	MOV R2, 128 ; Numero de bytes totais do ecra
repor_elementos:
	MOV R1, ecra_linha ; R1 com a tabela de strings que cria a linha lateral
	MOV R3, 4 ; Numero de elementos da tabela de strings (0, 1, 2, 3)
escrever_linhalateral:
	MOVB [R0], R1 ; Move o valor da tabela de strings para o ecra
	ADD R0, 1 ; Acede ao byte seguinte do ecra
	ADD R1, 1 ; Acede ao proximo elemento da tabela de strings
	SUB R2, 1 ; Atualiza o contador de bytes do ecra
	JZ fim_linhalateral ; Se ja tiver pintado todas as linhas acaba
	SUB R3, 1 ; Atualiza o contador de elementos da tabela de strings
	JZ repor_elementos ; Caso ja tenha percorrido todos os elementos repoe o contador
	JMP escrever_linhalateral ; Corre o loop ate  a linha estar toda pintada
fim_linhalateral:
	POP R3 ; Devolve Registos
	POP R2
	POP R1
	POP R0
	RET ; Termina a rotina
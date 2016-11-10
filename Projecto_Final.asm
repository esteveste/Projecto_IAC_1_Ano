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
; *
; ***********************************************************************
;
; * Deteção da tecla premida no teclado e registo do seu valor na memória e, posteriormente, no ecrã de segmentos
; 
; ***********************************************************************
; * Constantes
; ***********************************************************************

adr_Tecla_Valor         EQU 100H	 ; Endereço de memória onde se guarda a tecla premida 	
linha	                EQU 8H       ; Posição do bit correspondente à linha a testar
local_Ecra_Segmentos	EQU 0A000H 	 ; Endereco do display de 7 segmentos
out_Teclado	            EQU 0C000H   ; Endereço do porto de escrita do teclado
in_Teclado		        EQU 0E000H   ; Endereço do porto de leitura do teclado
nao_pressionada         EQU 0        ; Valor da tecla nao premida
pressionada             EQU 1        ; Valor da tecla premida



; ***********************************************************************
; * Definir SP
; ***********************************************************************
PLACE 1000H
pilha:
	table 100H               ; Tabela para stack pointer
fim_Pilha:					 ; Etiqueta com o endereço final da pilha


; ***********************************************************************
; * Código
; ***********************************************************************

PLACE      0
inicializacao:		       ; Inicializações gerais
    
	mov  R9, 0             ; Contador coluna
	mov  R5, nao_pressionada 		; Vai verificar se a tecla ja foi premida
	mov  R6, 1             ; Vai verificar se display_Inativo/display_Tecla ja correu, para ser executado 1 unica vez
	mov  sp, fim_Pilha

definir_Linha:             ; Redifine a linha quando o shr chegar a 0
	mov  R1, linha         ; Valor maximo das linhas  
	mov  R5,nao_pressionada; Redefine se a tecla esta pressionada, para ser voltada a ser verificada

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
	mov  R5, nao_pressionada
	jmp  definir_Linha     ; Verificar se a tecla premida esta na proxima linha
	
display_Inativo:           ; Ecra mostra que nao ha tecla premida
	push R0
	push R9
	mov  R0, local_Ecra_Segmentos ; Volta ao endereço 0A000H
	mov  R9, 255           ; Corresponde ao valor FF no ecra
	movb [R0],R9           ; Escreve no local_Ecra_Segmentos
	pop  R9
	pop  R0
	mov  R6,0              ; O ciclo do ecra inativo ja foi corrido
	mov  R5,nao_pressionada; Sem tecla premida
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
	mov  R0, local_Ecra_Segmentos   ; Define endereço de escrita display (0A000H)
	movb [R0],R2           ; Escrever no display o valor da tecla
	pop  R2
	pop  R1
	pop  R0
	mov  R6,1			   ; Define um valor que representa que a tecla ja foi representada no ecra
	jmp  scan_Teclado      ; Volta a varrer o teclado


; ***********************************************************************

	
	
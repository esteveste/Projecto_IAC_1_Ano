; ***********************************************************************
; * Constantes
; ***********************************************************************

adr_Tecla_Valor         EQU 100H	 ; Endereço de memória onde se guarda a tecla premida 	
linha	                EQU 8H       ; Posição do bit correspondente à linha a testar
local_Ecra	EQU 8000H 	 ; Endereco do display de 7 segmentos


; ***********************************************************************
; * Definir SP
; ***********************************************************************
PLACE 1000H
pilha:
	table 100H               ; Tabela para stack pointer
fim_Pilha:					 ; Etiqueta com o endereço final da pilha


PLACE      0
inicializacao:		       
    
    mov R0, 32

	mov R3, 0 ; counter
	mov  sp, fim_Pilha

ciclo2:
	mov  R9, 170
	
	call ciclopar ;impar linhas
	call ciclopar
	call ciclopar
	call ciclopar
	mov  R9, 85
	
	call ciclopar ;par linhas
	call ciclopar
	call ciclopar
	call ciclopar
	sub R0,1
	jz tempo2
	jmp ciclo2

ciclo:
	mov  R9, 85
	
	call ciclopar ;impar linhas
	call ciclopar
	call ciclopar
	call ciclopar
	mov  R9, 170
	
	call ciclopar ;par linhas
	call ciclopar
	call ciclopar
	call ciclopar
	sub R0,1
	jz tempo1
	jmp ciclo

	
tempo1:
	mov R11, 255
	mov R0, 32

	mov R3, 0 ; counter
	jmp loop2
loop2:
	sub R11,1
	jz ciclo2
	jmp loop2
tempo2:
	mov R11, 255
	mov R0, 32

	mov R3, 0 ; counter
	jmp loop1
loop1:
	sub R11,1
	jz ciclo
	jmp loop1
ciclopar:
	call display
	add R3,1
	ret
	
fim:
	jmp fim
display:           
	push R0
	mov  R0, local_Ecra
	add  R0, R3
	;mov  R9, 170         ; Corresponde ao valor FF no ecra
	movb [R0],R9           ; Escreve no local_Ecra_Segmentos
	pop  R0
	ret
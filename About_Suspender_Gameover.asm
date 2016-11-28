; *********************************************************************************
; * Rotina Suspender
; * R1 sera a tecla recebida por esperar tecla, como nao sabia qual seria o registo da tecla usei R1
; *********************************************************************************
	
suspender:
    PUSH R1 ; Guarda R1
    PUSH R2 ; Guarda R2
	;DI1 ; Desliga as interrupcoes
    ;DI0
    DI
    CALL inverte_ecra ; Chama a rotina de inverter o ecra para diferenciar do estado normal de jogo
ciclo_suspender:
    CALL  esperar_tecla ; Chama a rotina do teclado e devolve em R1 a tecla pressionada
    MOV   R2, tecla_suspender ; Atualiza R2 com o valor da tecla de suspender
    CMP   R1, R2 ; Verifica se a tecla pressionada e a tecla de suspender
    JNZ   ciclo_suspender ; Caso nao seja a tecla de suspender, repete ate receber a tecla de suspender para tirar do modo de pausa
    MOV   R2, 3 ; Atualiza R2 com o novo estado (estado jogar)
    MOV   R1, estado_ctrl
    MOVB  [R1], R2 ; Atualiza o estado_programa com o novo estado
	;EI1 ; Liga as interrupcoes
    ;EI0
    EI
    CALL inverte_ecra
    POP R2 ; Devolve R2
    POP R1 ; Devolve R1
    RET ; Termina a rotina
	
; *********************************************************************************
; * Rotina About
; * R1 sera a tecla recebida por esperar tecla, como nao sabia qual seria o registo da tecla usei R1
; *********************************************************************************

about:
	PUSH R0 ; Guarda R0
	PUSH R1 ; Guarda R1
	PUSH R2 ; Guarda R2
	MOV R0, ecra_about ; Guarda em R0 a tabela de strings ecra_about
	CALL ecra_escreve ; Chama a rotina para escrever no ecra a tabela de strings ecra_about
about_loop:
	CALL esperar_tecla ; Chama a rotina que devolve o valor de uma tecla premida
	MOV R2, tecla_terminar ; Atualiza R2 com o valor da tecla terminar
	CMP R1, R2 ; Verifica se a tecla e' a tecla de terminar
	JNZ verif_jogar ; Se nao for verifica se e a de jogar
	MOV R2, 5 ; Atualiza R2 com o valor do novo estado (estado terminar)
	JMP terminar ; Termina caso seja a tecla terminar
verif_jogar:
	MOV R2, tecla_jogar ; Atualiza R2 com o valor da tecla jogar
	CMP R1, R2 ; Verifica se a tecla e' a tecla de jogar
	JNZ about_loop ; Se nao for corre o loop outra vez
	MOV R2, 3 ; Atualiza R2 com o valor do novo estado (estado jogar)
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOV [R1], R2 ; Atualiza o estado programa com o valor do estado atual (estado jogar)
	JMP sair_about
terminar:
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOV [R1], R2 ; Atualiza o estado programa com o valor do estado atual (estado terminar)
sair_about:
	POP R2 ; Devolve R2
	POP R1 ; Devolve R1
	POP R0 ; Devolve R0
	RET ; Termina a rotina
	
; *********************************************************************************
; * Rotina Game Over
; * R1 sera a tecla recebida por esperar tecla, como nao sabia qual seria o registo da tecla usei R1
; *********************************************************************************

gameover:
	PUSH R0 ; Guarda R0
	PUSH R1 ; Guarda R1
	PUSH R2 ; Guarda R2
	CALL inver_ecra ; Chama a rotina para inverter o ecra
	DI1 ; Desliga as interrupcoes
    DI0
    DI
	MOV R0, ecra_fim ; Guarda em R0 a tabela de strings ecra_fim
	CALL ecra_escreve ; Chama a rotina para escrever no ecra a tabela de strings ecra_fim
gameover_loop:
	CALL esperar_tecla ; Chama a rotina que devolve o valor de uma tecla
	MOV R2, tecla_jogar ; Atualiza R2 com o valor da tecla jogar
	CMP R1, R2 ; Verifica se a tecla e' a de jogar
	JNZ verif_about ; Se nao for verifica se e' a de about
	MOV R2, 3 ; Atualiza R2 com o estado novo (estado jogar)
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOV [R1], R2 ; Atualiza o estado programa com o valor do estado atual (estado jogar)
	JMP sair_gameover
verif_about:
	MOV R2, tecla_about ; Atualiza R2 com o valor da tecla about
	CMP R1, R2 ; Verifica se e' a tecla about
	JNZ gameover_loop ; Volta a correr o loop gameover
	MOV R2, 6 ; Atualiza R2 com o estado novo (estado about)
	MOV R1, estado_programa ; Atualiza R1 com o endereco do estado programa
	MOV [R1], R2 ; Atualiza o estado programa com o valor do estado atual (estado about)
sair_gameover:
	POP R2 ; Devolve R2
	POP R1 ; Devolve R1
	POP R0 ; Devolve R0
	RET ; Termina a rotina
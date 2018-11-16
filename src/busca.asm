%include "asm_io.inc"

segment .data ;variaveis inicializadas

segment .bss ;variaveis nao inicializadas

qtd_pilares resd 1
qtd_pontes resd 1
caminho resd 300 ; quantidade maxima de pontes * 3
custo resd 52  ; quantidade maxima de pilares + 2

segment .text ;codigo do programa
	global  _asm_main
	
_asm_main:

	call read_int
	mov [qtd_pilares], eax
	mov ebx, 2
	add [qtd_pilares], ebx ; adicionando pilar inicial e final

	call read_int
	mov [qtd_pontes], eax 

	mov ecx, [qtd_pontes]
	imul ecx, 3
	mov ebx, 0
	rep1:
		call read_int
		mov [caminho+ebx], eax
		add ebx, 4
	loop rep1

	mov ecx, [qtd_pilares]
	mov ebx, 0
	rep2:
		mov eax, 3000000
		mov [custo+ebx], eax
		add ebx, 4
	loop rep2

	mov ebx, 0
	mov [custo], ebx ; custo do primeiro pilar é sempre zero.

;	debug1:
;		mov ecx, [qtd_pontes]
;		imul ecx, 3
;		mov ebx, 0
;		rep3:
;			mov eax, [caminho+ebx]
;			call print_int
;			call print_nl
;			add ebx, 4
;		loop rep3
;
;	call print_nl
;
;	debug2:
;		mov ecx, [qtd_pilares]
;		mov ebx, 0
;		rep4:
;			mov eax, [custo+ebx]
;			call print_int
;			call print_nl
;			add ebx, 4
;		loop rep4

	

	leave                     
	ret
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

	; multiplico qtd de pontes por 3 para abarcar todas as informacoes em um vetor
	mov ecx, [qtd_pontes]
	imul ecx, 3
	mov ebx, 0
	rep1:
		call read_int
		mov [caminho+ebx], eax
		add ebx, 4
	loop rep1

	; vetor responsavel por guardar os custos de cada no
	mov ecx, [qtd_pilares]
	mov ebx, 0
	rep2:
		mov eax, 3000000 ; valor qualquer acima do limite
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

	mov ecx, [qtd_pilares]
	mov edx, 0 ; edx = k = 0
	
	l1:
		push ecx
		mov ecx, [qtd_pontes]
		imul ecx, 3
		mov ebx, 0 ; ebx = i = 0
		
		l2:
			push ecx
			push edx
			cmp [caminho+ebx], edx ; compara caminho[i] com k
			jne fim_loop
			
			mov eax, [caminho+ebx] ; eax = caminho[i]
			imul eax, 4
			mov eax, [custo+eax] ; eax = custo[caminho[i]]

			mov ecx, ebx ; ecx = i
			add ecx, 8 ; ecx = i+2
			add eax, [caminho+ecx] ; eax = custo[caminho[i]] + caminho[i+2]

			mov ecx, ebx ; ecx = i
			add ecx, 4 ; ecx = i+1
			mov ecx, [caminho+ecx] ; ecx = caminho[i+1]
			imul ecx, 4
			mov ecx, [custo+ecx] ; ecx = custo[caminho[i+1]]

			cmp eax, ecx ; compara eax e ecx
			jge fim_loop ; se for maior ou igual, pula para fim do loop
			mov ecx, eax ; custo[caminho[i+1]] = custo[caminho[i]] + caminho[i+2]
			mov eax, ebx ; eax = i
			add eax, 4 ; eax = i+1
			mov eax, [caminho+eax] ; eax = caminho[i+1]
			imul eax, 4
			mov [custo+eax], ecx ; joga na memoria o valor em ecx.
		
			fim_loop:
			
			add ebx, 12 ; acrescento 12, pois pulo o ebx de 3 em 3
			pop edx
			pop ecx
			sub ecx, 2 ; diminuo 2, pois decremento ecx de 3 em 3 (ainda tem o dec do loop)
			
		loop l2

		inc edx ; k++
		pop ecx
	loop l1

	mov ebx, [qtd_pilares]
	imul ebx, 4 
	sub ebx, 4 ; diminuo 4 por conta do acesso das posicoes (0 ate n-1)
	mov eax, [custo+ebx] ; imprimo o no do ultimo pilar
	
	call print_int
	call print_nl

	leave                     
	ret
global	ft_strcpy

;Recuerda... el primer argumento viene en rdi y el segundo en rsi.
ft_strcpy:

; Pre-subrutine
	MOV		rax, rdi
	PUSH 	rbx				; Como usamos el rbx , le hacemos push para restaurarlo despues.
	MOV		rbx, -1

; Subrutine.
	INC		rbx
while:
	CMP		BYTE [rsi + rbx], 0 		;Accedemos a la posicion de memoria que marca un registro, incluyendolo en corchetes. El byte es el cast
	JE		return
;	MOV		BYTE[rdi + rbx], BYTE[rsi + rbx]		;No se permite los movimientos de memoria a memoria.
;	MOV		r8b, BYTE[rsi + rbx]
	;Copiamos los strings, pero  no se permite mover de memoria a memoria por lo que usamos rcx intermedio.
	MOV		cl, BYTE [rsi + rbx]						;cl son los 8 bits de menor peso del registro rcx
	MOV		BYTE [rdi + rbx], cl
	JMP		while
return:
	MOV		BYTE [rdi + rbx], 0
; POST-subrutine
	POP 	rbx
	RET
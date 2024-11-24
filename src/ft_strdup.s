default rel

extern __errno_location
extern malloc
extern ft_strlen
extern ft_strcpy

global	ft_strdup

section		.text

ft_strdup:

; Pre-subrutina
; Subrutina 
	; Primero obtenemos la longitud del string con ft_strlen
	CALL	[rel ft_strlen wrt ..got]
	MOV		rcx, rax
	; Reservamos memoria
	PUSH	rdi
	MOV		rdi, rcx
	INC		rdi							;Aumentamos en 1 para el espacio de \0
	CALL	[rel malloc wrt ..got]
	POP		rdi
	TEST	rax, rax					;Revisamos si es valor negativo.
	JS		return						;En caso que devuelvan NULL, el propio malloc habrá puesto el errno.
	; Llamamos al ft_strcpy
	PUSH	rdi
	MOV		rsi, rdi
	MOV		rdi, rax					;Preparamos los argumentos...
	CALL	[rel ft_strcpy wrt ..got]
	POP		rdi
; Post-subrutina

return:
	RET
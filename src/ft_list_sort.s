; Firma
; void ft_list_sort(t_list **begin_list, int (*cmp)());

; Ejemplo....
;void	ft_list_sort(t_list **begin_list, int (*cmp)())
;{
;	t_list	*ptr;
;	t_list	*ptr2;
;	t_list	*next;
;
;	ptr = *begin_list;
;	while (ptr)
;	{
;		ptr2 = *begin_list;
;		while (ptr2->next)
;		{
;			if ((*cmp)(ptr2->data, ptr2->next->data) > 0)
;			{
;				next = ptr2->data;
;				ptr2->data = ptr2->next->data;
;				ptr2->next->data = next;
;			}
;			ptr2 = ptr2->next;
;		}
;		ptr = ptr->next;
;	}
;}
;NOTA: 
;	strcmp por ejemplo devuelve 1 si str1 > str2
;	strcmp por ejemplo devuelve 0 si str1 == str2
;	strcmp por ejemplo devuelve -1 si str1 < str2
default rel


section .text
;Recuerda, 
;	RDI 1r arg  =>  t_list **begin_list
;	RSI 2o arg  =>  int (*cmp)()
;	RCX 3r arg
;	RDX 4o arg
;	RAX retorno.
global  ft_list_sort

swap:
;	MOV	rcx, rdi
;	MOV	rdi, [rsi]
;	MOV	rsi, [rcx]
	MOV	rcx, [r9 + 8]
	MOV	rax, [r9]
	MOV	[r9], rcx
	MOV	[r9 + 8], rax
	JMP	next_ptr2

ft_list_sort:
; Pre-subrutina
	MOV r8, [rdi]
; Subrutina
	; Hago una iteracion por nodo, en cada iteracion obtenemos el más grande al final.
loop:   CMP	r8, 0
	JE	return
	MOV	r9, r8 ; Obtengo la primer aposicion para ptr2.
loop_list:
	; Recorremos el bucle hasta el final 
	CMP	QWORD [r9 + 8], 0
	JE	next_ptr
	; Hacemos la comparacion del nodo actual con el siguiente.
	; Como somos callers, guardamos los registros rdi, rsi en la pila
	PUSH	rsi
	PUSH	rdi
	PUSH	rcx
	PUSH	r8
	PUSH	r9
	MOV	rcx, rsi
	MOV	rdi, [r9]
	MOV	rsi, [r9 + 8]
	MOV	rax, 0
;	CALL	rcx
	POP	r9
	POP	r8
	POP	rcx
	POP	rdi
	POP	rsi
	; Fin de la llamada
	CMP	rax, 0
	JG	swap
next_ptr2:
	MOV	r9, [r9 + 8] ; ptr2 = ptr2->next;
	JMP	loop_list
next_ptr:
	; Actualizamos el puntero de esa posicion.
	MOV	r8, [r8 + 8] ; Equivale a node = node->next
	JMP	loop

; Post-subrutina
return:
    RET
includelib kernel32.lib

	extrn __imp_GetStdHandle:proc
	extrn __imp_WriteFile:proc

	.CODE
hwStr	byte	"Hello World!"
hwLen	=	$-hwStr

main	PROC

;On entry, stack is aligned at 8 mod 16.
;Setting aside 8 bytes for "bytesWritten" 
;ensures that calls in main have their stack aligned to 16 Bytes (8mod 16 inside function)
	lea rbx, hwStr
	sub rsp, 8
	mov rdi, rsp	; Hold # of bytes written here
; Note: must set aside 32 bytes (20h) for shadow registers 
;for parameters (just do this once for all funcions)
;Also, WriteFile has a 5th argument (which is NULL)
;so we must set aside 8bytes to hold that pointer (and initialize it to zero). 
;Finally, the stack must always be 16-byte-ligned, 
;so reserve another 8 bytes of storage to ensure this
; Shadow storage for args (always 30h bytes)
	sub rsp, 030h

; Handle = GetStdHandle(-11);
; Single argument passed in ECX
; Handle returned in RAX

	mov rcx, -11	; STD_OUTPUT
	call qword ptr __imp_GetStdHandle

; WriteFile (handle, "hello world!", 12, &bytesWritten, NULL);
; Zero out (set to NULL) "LPOverlapped" Argument

	mov qword ptr [rsp + 4 * 8], 0 ;5th argument on stack
	
	mov r9, rdi	;Address of "bytesWritten" in R9
	mov r8d, hwLen	;Length of string to write in R8D
	lea rdx,hwStr	;Ptr to string data in RDX
	mov rcx,rax
	call qword ptr __imp_WriteFile
	add rsp, 38h
	ret
main	ENDP
	END

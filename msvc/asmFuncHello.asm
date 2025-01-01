includelib kernel32.lib
	extrn __imp_GetStdHandle:proc
	extrn __imp_WriteFile:proc

	.data
u8 	byte -1
hwStr 	byte "Hello World!"
hwLen	= $-hwStr

	.CODE
	option casemap:none
	public asmFunc

asmFunc PROC
	lea rbx,hwStr sub rsp,8
	mov rdi,rsp
	sub rsp, 030h
	mov rcx, -11
	call qword ptr __imp_GetStdHandle
	mov qword ptr [rsp + 4 * 8],0
	mov r9, rdi
	mov r8d, hwLen
	lea rdx,hwStr
	mov rcx, rax
	call qword ptr __imp_WriteFile
	add rsp, 38h
	ret
asmFunc ENDP
	END

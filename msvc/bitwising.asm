	option casemap:none
nl = 10 ; ascii for new line

	.data
leftOp		dword	0f0f0f0fh
rightOp1	dword	0f0f0f0fh
rightOp2	dword	12345678h

titleStr	byte	'bitwising',0 ; Hardcoded

fmtStr1		byte	"%lx AND %lx = %lx",nl,0
fmtStr2		byte	"%lx OR  %lx = %lx",nl,0
fmtStr3		byte	"%lx XOR %lx = %lx",nl,0
fmtStr4		byte	"    NOT %lx = %lx",nl,0

	.code
	externdef printf:proc 	; Define printf as a external process

	public getTitle 	; public allows to be called from outside
getTitle proc
	lea rax, titleStr
	ret
getTitle endp

	public asmMain

asmMain proc
	sub rsp, 56

	;AND Operation Demo
	lea rcx, fmtStr1
	mov edx, leftOp
	mov r8d, rightOp1
	mov r9d, edx
	and r9d, r8d
	call printf

	lea rcx, fmtStr1
	mov edx, leftOp
	mov r8d, rightOp1
	mov r9d, edx
	and r9d, r8d
	call printf

	add rsp, 56
	ret
asmMain endproc
	end


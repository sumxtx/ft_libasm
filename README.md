# 43_libasm
Implementacion del proyecto  libasm de Badalona 43

NOTAS:

La caller convention son unas reglas que se pueden encontrar aqui:
	https://aaronbloomfield.github.io/pdr/book/x86-64bit-ccc-chapter.pdf
	Se dividen en dos partes, las que han de cumplir el que llama las funciones y las que  ha de cumplir el que escribe la funcion.

Chuleta de instrucciones
	https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf

Chuleta de callee-save y caller-save instructions.
	https://en.wikipedia.org/wiki/X86_calling_conventions
	http://liujunming.top/2022/01/11/What-is-callee-saved-registers/

SysCalls
	https://www.tutorialspoint.com/assembly_programming/assembly_system_calls.htm
	https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
	https://lsi.vc.ehu.eus/pablogn/docencia/ISO/2%20Llamadas%20al%20Sistema,%20Kernel/X86%20Linux%20Syscall.pdf
	https://filippo.io/linux-syscall-table/
	
https://harm-smits.github.io/42docs/projects/libasm

Multiplicacion
	http://www.c-jump.com/CIS77/MLabs/M11arithmetic/M11_0070_imul_example.htm

	
GOT: Global Offset Tables, tabla 
	https://en.wikipedia.org/wiki/Global_Offset_Table
	Tabla donde mapea los símbolos a sus memorias de memoria absolutas.
# Index
- MASM/MSVC (Microsoft Windows Assembler / MicroSoft Visual Code) Conventions
- Linux/Unix Conventions
    - Registers
        - General Purpose Registers
        - Segment Registers
    - Flags
    - Hello World
    - Call Conventions
        - C Caller Convention
        - Passing Parameters to subroutine
    - Variables
        - Notation for Defining Variables
        - Declaring an Initializing Constant Data
        - Declaring an Initializing Variable Data
        - Reserving Bytes in .bss Section
    - Sections Offsets
    - Syscalls
    - Reversing and Debugging
    - Further Reading
        - x64_CheatSheet
        - 42Docs
        - Calling Conventions 
        - Callee Saved Registers

## Registers

### General Purpose Registers
These registers may be used for general purpose. Although some of them have special meaning to be aware of. As the RSP for example, in case of being overwriten we lost acces to the Stack.
|Register|Usage|
|:-----:|:-------|
| RAX   | First Parameter of calls, Return Values...  |
| RBX   |   |
| RCX   | Counter variable values, ex: indexes  |
| RDX   |   |
| RSI   | Source string index  |
| RDI   | Source destination index  |
| RSP   | Stack Pointer  |
| RBP   | Stack Bottom Pointer  |
| R8/R15| Store temporary values, function parameters, local variables...  |
| RIP   | Instruction pointer, the next instruction to be executed  |

### Segment Registers
> Hold pointers to [Memory Segmentation](https://en.wikipedia.org/wiki/Memory_segmentation) areas during execution. [How are segment register used](https://reverseengineering.stackexchange.com/questions/2006/how-are-the-segment-registers-fs-gs-cs-ss-ds-es-used-in-linux)

|Register|Usage|
|:-----:|:-------|
| CS    | Code segment, Locate the code segment|
| SS    | Stack segment, Location of the stack segment|
| DS    | Data segment, Location of data variables|
| ES    | Extra segment, Often used as an additional data segment for certain instructions, particularly for strings operations as MOVS LODS (legacy support)|
| FS    | Often used as Thread-Local Storage, or other operating system specific structures |
| GS    | Often also used to refernce per-thread data |

## Flags
### CPU Flags
> ;;TODO

## Hello World
### Coding in Assembly
```asm
;; Hello World in x64-Assembly
; file Hello.asm
section .data
hello_str: db 'Hello World!',10,0

section .text
global _start
_start:
                           ;cat /usr/include/asm/unistd_64.h | grep write
    mov rax, 1             ;move system call number in RAX register

    mov rdi, 1             ;move first parameter of write syscall, STDOUT
    lea rsi,[hello_str]    ;move second paremeter of write syscall, hello_str
    mov rdx, 13            ;move third parameter of write syscall, length

    syscall                ;;Execute the system call

    mov rax, 60            ;/unistd_64.h , exit
    mov rdi, 0             ;return value 

    syscall
```
```bash 
nasm -f elf64 Hello.asm
ld Hello.o -o Hello
```
## Call Conventions
### C caller convention 

To allow separate programmers to share code and develop libraries for use by many programs, and to simplify the use of subroutines in general, programmers typically adopt a [common calling convention](https://aaronbloomfield.github.io/pdr/book/x86-64bit-ccc-chapter.pdf).

- The Caller
Tends to save the content of certain register to designated caller-saved register like R10, R11, and any register that parameters are put into. If the content need to be preversed across subroutine calls, push them to stack. Before call a subroutine places the return address on top of the parameters on the stack, and branches to the subroutine. After return from subroutine remove parameters from stack, if any, restoring stack to its previous state. Caller expected the return value of the subroutine in register RAX. Restore the contents of caller-saved registers (r10, r11) by popping them off the stack

- Callee subroutine
> ;;TODO


### Passing parameter to the subroutine
Order: rdi, rsi, rdx, rcx, r8, r9
If More than six parameter: Push to stack in reverse order the 7th will be the lowest, as stack is placed in reverse order

> EX1 - Calling with three parameters:
```asm 
    ; Call a function myFunc that takes three integer parameters
    ; First parameter is in rax
    ; Second parameter is constant 123
    ; Third parameter is in memory location var

    push rdi        ; ex: rdi is a parameter that needs saving to stack
    mov rdi, rax    ; put first parameter in rdi
    mov rsi, 123    ; put second parameter in rsi
    mov rdx, [var]  ; put third parameter in rdx

    call myFunc     ; call suborutine

    pop rdi         ; restore saved rdi

    ; return of myFunc is available in rax, if any

    ;;; Callee convention example

global myFunc
section .text
myFunc:
    ; Standard subroutine prologue
    sub rsp, 8  ; room for a 8-byte local var (result)
    push rbx    ; save callee-save registers
    push rbp    ; both will be used by myFunc

    ; Subroutine Body
    mov rax, rdi            ; param 1 to rax
    mov rbp, rsi            ; param 2 to rbp
    mov rbx, rdx            ; param 3 to rbx
    mov [rsp + 16], rbx     ; put rbx into local var
    add [rsp + 16], rbp     ; add rbp into local var
    mov rax, [rsp+16]       ; move contents of local var to rax
                            ; return value/final result

    ; Standard subroutine epilogue
    pop rbp         ; recover calee save registers in reverse order of push
    pop rbx         ; 
    add rsp, 8      ; deallocate local var
    ret 

```
```cpp
// C++ Equivalent code
#include <iostream>
using namespace std;

extern "C" int myFunc(int, int, int);
int main()
{
    int x = 3;
    cout << "myFunc () returned:" << myFunc(x,5,10) << endl;
    return (0);
}
```

> EX2 - Calling with more than six parameters 1/2 (not saving to stack before call):
```asm
section .text
    global _start

_start:
    ; Set up parameters, first six go to registers
    mov rdi, 10
    mov rsi, 20
    mov rdx, 30
    mov rcx, 40
    mov r8, 50
    mov r9, 60
    ; Set up the stack for the remaining parameters
    sub rsp, 16             ; Allocates space for 2 8-byte parameters
    mov qword [rsp], 70     ; Move the 7th parameter into the stack
    mov qword [rsp+8], 80   ; Move 8th parameter into the satck

    call function
    ;....

```
## Variables
### Notation for Defining Values
| Notation     | Format |
|--------------|-------------|
| Decimal      | 45d  |
| Hexadecimal  | 0xFF  |
|              | 0hA3  |
|              | $43     ; Cannot begin with Letter -> $FF = $0FF |
|              | 33FFh   ; Cannot begin with Letter -> FFh = 0FFh |
| Octal        | 103o  |
|              | 103q  |
|              | 0o103  |
|              | 0q103  |
| Binary       | 0b01001100  |
|              | 01101100b  |
| Characters   | 'A'  |
|              | "A"  |
|              | \`A\`  |
| Strings      | 'Hola' | 
|              |"Hola"  |
|              | \`Hola\` | 
|              |'H','o','l','a' | 
|              |'Hol','a'  |

### Declaring and Initializing Constant Data
> var_name equ Data
```asm
Mensaje1 equ 'Hola'
Msgeqiv1 equ 'Jo','ma'
```


### Declaring and Initializing Variable Data
- db : Data Byte (1 Byte)
> var_name: db Data 
```asm
var1: db 255;
var1h: db FF;
str1: db 'Hello',10     ;Insert Line Jump (Ascii 10) to the string
str2: db 'Hello',9      ;Insert Tab (Ascii 9) to the string
str3: db 73,111,108,97  ;Create the String Hello using Ascii(Characters)
str4: db `Hello\n`      ;With backtick, the escape notation is allowed
str5: db `\e[10,5H`     ;\e Escape(Asccii 27) Secuencia de control especial terminales Unix
                        ; in hex = \x1B
                        ; [ Parte de la secuencia de control ANSI, Indica que lo que sigue sera un comando de control para la terminal
                        ; controla la posicion del cursor fila10,columna5                        
vec1: db 23, 42, -1, 53, 14 ; vector composed by 5 values of byte type
```

- dw : Declaring Word (2 Bytes)
> var_name: dw Data
```asm
var2: dw 65535
var2h: dw 0FFFFh
vec2: dw 1000, 2000, -1000, 3000 ;vector composed of 4 words
```

- dd : Declaring a Double Word (4 Bytes)
> var_name: dd Data
``` asm
var4: dd 4294967295;
var4h: dd FFFFFFFFh;
```

- dq : Declaring a QuadWord (8 Bytes)
> var_name: dq Data
```asm
var8: dq 18446744073709551615;
var8h: dq FFFFFFFFFFFFFFFFh;
```

- times : Declaring a number of elements of type
> var_name: times nBytes db Data
```asm
Number: times 10 db 0
str6: times 4 db 'PILA'
str7: db 'PILAPILAPILAPILA' ; equal the above
```

- Using Constants to initialize variables
```asm
sizeVec equ 5;
indexVec: db sizeVec;
```


### Reserving Bytes in .bss section (Uninitialized Data)
- Reserving 5 bytes
> var_name: resb 5

- Reserving 5 words
> var_name: resw 5

- Reserving 5 double word
> var_name: resd 5

- Reserving 2 quad word
> var_name: resq 2

## Sections Offset 
- [GOT: Global Offset Tables](https://en.wikipedia.org/wiki/Global_Offset_Table)

## Syscalls

- [Assembly System Calls](https://www.tutorialspoint.com/assembly_programming/assembly_system_calls.htm)
- [Linux System Call Tables for X86_64](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
- [Linux Syscalls](https://lsi.vc.ehu.eus/pablogn/docencia/ISO/2%20Llamadas%20al%20Sistema,%20Kernel/X86%20Linux%20Syscall.pdf)
- [Linux Syscalls table](https://filippo.io/linux-syscall-table/)

## Reversing and Debugging
Getting some info on the binarie, elf dump, memory offsets, etc..
> man readelf
```
readelf -S binarie
```
> man objdump
```
objdump -D -M att binarie >> binarie_dump
```

- set gdb for disassemble as intel (ease syntax)
```
echo 'set disassemble intel' >> ~/.gdbinit
```

- starting gdb and some useful commands
```
gdb -q ./binarie
```
```
    info functions
    info registers
    info registers rsp rbp
    info variables
    info files
    info proc mappings
    x/15bx 0x402000 # display 15 bytes in hex format starting at memory 0x402000
    x/10wx 0x401000 # 10 words in hex format(4 bytes)
    x/10wd 0x401000 # 10 words in decimal format
    x/10s 0x601000  # print memory region as string
    
    disassemble functionName
    b _start
    display/$rax
    display/$rbx
    display/$rcx
    display/2i $rip
    del display 1 # delete the display 1 (display $rax)
    run
    ni
```
> passing gdb commands as script at start time
```
vim gdb_commands.txt
```
```
    display $rax
    display $rbx
    display $rcx
    display 2i $rip
    break main
    run
```
```
gdb -x gdb_commands.txt ./binarie
```
## Further Reading
####  x64_CheatSheet
- [Chuleta de instrucciones](https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf)

#### "42 Docs"
In quotes because 42 has no Docs really, it was made by another student. Kudos to him
- [Libasm "42Docs"](https://harm-smits.github.io/42docs/projects/libasm)

#### Calling Conventions 
[Calling Conventions](https://en.wikipedia.org/wiki/X86_calling_conventions) 

#### Callee Saved Registers
[Callee Saved registers](http://liujunming.top/2022/01/11/What-is-callee-saved-registers/)

#### Multiplication
- [Multiplicacion](http://www.c-jump.com/CIS77/MLabs/M11arithmetic/M11_0070_imul_example.htm)

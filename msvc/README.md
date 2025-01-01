#### build.bat
echo off
ml64 /nologo /c /Zi /cp %1.asm
cl /nologo /O2 /Zi /utf-8 /EHa /Fe%1.exe %2.cpp %1.obj



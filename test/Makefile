
CFLAGS = -Wall -Werror -Wextra

SRC_DIR = ./src
OBJ_DIR = ./obj
BIN_DIR = ./bin
INC_DIR = ./inc

LIBFTASM = ../bin/libasm.a

all:	${BIN_DIR}/test_strlen ${BIN_DIR}/test_strcpy

#Reglas strlen
${BIN_DIR}/test_strlen : ${OBJ_DIR}/test_strlen.o ${LIBFTASM} makedirs 
	cc ${CFLAGS} -o $@ $< ${LIBFTASM}

${OBJ_DIR}/test_strlen.o: ${SRC_DIR}/test_strlen.c Makefile
	cc ${CFLAGS} -I ${INC_DIR} -o $@ -c $<

#Reglas strcpy
${BIN_DIR}/test_strcpy : ${OBJ_DIR}/test_strcpy.o ${LIBFTASM} makedirs 
	cc ${CFLAGS} -o $@ $< ${LIBFTASM}

${OBJ_DIR}/test_strcpy.o: ${SRC_DIR}/test_strcpy.c Makefile
	cc ${CFLAGS} -I ${INC_DIR} -o $@ -c $<


makedirs: ${OBJ_DIR} ${BIN_DIR}

${LIBFTASM}:
	make --no-print-directory all -C ../

${OBJ_DIR}:
	@mkdir -p ${OBJ_DIR}

${BIN_DIR}:
	@mkdir -p ${BIN_DIR}

clean:
	@rm -rf ${OBJ_DIR}

fclean: clean
	@rm -rf ${BIN_DIR}

re: fclean all

.PHONY: all clean fclean re makedirs
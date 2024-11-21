
CFLAGS = -Wall -Werror -Wextra -MP -MMD

SRC_DIR = ./src
OBJ_DIR = ./obj
BIN_DIR = ./bin
INC_DIR = ./inc

SRC = 	test_strcpy.c	\
		text_strcmp.c	\
		test_strlen.c	\
		test_write.c

DEPS = $(patsubst %.c, ${OBJ_DIR}/%.d, ${SRC})

LIBASM = ../bin/libasm.a

FOLDERS = ${OBJ_DIR} ${BIN_DIR}

all: 	${FOLDERS}	\
		${BIN_DIR}/test_strlen	\
		${BIN_DIR}/test_strcpy	\
		${BIN_DIR}/test_strcmp	\
		${BIN_DIR}/test_write

#Reglas strlen
${BIN_DIR}/test_strlen :  ${OBJ_DIR}/test_strlen.o ${LIBASM}
	cc ${CFLAGS} -z execstack -o $@ ${OBJ_DIR}/test_strlen.o ${LIBASM}

${OBJ_DIR}/test_strlen.o: ${SRC_DIR}/test_strlen.c Makefile
	cc ${CFLAGS} -I ${INC_DIR} -o $@ -c $<

#Reglas strcpy
${BIN_DIR}/test_strcpy : ${OBJ_DIR}/test_strcpy.o ${LIBASM}
	cc ${CFLAGS} -z execstack -o $@ ${OBJ_DIR}/test_strcpy.o ${LIBASM}

${OBJ_DIR}/test_strcpy.o: ${SRC_DIR}/test_strcpy.c Makefile
	cc ${CFLAGS} -I ${INC_DIR} -o $@ -c $<

#Reglas strcmp
${BIN_DIR}/test_strcmp : ${OBJ_DIR}/test_strcmp.o ${LIBASM}
	cc ${CFLAGS} -z execstack -o $@ ${OBJ_DIR}/test_strcmp.o ${LIBASM}

${OBJ_DIR}/test_strcmp.o: ${SRC_DIR}/test_strcmp.c Makefile
	cc ${CFLAGS} -I ${INC_DIR} -o $@ -c $<

#Reglas write
${BIN_DIR}/test_write : ${OBJ_DIR}/test_write.o ${LIBASM}
	cc ${CFLAGS} -z execstack -no-pie -o $@ ${OBJ_DIR}/test_write.o ${LIBASM}

${OBJ_DIR}/test_write.o: ${SRC_DIR}/test_write.c Makefile
	cc ${CFLAGS} -I ${INC_DIR}  -o $@ -c $<


${LIBASM}:
	make --no-print-directory all -C ../

${OBJ_DIR}:
	mkdir -p ${OBJ_DIR}

${BIN_DIR}:
	mkdir -p ${BIN_DIR}

clean:
	@rm -rf ${OBJ_DIR}

fclean: clean
	@rm -rf ${BIN_DIR}

re: fclean all

-include ${DEPS}

.PHONY: all clean fclean re
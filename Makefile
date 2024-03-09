##
## EPITECH PROJECT, 2024
## B-FUN-400-PAR-4-1-imageCompressor-thibaud.cathala
## File description:
## Makefile
##

NAME		=	imageCompressor

BIN_PATH	:=	$(shell stack path --allow-different-user --local-install-root --resolver=lts-20.11)

SRC			:=	$(shell find src/ -name "*.hs") \
				$(shell find app/ -name "*.hs")

NAME_TEST 	= 	unit_tests

$(NAME):
	stack build --resolver=lts-20.11 --allow-different-user
	cp $(BIN_PATH)/bin/$(NAME)-exe $(NAME)

all: $(NAME)

clean:
	stack clean --resolver=lts-20.11 --allow-different-user

fclean: clean
	rm -f $(NAME)

re: fclean all

unit_tests:

tests_run:
	stack test --resolver=lts-20.11

# profiling_imageCompressor -n 2 -l 0.8 -f 100_000_color.txt +RTS -p
# cat profiling_imageCompressor.prof
profiling: fclean
	stack install --profile --resolver=lts-20.11 --allow-different-user --local-bin-path .
	cp $(NAME)-exe profiling_$(NAME)

.PHONY: all clean fclean re unit_tests tests_run profiling

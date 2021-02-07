#!/usr/bin/env bash
#
# data_extraction_git.sh - Recupera nome dos projetos do github
#
# Site:       https://github.com/deyvissoneduardo
# Autor:      Deyvisson Eduardo
# Manutenção: Deyvisson Eduardo
#
# ------------------------------------------------------------------------ #
#  Este programa irá extair com expressão regular o nome dos projetos do
#  perfil do github
#
#  Exemplos:
#      $ ./data_extraction_git.sh 
#      Neste exemplo o script listara todos projetos
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 07/02/2021, Deyvisson:
#       - Início do programa
#       - Conta com a funcionalidade de expressão relugar
#       - Formatado textos de saida
#       - Criado Menu
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.8.0
# ------------------------------------------------------------------------ #
#
# ------------------------------- VARIÁVEIS ----------------------------------------- #
MESSAGE_HELP="
    $(basename $0) [OPÇÕES]
    -h   - Menu de ajuda
    -v   - Versão
    -s   - Ordena em ordem alfabetica
    -*   - Sem Parametro faz busca completa
"
VERSION="v1.1"

NEGRITO="\033[1m"
COLOR_BLUE="\033[34;1m"
COLOR_RED="\033[31;1m"

ARCHIVE_TITLES="projects.txt"
ORDENA=$(lynx -source https://github.com/deyvissoneduardo?tab=repositories | grep codeRepository | sed 's/<a.*do\///;s/".*//' | sort)
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
# lynx instalado 
[ ! -x "$(which lynx)" ] && sudo apt install lynx
# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #
Filter(){
    while read -r titles
    do
        echo -e "${COLOR_BLUE}Projeto: ${titles}"
    done < "$ARCHIVE_TITLES"
}
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
lynx -source https://github.com/deyvissoneduardo?tab=repositories | grep codeRepository | sed 's/<a.*do\///;s/".*//' > projects.txt

case "$1" in 
    -h) echo -e "${NEGRITO}$MESSAGE_HELP" && exit 0 ;;
    -v) echo -e "${NEGRITO}$VERSION" && exit 0 ;;
    -s) echo "$ORDENA\n" ;;
    *)  echo "${Filter}" ;;
esac
Filter
# ------------------------------------------------------------------------ #

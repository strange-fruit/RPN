#!/bin/bash
### MIT LICENCE from https://choosealicense.com/licenses/mit/#
#School project

#banner
figlet "GIT USER :) "


args=@$

#Usage function triggered when there's an error in user input
usage(){
    echo "[+]-----------------------------------[+]"q
    echo -e "   Operators : +, -, *, /, %, ^\n"
	echo -e "   Or : add, sub, mul, div, modulo, power, \n"
    echo -e "[+]-----------------------------------[+]\n"
    echo -e "Commands : help, dump, drop, exit, swap, dup, clear\n"
    echo -e "Usage: bash rpn.sh\n"
    echo -e "[+] >>> 25\n"
    echo -e "[+] >>> 60\n"
    echo -e "[+] >>> swap\n"
    echo -e "[+] >>> dump\n"
    echo -e "[+] >>> 60\n"
    echo -e "[+] >>> 25\n"
	echo -e "help, print usage \n"
	echo -e "dump, print the stack on STDOUT \n"
	echo -e "drop|clear, clear the stack \n"
	echo -e "exit, exit the program \n"
	echo -e "swap, swap the two last entry in the stack \n"
	echo -e "dup, duplicate the last entry in the stack \n"
}


#clear stack. Reset it to 0
clear_stack(){
    stack=()
}


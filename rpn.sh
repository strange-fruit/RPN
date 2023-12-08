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


add(){
	#local variable
	#float proof with bc utility
	result=$(bc -l <<< "$1 + $2")
	echo "$result"
}

substract(){
	result=$(bc -l <<< "$1 - $2")
	echo "$result"
}

multiply(){
	result=$(bc -l <<< "$1 * $2")
	echo "$result"
}

divide(){
	result=$(bc -l <<< "$1 / $2")
	echo "$result"
}

modulo(){
    result=$(bc -l <<< "$1 % $2")
    echo "$result"
}

power(){
    result=$(bc -l <<< "$1 ^ $2")
    echo "$result"
}

#swap the last two entry. N-2 become N-1 and N-1 become N-2
swap(){	
	#variable intermediaire
	last=("${stack[-1]}")
	stack[-1]="${stack[-2]}"
	stack[-2]="${last[0]}"
}

#add all the element in the stack and push it 
sum(){
	local somme=0
	#for all the elements in the stack
	for element in "${stack[@]}";do
		somme=$( ( bc -l <<< "$somme + $element"))
	#add each elements
	done
	#push sum on the stack
  	stack=("$somme")
}

#stack declaration
stack=()

#usage when ./rpn.sh --help
case $args in
	"-h"|"--help")
	usage
	;;
esac


while true; do

	#takes user input. -e for history feature. -p for [+] >>>. -r for backslash as a part of the line, usage comes from history features
	read -e -r -p "[+] >>> " input

	

	case "$input" in
	"+"|"add")
	#if stack >= 2 elements
		if [ ${#stack[@]} -ge 2 ]; then
			#last operand before + sign
			operand1="${stack[-1]}"
			operand2="${stack[-2]}"

			#delete last two entry in the stack
			# :0 means slicing slicing. Recreates the stack at the index 0. Deleting last two elements.
			#${#stack[@]}-2 means delete last two elements
			stack=("${stack[@]:0:(${#stack[@]}-2)}")

			#add function use
			result=$(add "$operand1" "$operand2")
				stack+=("$result")

		else
				echo "Error : Insufficient operands for addition"
		fi

   	#sum all the elements in the stack and push it to the stack
	;;
    "q"|"quit"|"exit")
		echo -e "Exiting..........\n"
		figlet "BYEBYE"
		exit 0
    ;;
    "sum"|"somme")
    	sum
	;;
	#stack dump in stdout
    "dump"|"d"|"stack")
		#for each elements in the stack
		for item in "${stack[@]}"; do
				echo "$item"
		done
    ;;
    "clear"|"drop")
		clear_stack
	;;
    "swap")
	    swap
	;;
		
    #duplicate the stack
	"dup")
		#check if the stack has at least one elements
		if [ ${#stack[@]} -ge 1 ]; then
			
			stack+=("${stack[-1]}")

		else
			echo "Error : Insufficient operands for duplicate"
		fi
		;;

		#default
		*)
		#STDERR
		#rregex negative number and float
		if [[ "$input" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
			stack+=("$input")
		else
				echo -e "Error : Invalid input. Not an integer, float or a sign\n"
				usage
			fi
        ;;
	esac
done
#!/bin/bash
### MIT LICENCE from https://choosealicense.com/licenses/mit/#
#School project

#banner
figlet "GIT USER :)"

#Color declaration
BRed='\033[1;31m'          # Red
BYellow='\033[1;33m'       # Yellow
BPurple='\033[1;35m'       # Purple
BCyan='\033[1;36m'         # Cyan
NC='\033[0m' # No Color

#Usage function triggered when there's an error in user input
usage(){
    echo -e "${BRed}[+]-----------------------------------[+]${NC}"
    echo -e "   Operators : +, -, *, /, %, ^\n"
	echo -e "   Or : add, sub, mul, div, modulo, power\n"
    echo -e "${BRed}[+]-----------------------------------[+]${NC}\n"
    echo -e "Commands : help, dump, drop, exit, swap, dup, clear\n"
    echo -e "Usage: ${BYellow}bash rpn.sh${NC}\n"
    echo -e "[+] >>> 25\n"
    echo -e "[+] >>> 60\n"
    echo -e "[+] >>> swap\n"
    echo -e "[+] >>> dump\n"
    echo -e "${BCyan}60${NC}\n"
    echo -e "${BCyan}25${NC} \n"
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




while true; do

	#takes user input. -e for history feature. -p for [+] >>>. -r for backslash as a part of the line, usage comes from history features
	read -e -r -p "[+] >>> " input

	#arrow up and down feature 
	#can't do arrow up when the last entry starts with '-' (minus)
	#can't find solve but it adds the number to the stack except it gives me an error. STDERR to /dev/null for cool usage
	history -s "$input" 2> /dev/null

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
				echo -e "${BRed}Error : Insufficient operands for addition${NC}"
		fi

	;;
    "-"|"sub"|"substract")
		if [ ${#stack[@]} -ge 2 ]; then
			operand1="${stack[-2]}"
			operand2="${stack[-1]}"
			stack=("${stack[@]:0:(${#stack[@]}-2)}")
			result=$(substract "$operand1" "$operand2")
			stack+=("$result")
		#STDERR
		else
				echo -e "${BRed}Error : Insufficient operands for subtraction.${NC}"
		fi
	;;
    "*"|"mul"|"multiply")
		if [ ${#stack[@]} -ge 2 ]; then
			#last operand before + sign
			operand1="${stack[-1]}"
			operand2="${stack[-2]}"

			stack=("${stack[@]:0:(${#stack[@]}-2)}")

			result=$(multiply "$operand1" "$operand2")
				stack+=("$result")
		#STDERR
		else
			echo -e "${BRed}Error : Insufficient operands for multiplication${NC}"
		fi
	;;
    	"/"|"div")
		#anti divide by 0 STDERR
		if [ "${stack[-1]}" == 0 ]; then
			echo -e "${BRed}why the f@!# do u divide by 0 ??????${NC}"
		fi

		if [ ${#stack[@]} -ge 2 ]; then
			# n-2 divided by -1
			operand1="${stack[-2]}"
			operand2="${stack[-1]}"
			stack=("${stack[@]:0:(${#stack[@]}-2)}")
			result=$(divide "$operand1" "$operand2")
				stack+=("$result")
		else
			echo -e "${BRed}Error : Insufficient operands for division${NC}"
		fi
	;;
    "%"|"m"|"modulo")
		if [ ${#stack[@]} -ge 2 ]; then
			# n-2 divided by n-1
			operand1="${stack[-2]}"
			operand2="${stack[-1]}"

			stack=("${stack[@]:0:(${#stack[@]}-2)}")
			result=$(modulo "$operand1" "$operand2")
				stack+=("$result")
		else
			echo -e "${BRed}Error : Insufficient operands for modulo${NC}"
		fi
	;;
    "^"|"power"|"**")
		if [ ${#stack[@]} -ge 2 ]; then
			# n-2 power n-1
			operand1="${stack[-2]}"
			operand2="${stack[-1]}"

			stack=("${stack[@]:0:(${#stack[@]}-2)}")
			result=$(power "$operand1" "$operand2")
				stack+=("$result")
		else
			echo -e "${BRed}Error : Insufficient operands for power${NC}"
		fi
	;;
    "q"|"quit"|"exit")
		echo -e "${BPurple}Exiting..........${NC}\n"
		figlet "BYEBYE"
		exit 0
    ;;
   	#sum all the elements in the stack and push it to the stack
    "sum"|"somme")
    	sum
	;;
	 "help"|"usage")
	    usage
	;;	
	#stack dump in stdout
    "dump"|"d"|"stack")
		#for each elements in the stack
		for item in "${stack[@]}"; do
				echo -e "${BCyan}$item${NC}"
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
			echo -e "${BRed}Error : Insufficient operands for duplicate${NC}"
		fi
		;;
		#default
		*)
		#STDERR
		#regex negative number and float
		if [[ "$input" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
			stack+=("$input")
		else
				echo -e "${BRed}Error : Invalid input. Not an integer, float or a sign${NC}\n"
				usage
			fi
        ;;
	esac
done
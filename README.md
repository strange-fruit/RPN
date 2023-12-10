  
  

<div align="center">

  

<h3 align="center">BASH RPN Calculator</h3>

  

<p align="center">

School project for my BSc

<br />

<br />

:D

</p>

</div>

  
  
  

## About The Project

  
  

This project comes from my bash courses in my BSc.

  

### Built With

  

Raw BASH

  

## Getting Started

  

Download it :

  

```bash
git clone https://github.com/strange-fruit/RPN
```

  

```bash
cd RPN/
```

### Prerequisites


You just need to install **bc** and **figlet**

```bash
sudo apt install bc figlet
```

  

Start the program

```bash
bash rpn.sh
```

or

```bash
./rpn.sh
```

  

Make sure the program is executable, if not :

```bash
chmod +x rpn.sh
```

## Usage

  
The program run without arguments. Therefore, if you want to see the usage, enter the program and type `help` or `usage`
  
Here is a sample of the usage. As you can see, it handles float and negative number
 

```bash
┌──(kali㉿kali)-[~/my/directory/RPN]

└─$ bash rpn.sh
  ____ ___ _____   _   _ ____  _____ ____    __  
 / ___|_ _|_   _| | | | / ___|| ____|  _ \   \ \ 
| |  _ | |  | |   | | | \___ \|  _| | |_) | (_) |
| |_| || |  | |   | |_| |___) | |___|  _ <   _| |
 \____|___| |_|    \___/|____/|_____|_| \_\ (_) |
                                             /_/ 
[+] >>> 53

[+] >>> 854

[+] >>> add

[+] >>> dump

907

[+] >>> -5436

[+] >>> 7.34

[+] >>> sum

[+] >>> dump

-4521.66

[+] >>> dup

[+] >>> dump

-4521.66

-4521.66

[+] >>> 5

[+] >>> swap

[+] >>> dump

-4521.66

5

-4521.66
```

#### Features :

  

**Add** | **+** : Add the n-2 to the n-1.

  

**Substract** | **sub** | **-** : Substract the n-1 to the n-2

  

**Multiply** | mul | **`*`** : Multiply the n-2 by the n-1.

  

**Division** | **div** | **/** : Divide the n-2 digit by the n-1.

  

**Modulo** | **m** | **%** : Modulo operation.

  

**Power** | **^** | **``**``** : Power operation.

  

**Quit** | **exit** | **q** : Quit the program.

  

**sum** | **somme** : Add all the numbers in the stack.

  

**dump** | **d** | **stack** : Print the stack in the terminal.

  

**swap** : Swap the last numbers entered.

  

**clear** | **drop** : Clear the stack, reset to 0.

  

**dup** : Duplicate the last number entered.

  
  

Arrow up and Arrow down are handled :)

  
  

## Notes

  

```bash

-11962.26

[+] >>> dup

[+] >>> power

Runtime warning (func=(main), adr=23): non-zero scale in exponent

```

If there's a logical error in your calcul, it may print this.

  

If you want to compute big equations, you may want to change the language and you computer.

  
  

## Contributing

  

Feel free to contribute. Do what you want with this project :)

  
  

## License

  

Distributed under the GNU GPLv3 License. See `LICENSE` for more information.

  
  

## Contact

  

Autéqia

  

Project Link: https://github.com/strange-fruit/bashRPN

  
  

## Author :

  

Nicolas M

# Arduino Makefile

Make file for compile arduino projects and edit in Netbeans C++

## CAUTION
### Use at your own risk

## For use:
	In ubuntu you must install some packages for compilatons, gcc-avr, avr-libc
	in terminal:
	  sudo apt install gcc-avr avr-libc

## How use: 
	make 		- compile project
	make clean  	- clean project
	make upload 	- upload hex file to arduino

## How setup:
	Change in Makefile ARDUINOMK with your arduino
	support only Nano(atmega328p).
	If your arduino different of nano,
	add file {your_platform_name}.mk in env dir
	by sample of nano3.mk, and edit his as your arduino specific

## Netbeans
	You may open this project in Netbeans C++ 8.2

# Arduino Makefile

Make file for compile arduino projects

## CAUTION
## Use at your own risk

## For use:
	install avr-gcc, avr-g++, avr-obj and etc...

## How use: 
	make 		- compile project
	make clean  - clean project
	make upload - upload hex file to arduino

## How setup:
	Change in Makefile ARDUINOMK with your arduino
	support only Nano(atmega328p).
	If your arduino different of nano,
	add file {your_platform_name}.mk in env dir
	how nano3.mk, and edit his as your arduino specific

## Netbeans
	You may open this project in Netbeans C++ 8.0.2 or later